return {
	settings = {
		["rust_analyzer"] = {
			cargo = {
				loadOutDirsFromCheck = true,
			},
			checkOnSave = {
				command = "clippy",
			},
			experimental = {
				procAttrMacros = true,
			},
		},
	},
}
