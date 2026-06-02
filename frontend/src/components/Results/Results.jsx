import { useState, useEffect, useCallback } from 'react'
import styles from './Results.module.css'

const GRADE_COLOR = { A: '#27ae60', B: '#2ecc71', C: '#f39c12', D: '#e67e22', E: '#e74c3c', F: '#c0392b' }

const QUALITY_COLOR = { good: '#27ae60', medium: '#f39c12', bad: '#c0392b', unknown: '#888' }

function getPopupStyle(rect) {
  const POPUP_W = 300
  const MARGIN = 8
  const left = Math.max(MARGIN, Math.min(rect.left, window.innerWidth - POPUP_W - MARGIN))
  const spaceBelow = window.innerHeight - rect.bottom - MARGIN
  const spaceAbove = rect.top - MARGIN

  if (spaceBelow >= spaceAbove) {
    return { top: rect.bottom + MARGIN, left, width: POPUP_W, maxHeight: Math.max(120, spaceBelow) }
  }
  return { bottom: window.innerHeight - rect.top + MARGIN, left, width: POPUP_W, maxHeight: Math.max(120, spaceAbove) }
}

export default function Results({ result }) {
  const { score, xgb_score, grade, red_flags = [], ingredients = [], nutrition = {}, allergens = [], ocr_reliability } = result
  const displayScore = xgb_score ?? score
  const gradeColor = GRADE_COLOR[grade?.toUpperCase()] ?? '#888'

  const photoQuality = ocr_reliability?.photo_quality
  const fieldConfidence = ocr_reliability?.field_confidence

  const [popup, setPopup] = useState(null)
  const [flagPopup, setFlagPopup] = useState(null)

  const handleIngredientClick = useCallback(async (e, ing) => {
    setFlagPopup(null)
    if (popup?.name === ing) { setPopup(null); return }
    const rect = e.currentTarget.getBoundingClientRect()
    setPopup({ name: ing, rect, loading: true, canonical: null, infoData: null, error: null })

    try {
      const res = await fetch(`/ingredient-info?name=${encodeURIComponent(ing)}`)
      if (!res.ok) throw new Error('Request failed')
      const data = await res.json()
      setPopup(prev =>
        prev?.name === ing
          ? { ...prev, loading: false, canonical: data.canonical_name, infoData: data.info }
          : prev
      )
    } catch {
      setPopup(prev =>
        prev?.name === ing
          ? { ...prev, loading: false, error: 'Could not load ingredient information.' }
          : prev
      )
    }
  }, [popup])

  const handleFlagClick = useCallback(async (e, flag) => {
    setPopup(null)
    if (flagPopup?.name === flag.name) { setFlagPopup(null); return }
    const rect = e.currentTarget.getBoundingClientRect()
    setFlagPopup({ name: flag.name, reason: flag.reason, rect, loading: true, explanation: null, error: null })

    try {
      const res = await fetch(`/red-flag-info?name=${encodeURIComponent(flag.name)}`)
      if (!res.ok) throw new Error('Request failed')
      const data = await res.json()
      setFlagPopup(prev =>
        prev?.name === flag.name
          ? { ...prev, loading: false, explanation: data.explanation }
          : prev
      )
    } catch {
      setFlagPopup(prev =>
        prev?.name === flag.name
          ? { ...prev, loading: false, error: 'Could not load explanation.' }
          : prev
      )
    }
  }, [flagPopup])

  useEffect(() => {
    if (!popup && !flagPopup) return
    const onKey = (e) => { if (e.key === 'Escape') { setPopup(null); setFlagPopup(null) } }
    document.addEventListener('keydown', onKey)
    return () => document.removeEventListener('keydown', onKey)
  }, [popup, flagPopup])

  return (
    <div className={styles.container}>
      {/* Score row */}
      <div className={styles.scoreRow}>
        <div className={styles.scoreCircle} style={{ '--color': gradeColor }}>
          <span className={styles.scoreNumber}>{Math.round(displayScore)}</span>
          <span className={styles.scoreLabel}>/ 100</span>
        </div>
        <div className={styles.scoreInfo}>
          <div className={styles.grade} style={{ background: gradeColor }}>Grade {grade}</div>
          {red_flags.length > 0 && (
            <div className={styles.redFlags}>
              <p className={styles.sectionTitle}>Red flags</p>
              <ul className={styles.flagList}>
                {red_flags.map((f, i) => (
                  <li
                    key={i}
                    className={`${styles[`flag_${f.severity}`] ?? ''} ${flagPopup?.name === f.name ? styles.flagActive : ''}`}
                    onClick={(e) => handleFlagClick(e, f)}
                  >
                    {f.name} <span className={styles.flagHint}>?</span>
                  </li>
                ))}
              </ul>
            </div>
          )}
          {red_flags.length === 0 && (
            <p className={styles.noFlags}>No major red flags detected</p>
          )}
        </div>
      </div>

      {/* OCR Reliability */}
      {ocr_reliability && (
        <section className={styles.section}>
          <h2 className={styles.sectionTitle}>OCR Reliability</h2>
          <div className={styles.reliabilityRow}>
            <div className={styles.reliabilityItem}>
              <span className={styles.reliabilityLabel}>Photo quality</span>
              <span
                className={styles.reliabilityValue}
                style={{ color: QUALITY_COLOR[photoQuality?.label] ?? '#888' }}
              >
                {photoQuality?.message ?? 'Photo quality unavailable'}
              </span>
            </div>
            <div className={styles.reliabilityItem}>
              <span className={styles.reliabilityLabel}>OCR confidence</span>
              <span className={styles.reliabilityValue}>
                {fieldConfidence?.overall_confidence_percent != null
                  ? `${Math.round(fieldConfidence.overall_confidence_percent)}%`
                  : fieldConfidence?.message ?? 'unavailable'}
              </span>
            </div>
          </div>
        </section>
      )}

      {/* Nutrition */}
      {Object.keys(nutrition).length > 0 && (
        <section className={styles.section}>
          <h2 className={styles.sectionTitle}>Nutrition Facts</h2>
          <table className={styles.table}>
            <tbody>
              {Object.entries(nutrition).map(([key, val]) => (
                <tr key={key}>
                  <td className={styles.nutrientName}>{key.replace(/_/g, ' ')}</td>
                  <td className={styles.nutrientVal}>{val}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </section>
      )}

      {/* Allergens */}
      <section className={styles.section}>
        <h2 className={styles.sectionTitle}>Potential Allergens</h2>
        {allergens.length > 0 ? (
          <ul className={styles.ingredientList}>
            {allergens.map((a, i) => (
              <li key={i} className={styles.allergenChip}>{a}</li>
            ))}
          </ul>
        ) : (
          <p className={styles.noAllergens}>No known allergens detected</p>
        )}
      </section>

      {/* Ingredients */}
      {ingredients.length > 0 && (
        <section className={styles.section}>
          <h2 className={styles.sectionTitle}>Ingredients ({ingredients.length})</h2>
          <p className={styles.ingredientHint}>Click any ingredient for details</p>
          <ul className={styles.ingredientList}>
            {ingredients.map((ing, i) => (
              <li
                key={i}
                className={`${styles.ingredient} ${popup?.name === ing ? styles.ingredientActive : ''}`}
                onClick={(e) => handleIngredientClick(e, ing)}
              >
                {ing}
              </li>
            ))}
          </ul>
        </section>
      )}

      {/* Red flag explanation popup */}
      {flagPopup && (
        <>
          <div className={styles.popupOverlay} onClick={() => setFlagPopup(null)} />
          <div className={styles.popup} style={getPopupStyle(flagPopup.rect)}>
            <div className={styles.popupHeader}>
              <div className={styles.popupTitle}>{flagPopup.name}</div>
              <button className={styles.popupClose} onClick={() => setFlagPopup(null)}>×</button>
            </div>
            {flagPopup.reason && (
              <div className={styles.popupSection}>
                <span className={styles.popupSectionLabel}>Summary</span>
                <p>{flagPopup.reason}</p>
              </div>
            )}
            <div className={styles.popupSection}>
              <span className={styles.popupSectionLabel}>Why this matters</span>
              {flagPopup.loading && <div className={styles.popupLoading}>Loading…</div>}
              {flagPopup.error && <div className={styles.popupError}>{flagPopup.error}</div>}
              {flagPopup.explanation && <p>{flagPopup.explanation}</p>}
            </div>
          </div>
        </>
      )}

      {/* Ingredient info popup */}
      {popup && (
        <>
          <div className={styles.popupOverlay} onClick={() => setPopup(null)} />
          <div className={styles.popup} style={getPopupStyle(popup.rect)}>
            <div className={styles.popupHeader}>
              <div>
                <div className={styles.popupTitle}>{popup.name}</div>
                {popup.canonical && popup.canonical.toLowerCase() !== popup.name.toLowerCase() && (
                  <div className={styles.popupCanonical}>Canonical: {popup.canonical}</div>
                )}
              </div>
              <button className={styles.popupClose} onClick={() => setPopup(null)}>×</button>
            </div>

            {popup.loading && <div className={styles.popupLoading}>Loading…</div>}
            {popup.error && <div className={styles.popupError}>{popup.error}</div>}

            {popup.infoData && !popup.loading && (
              <div className={styles.popupBody}>
                {popup.infoData.origin && (
                  <div className={styles.popupSection}>
                    <span className={styles.popupSectionLabel}>Origin</span>
                    <p>{popup.infoData.origin}</p>
                  </div>
                )}
                {popup.infoData.uses && (
                  <div className={styles.popupSection}>
                    <span className={styles.popupSectionLabel}>Uses</span>
                    <p>{popup.infoData.uses}</p>
                  </div>
                )}
                {popup.infoData.health_notes && (
                  <div className={styles.popupSection}>
                    <span className={styles.popupSectionLabel}>Health Notes</span>
                    <p>{popup.infoData.health_notes}</p>
                  </div>
                )}
              </div>
            )}
          </div>
        </>
      )}
    </div>
  )
}
