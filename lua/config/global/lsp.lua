local M = {
	utils = {
		eslint_config_names = {
			"eslint.config.ts",
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs",

			".eslintrc.ts",
			".eslintrc.js",
			".eslintrc.mjs",
			".eslintrc.cjs",

			".eslintrc.yaml",
			".eslintrc.yml",

			".eslintrc.json",
			".eslintrc.json5",
		},

		prettier_config_names = {
			".prettierrc",

			".prettierrc.json",
			".prettierrc.json5",

			".prettierrc.yml",
			".prettierrc.yaml",

			".prettierrc.ts",
			".prettierrc.js",
			".prettierrc.cjs",
			".prettierrc.mjs",

			"prettier.config.ts",
			"prettier.config.js",
			"prettier.config.cjs",
			"prettier.config.mjs",

			".prettierrc.toml",
		},

		tailwind_config_names = {
			"tailwind.config.ts",
			"tailwind.config.js",
			"tailwind.config.cjs",
			"tailwind.config.mjs",
		},
	},
}

return M
