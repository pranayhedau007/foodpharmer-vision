import { useState, Component } from 'react'
import ImageUpload from './components/ImageUpload/ImageUpload'
import Results from './components/Results/Results'
import styles from './App.module.css'

class ErrorBoundary extends Component {
  constructor(props) {
    super(props)
    this.state = { error: null }
  }
  static getDerivedStateFromError(err) {
    return { error: err.message }
  }
  render() {
    if (this.state.error) {
      return (
        <div className={styles.error}>
          Results display error: {this.state.error}
        </div>
      )
    }
    return this.props.children
  }
}

export default function App() {
  const [nutritionFile, setNutritionFile] = useState(null)
  const [ingredientsFile, setIngredientsFile] = useState(null)
  const [loading, setLoading] = useState(false)
  const [result, setResult] = useState(null)
  const [error, setError] = useState(null)

  const canSubmit = nutritionFile && ingredientsFile && !loading

  async function handleAnalyze() {
    if (!canSubmit) return
    setLoading(true)
    setError(null)
    setResult(null)

    const form = new FormData()
    form.append('nutrition_image', nutritionFile)
    form.append('ingredients_image', ingredientsFile)

    try {
      const res = await fetch('/scan', { method: 'POST', body: form })
      const text = await res.text()
      if (!res.ok) {
        let detail = `Server error ${res.status}`
        try { detail = JSON.parse(text).detail ?? detail } catch {}
        throw new Error(detail)
      }
      setResult(JSON.parse(text))
    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  function handleReset() {
    setNutritionFile(null)
    setIngredientsFile(null)
    setResult(null)
    setError(null)
  }

  return (
    <div className={styles.page}>
      <header className={styles.header}>
        <h1 className={styles.title}>Food Pharmer</h1>
        <p className={styles.subtitle}>Upload a food label to get a health score</p>
      </header>

      {error && <p className={styles.error}>{error}</p>}

      {!result ? (
        <main className={styles.uploadSection}>
          <div className={styles.uploadGrid}>
            <ImageUpload
              label="Nutrition Facts"
              hint="Photo of the nutrition panel"
              file={nutritionFile}
              onChange={setNutritionFile}
            />
            <ImageUpload
              label="Ingredients"
              hint="Photo of the ingredients list"
              file={ingredientsFile}
              onChange={setIngredientsFile}
            />
          </div>

          <button
            className={styles.analyzeBtn}
            onClick={handleAnalyze}
            disabled={!canSubmit}
          >
            {loading ? <span className={styles.spinner} /> : 'Analyze'}
          </button>

          {loading && (
            <p className={styles.loadingHint}>
              Running OCR and scoring — this takes about 10–20 seconds…
            </p>
          )}
        </main>
      ) : (
        <main className={styles.resultsSection}>
          <ErrorBoundary>
            <Results result={result} />
          </ErrorBoundary>
          <button className={styles.resetBtn} onClick={handleReset}>
            Analyze another product
          </button>
        </main>
      )}
    </div>
  )
}
