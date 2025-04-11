import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import FullReload from 'vite-plugin-full-reload'
import tailwindcss from '@tailwindcss/vite'
import StimulusHMR from 'vite-plugin-stimulus-hmr'
import vue from "@vitejs/plugin-vue";


export default defineConfig({
  plugins: [
    tailwindcss(),
    RubyPlugin(),
    FullReload(['config/routes.rb', 'app/views/**/*'], { delay: 200 }),
    StimulusHMR(),
    vue(),
  ],
  envDir: '../',
})
