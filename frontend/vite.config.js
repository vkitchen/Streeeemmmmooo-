import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import WindiCSS from 'vite-plugin-windicss'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    WindiCSS(),
  ],
  server: {
    port: 8000,
    proxy: {
      '/results': 'http://127.0.0.1:3000',
    },
  }
})
