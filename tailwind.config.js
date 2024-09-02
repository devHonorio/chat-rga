/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{js,ts,jsx,tsx,mdx}"],
  theme: {
    extend: {
      animation: {
        "bounce-chat": "bounce-chat 1s ease-in-out infinite",
        scale: "scale .5s ease normal forwards",
      },
      keyframes: {
        "bounce-chat": {
          "0%, 100%": { transform: "scale(1)" },
          "50%": { transform: "scale(1.3)" },
        },
        scale: {
          "0%": { transform: "scale(0.4)", "transform-origin": "left top" },
          "100%": { transform: "scale(1)", "transform-origin": "left top" },
        },
      },
    },
  },
  plugins: [],
};
