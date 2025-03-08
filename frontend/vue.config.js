const { defineConfig } = require('@vue/cli-service');

module.exports = defineConfig({
  transpileDependencies: true,
  devServer: {
    host: '0.0.0.0',            // Allow the dev server to be accessed externally
    port: 8080,                 // The port where Vue.js will serve the app
    allowedHosts: [
      'frontend.vue.newl.co.tz', // Allow this specific host
      'localhost',               // Allow localhost as well
    ],
    historyApiFallback: true,    // For single-page apps to handle 404s
    proxy: {
      '/api': {
        target: 'http://api.laravel.newl.co.tz', // Adjust to the backend API URL
        changeOrigin: true,
        pathRewrite: {
          '^/api': '', // Rewriting the /api path if needed
        },
      },
    },
  },
});

