import styles from './Results.module.css'

const RISK_COLOR = {
  LOW:    '#27ae60',
  MEDIUM: '#f39c12',
  HIGH:   '#e74c3c',
}

export default function Results({ result }) {
  const {
    health_score,
    risk_level,
    flags = [],
    summary,
    ingredients = [],
    nutrition = {},
  } = result

  const score      = health_score ?? 0
  const risk       = risk_level?.toUpperCase() ?? 'UNKNOWN'
  const riskColor  = RISK_COLOR[risk] ?? '#888'

  return (
    <div className={styles.container}>

      {/* Score row */}
      <div className={styles.scoreRow}>
        <div className={styles.scoreCircle} style={{ '--color': riskColor }}>
          <span className={styles.scoreNumber}>{Math.round(score)}</span>
          <span className={styles.scoreLabel}>/ 100</span>
        </div>

        <div className={styles.scoreInfo}>
          <div className={styles.grade} style={{ background: riskColor }}>
            {risk} RISK
          </div>

          {summary && (
            <p className={styles.summary}>{summary}</p>
          )}

          {flags.length > 0 && (
            <div className={styles.redFlags}>
              <p className={styles.sectionTitle}>Red flags</p>
              <ul className={styles.flagList}>
                {flags.map((f, i) => (
                  <li key={i} title={f.reason}>
                    {f.ingredient}
                  </li>
                ))}
              </ul>
            </div>
          )}

          {flags.length === 0 && (
            <p className={styles.noFlags}>No major red flags detected</p>
          )}
        </div>
      </div>

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
