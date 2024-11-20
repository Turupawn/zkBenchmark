import { defineConfig } from 'vite';
import copy from 'rollup-plugin-copy';
import fs from 'fs';
import path from 'path';

const wasmContentTypePlugin = {
  name: 'wasm-content-type-plugin',
  configureServer(server) {
    server.middlewares.use(async (req, res, next) => {
      if (req.url.endsWith('.wasm')) {
        res.setHeader('Content-Type', 'application/wasm');
        const newPath = req.url.replace('deps', 'dist');
        const targetPath = path.join(__dirname, newPath);
        const wasmContent = fs.readFileSync(targetPath);
        return res.end(wasmContent);
      }
      next();
    });
  },
};

export default defineConfig(({ command }) => {
  const isDev = command === 'serve';

  return {
    build: {
      outDir: 'dist',
    },
    plugins: [
      copy({
        targets: [
          { src: 'node_modules/**/*.wasm', dest: 'dist/wasm' }, // Copy to dist for production
          { src: 'path/to/snarkjs.min.js', dest: 'dist/js' },
        ],
        copySync: true,
        hook: 'writeBundle',
      }),
      isDev ? wasmContentTypePlugin : [],
    ],
  };
});
