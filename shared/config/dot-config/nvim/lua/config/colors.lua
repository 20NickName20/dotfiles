local set_hl = vim.api.nvim_set_hl

set_hl(0, "LineNr", { fg = "#d2cd62", bold = false })

set_hl(0, "@comment", { fg = "#b2c6bf" })
set_hl(0, "Todo", { fg = "#f2d090", bold = true } )

set_hl(0, "Include", { fg = "#df80ff", bold = true } )

set_hl(0, "String", { fg = "#abd6bf" })
set_hl(0, "rustString", { fg = "#abd6bf" })
set_hl(0, "@string", { fg = "#abd6bf" })
set_hl(0, "Number", { fg = "#d1c6f5" })

set_hl(0, "rustSelf", { fg = "#f04076", bold = true })
set_hl(0, "@lsp.type.typeAlias.rust",   { fg = "#dff099" })
set_hl(0, "rustExternCrate",   { fg = "#dff099" })
set_hl(0, "rustPubScopeCrate",   { fg = "#dff099" })
set_hl(0, "rustSuper",   { fg = "#dff099" })

set_hl(0, "Function", { fg = "#80d1ff" })
set_hl(0, "rustMacro", { fg = "#70d7f0" })
set_hl(0, "@type", { fg = "#f0df99" })
set_hl(0, "@lsp.type.builtinType.rust", { fg = "#dff090" })

set_hl(0, "Keyword", { fg = "#df80ff" })
set_hl(0, "Statement", { fg = "#df80ff" })
set_hl(0, "rustStorage", { fg = "#df80ff" })
set_hl(0, "rustSigil", { fg = "#b0aabf" })
set_hl(0, "Constant", { fg = "#bad1dd" })

set_hl(0, "Directory", { fg = "#afcfff" })
set_hl(0, "NvimTreeExecFile", { fg = "#afffcf" })
