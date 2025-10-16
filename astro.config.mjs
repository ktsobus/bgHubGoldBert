// @ts-check
import { defineConfig } from "astro/config";

import react from "@astrojs/react";

import tailwindcss from "@tailwindcss/vite";

// https://astro.build/config
export default defineConfig({
  site: "https://dashboard.burgi.dev",
  trailingSlash: "always",
  integrations: [react()],

  vite: {
    plugins: [tailwindcss()],
  },
});
