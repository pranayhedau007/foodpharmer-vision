import styles from './Results.module.css'

const GRADE_COLOR = { A: '#27ae60', B: '#2ecc71', C: '#f39c12', D: '#e67e22', E: '#e74c3c', F: '#c0392b' }

const QUALITY_COLOR = { good: '#27ae60', medium: '#f39c12', bad: '#c0392b', unknown: '#888' }

export default function Results({ result }) {
  const { score, xgb_score, grade, red_flags = [], ingredients = [], nutrition = {}, allergens = [], ocr_reliability } = result
  const displayScore = xgb_score ?? score
  const gradeColor = GRADE_COLOR[grade?.toUpperCase()] ?? '#888'

  const photoQuality = ocr_reliability?.photo_quality
  const fieldConfidence = ocr_reliability?.field_confidence

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
                  <li key={i} className={styles[`flag_${f.severity}`] ?? ''} title={f.reason}>
                    {f.name}
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
          <ul className={styles.ingredientList}>
            {ingredients.map((ing, i) => (
              <li key={i} className={styles.ingredient}>{ing}</li>
            ))}
          </ul>
        </section>
      )}
    </div>
  )
}
