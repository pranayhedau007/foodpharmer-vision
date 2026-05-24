import { useRef, useState } from 'react'
import styles from './ImageUpload.module.css'

export default function ImageUpload({ label, hint, file, onChange }) {
  const inputRef = useRef(null)
  const [dragging, setDragging] = useState(false)

  const previewUrl = file ? URL.createObjectURL(file) : null

  function handleFile(f) {
    if (f && f.type.startsWith('image/')) onChange(f)
  }

  function onDrop(e) {
    e.preventDefault()
    setDragging(false)
    handleFile(e.dataTransfer.files[0])
  }

  return (
    <div
      className={`${styles.zone} ${dragging ? styles.dragging : ''} ${file ? styles.filled : ''}`}
      onClick={() => !file && inputRef.current.click()}
      onDragOver={(e) => { e.preventDefault(); setDragging(true) }}
      onDragLeave={() => setDragging(false)}
      onDrop={onDrop}
    >
      <input
        ref={inputRef}
        type="file"
        accept="image/*"
        className={styles.hidden}
        onChange={(e) => handleFile(e.target.files[0])}
      />

      {file ? (
        <div className={styles.preview}>
          <img src={previewUrl} alt={label} className={styles.previewImg} />
          <div className={styles.previewOverlay}>
            <span className={styles.fileName}>{file.name}</span>
            <button
              className={styles.changeBtn}
              onClick={(e) => { e.stopPropagation(); inputRef.current.click() }}
            >
              Change
            </button>
          </div>
        </div>
      ) : (
        <div className={styles.placeholder}>
          <div className={styles.icon}>
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5">
              <rect x="3" y="3" width="18" height="18" rx="2" />
              <circle cx="8.5" cy="8.5" r="1.5" />
              <polyline points="21 15 16 10 5 21" />
            </svg>
          </div>
          <p className={styles.labelText}>{label}</p>
          <p className={styles.hintText}>{hint}</p>
          <span className={styles.cta}>Click or drag to upload</span>
        </div>
      )}
    </div>
  )
}
