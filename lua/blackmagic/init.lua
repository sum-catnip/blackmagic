local luv = require("blackmagic.hsluv")

local M = {}

function M.setup(_)
	-- just for testing
	M.load()
end

local HSLuv = {}
HSLuv.__index = HSLuv
function HSLuv.new(h, s, l)
	local self = setmetatable({}, HSLuv)
	self.h = h
	self.s = s
	self.l = l
	return self
end

function HSLuv.hex(self)
	return luv.hsluv_to_hex({ self.h, self.s, self.l })
end

function HSLuv.clone(self)
	return HSLuv.new(self.h, self.s, self.l)
end

function HSLuv.with_h(self, h)
	return HSLuv.new(h, self.s, self.l)
end

function HSLuv.with_s(self, s)
	return HSLuv.new(self.h, s, self.l)
end

function HSLuv.with_l(self, l)
	return HSLuv.new(self.h, self.s, l)
end

function HSLuv.add_h(self, h)
	return HSLuv.new(self.h + h, self.s, self.l)
end

function HSLuv.add_s(self, s)
	return HSLuv.new(self.h, self.s + s, self.l)
end

function HSLuv.add_l(self, l)
	return HSLuv.new(self.h, self.s, self.l + l)
end

-- lets make functions purple, maybe even with a bg or underline
-- and keyworld slithtly more subtle magic
-- because theyre very important and kinda the place where the magic happens (interacting with external stuff)
-- blue for logic stuff like bools seems fitting
-- biggest question is what to use for variables

local test = HSLuv.new(12, 100, 45)

local magic = HSLuv.new(295, 100, 50)
local black = magic:with_l(0)
local blackmesa = HSLuv.new(30, 97, 66)

local cloud = HSLuv.new(180, 11, 90)
local emphasis = magic:with_h(3)
--local green = magic:with_h(150)
local pink = magic:with_h(350)
local mint = HSLuv.new(140, 100, 85)

-- the major color types are:
-- magic for functions
-- blackmesa for types and variables (maybe i gotta separate them into orange and yellow
-- logic for control flow, bools and probably maffs

--local func = magic
local func = blackmesa
--local type = blackmesa
local type = magic

--local data = blackmesa:with_l(75)
--local data = blackmesa:with_h(40)
local data = type:add_h(-10)
local logic = type:with_h(265)

local meta = func:add_s(-30)

-- test
function M.load()
	--print("yeet")
	local highlight_group = vim.api.nvim_create_augroup("ThemeReload", { clear = true })
	vim.api.nvim_create_autocmd("BufWritePost", {
		command = "Lazy reload blackmagic",
		group = highlight_group,
		pattern = "*blackmagic/init.lua",
	})

	local x = true
	local x = false
	local x = 0
	local x = 0.0
	local x = 1.2
	local x = "kektop"
	if x == "pupsmann" then
		return
	end

	vim.cmd.hi("clear")
	-- todo: put this in config
	vim.o.guifont = "GeistMono Nerd Font Mono"
	-- basic syntax
	vim.api.nvim_set_hl(0, "Normal", { fg = cloud:hex(), bg = black:hex() })
	vim.api.nvim_set_hl(0, "Comment", { fg = emphasis:hex(), bg = emphasis:with_l(2):hex() })
	vim.api.nvim_set_hl(0, "Constant", { fg = data:add_l(-10):hex() })
	vim.api.nvim_set_hl(0, "Number", { fg = logic:hex() })
	vim.api.nvim_set_hl(0, "Float", { fg = logic:add_l(10):hex() })
	vim.api.nvim_set_hl(0, "Boolean", { fg = logic:hex() })
	vim.api.nvim_set_hl(0, "String", { fg = emphasis:with_s(70):hex() })
	vim.api.nvim_set_hl(0, "Function", { fg = func:hex(), bg = func:with_l(2):hex() })

	vim.api.nvim_set_hl(0, "Statement", { fg = test:hex() })
	vim.api.nvim_set_hl(0, "Conditional", { fg = logic:hex() })
	vim.api.nvim_set_hl(0, "Repeat", { fg = logic:hex() })
	vim.api.nvim_set_hl(0, "Label", { fg = logic:hex() })

	vim.api.nvim_set_hl(0, "Operator", { fg = logic:hex() })
	vim.api.nvim_set_hl(0, "Keyword", { fg = func:with_h(275):hex() })
	vim.api.nvim_set_hl(0, "Exception", { fg = logic:hex() })

	-- todo: to be tested
	vim.api.nvim_set_hl(0, "PreProc", { fg = test:hex() })
	vim.api.nvim_set_hl(0, "Include", { fg = test:hex() })
	vim.api.nvim_set_hl(0, "Define", { fg = test:hex() })
	vim.api.nvim_set_hl(0, "Macro", { fg = test:hex() })
	vim.api.nvim_set_hl(0, "PreCondit", { fg = test:hex() })

	-- different types of types
	vim.api.nvim_set_hl(0, "Type", { fg = type:hex(), bg = type:with_l(3):hex() })
	vim.api.nvim_set_hl(0, "Structure", { link = "Type" })
	vim.api.nvim_set_hl(0, "Typedef", { link = "Typedef" })
	-- type qualifiers like "static"
	vim.api.nvim_set_hl(0, "StorageClass", { fg = type:add_l(10):hex() })

	vim.api.nvim_set_hl(0, "Identifier", { fg = data:with_l(75):hex() })

	vim.api.nvim_set_hl(0, "Special", { fg = type:hex() })
	vim.api.nvim_set_hl(0, "SpecialChar", { fg = type:hex() })
	vim.api.nvim_set_hl(0, "Tag", { underline = true })
	vim.api.nvim_set_hl(0, "Delimiter", { fg = pink:add_s(-20):hex() })
	vim.api.nvim_set_hl(0, "SpecialComment", { bold = true })
	vim.api.nvim_set_hl(0, "Debug", { bg = logic:with_l(5):hex() })

	vim.api.nvim_set_hl(0, "Underlined", { underline = true })
	vim.api.nvim_set_hl(0, "Ignore", { strikethrough = true })
	vim.api.nvim_set_hl(0, "Error", { link = "Comment" })
	vim.api.nvim_set_hl(0, "Todo", { link = "Comment" })

	vim.api.nvim_set_hl(0, "Added", { fg = mint:with_s(60):hex() })
	vim.api.nvim_set_hl(0, "Changed", { fg = logic:hex() })
	vim.api.nvim_set_hl(0, "Removed", { fg = emphasis:hex() })

	-- treesitter
	vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })
	vim.api.nvim_set_hl(0, "@variable.member", { fg = data:add_s(-10):hex() })
	vim.api.nvim_set_hl(0, "@variable.builtin", { fg = data:hex() })

	vim.api.nvim_set_hl(0, "@variable.parameter", { fg = func:add_l(10):hex() })
	vim.api.nvim_set_hl(0, "@variable.parameter.builtin", { fg = func:add_l(10):hex() })

	vim.api.nvim_set_hl(0, "@constant", { link = "Constant" })
	vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Constant" })
	vim.api.nvim_set_hl(0, "@constant.macro", { link = "Constant" })

	vim.api.nvim_set_hl(0, "@module", { fg = func:hex() })
	vim.api.nvim_set_hl(0, "@module.builtin", { fg = func:hex() })
	vim.api.nvim_set_hl(0, "@label", { fg = logic:hex() })

	vim.api.nvim_set_hl(0, "@string", { link = "String" })
	vim.api.nvim_set_hl(0, "@string.documentation", { link = "Comment" })
	vim.api.nvim_set_hl(0, "@string.regexp", { fg = logic:hex() })
	vim.api.nvim_set_hl(0, "@string.escape", { link = "@string.regexp" })
	vim.api.nvim_set_hl(0, "@string.special", { link = "@string.escape" })
	vim.api.nvim_set_hl(0, "@string.special.symbol", { link = "@string.escape" })
	vim.api.nvim_set_hl(0, "@string.path", { fg = func:hex(), underline = true })
	vim.api.nvim_set_hl(0, "@string.url", { fg = func:hex(), underline = true })

	vim.api.nvim_set_hl(0, "@character", { fg = emphasis:with_s(100):hex() })
	vim.api.nvim_set_hl(0, "@character.special", { fg = emphasis:with_s(100):hex() })

	vim.api.nvim_set_hl(0, "@boolean", { link = "Boolean" })
	vim.api.nvim_set_hl(0, "@number", { link = "Number" })
	vim.api.nvim_set_hl(0, "@number.float", { link = "Float" })

	vim.api.nvim_set_hl(0, "@type", { link = "Type" })
	vim.api.nvim_set_hl(0, "@type.builtin", { link = "Type" })
	vim.api.nvim_set_hl(0, "@type.definition", { fg = type:hex() })

	vim.api.nvim_set_hl(0, "@attribute", { fg = meta:hex() })
	vim.api.nvim_set_hl(0, "@attribute.builtin", { fg = meta:hex() })

	vim.api.nvim_set_hl(0, "@property", { link = "@variable.member" })

	vim.api.nvim_set_hl(0, "@function", { link = "Function" })
	vim.api.nvim_set_hl(0, "@function.builtin", { link = "Function" })
	vim.api.nvim_set_hl(0, "@function.call", { link = "Function" })
	vim.api.nvim_set_hl(0, "@function.macro", { fg = meta:hex() })

	vim.api.nvim_set_hl(0, "@function.method", { link = "Function" })
	vim.api.nvim_set_hl(0, "@function.method.call", { link = "@function.method" })

	-- todo: maybe make the bg shine more or smth
	-- i generaally need more variance with the functions
	vim.api.nvim_set_hl(0, "@constructor", { link = "@function.method" })
	vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })

	vim.api.nvim_set_hl(0, "@keyword", { link = "Keyword" })
	vim.api.nvim_set_hl(0, "@keyword.coroutine", { fg = meta:hex() })
	vim.api.nvim_set_hl(0, "@keyword.function", { fg = func:hex() })
	vim.api.nvim_set_hl(0, "@keyword.operator", { fg = logic:hex() })
	vim.api.nvim_set_hl(0, "@keyword.import", { fg = func:hex() })
	vim.api.nvim_set_hl(0, "@keyword.type", { fg = type:hex() })
	vim.api.nvim_set_hl(0, "@keyword.modifier", { fg = type:add_s(-30):hex() })
	vim.api.nvim_set_hl(0, "@keyword.repeat", { fg = logic:hex() })
	vim.api.nvim_set_hl(0, "@keyword.return", { fg = func:hex() })
	vim.api.nvim_set_hl(0, "@keyword.debug", { fg = emphasis:hex() })
	vim.api.nvim_set_hl(0, "@keyword.exception", { link = "Exception" })
	vim.api.nvim_set_hl(0, "@keyword.conditional", { fg = logic:hex() })
	vim.api.nvim_set_hl(0, "@keyword.conditional.ternary", { fg = logic:hex() })

	vim.api.nvim_set_hl(0, "@keyword.directive", { fg = meta:hex() })
	vim.api.nvim_set_hl(0, "@keyword.directive.define", { fg = meta:hex() })

	vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
	vim.api.nvim_set_hl(0, "@comment.documentation", { link = "Comment" })
	vim.api.nvim_set_hl(0, "@comment.error", { link = "Comment", underline = true })
	vim.api.nvim_set_hl(0, "@comment.warning", { link = "Comment", underline = true })
	vim.api.nvim_set_hl(0, "@comment.todo", { link = "Comment" })
	vim.api.nvim_set_hl(0, "@comment.note", { link = "Comment" })

	-- semantic
	vim.api.nvim_set_hl(0, "@lsp.type.function", { link = "Function" })
	vim.api.nvim_set_hl(0, "@lsp.type.struct", { link = "Structure" })
	vim.api.nvim_set_hl(0, "@lsp.type.parameter", { link = "@variable.parameter" })
	vim.api.nvim_set_hl(0, "@lsp.type.macro", { link = "@function.macro" })
	vim.api.nvim_set_hl(0, "@lsp.type.macro", { link = "@function.macro" })
end

return M
