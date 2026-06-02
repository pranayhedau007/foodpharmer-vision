import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    proxy: {
      '/scan': 'http://localhost:8000',
      '/health': 'http://localhost:8000',
      '/ingredient-info': 'http://localhost:8000',
      '/red-flag-info': 'http://localhost:8000',
    },
  },
})
