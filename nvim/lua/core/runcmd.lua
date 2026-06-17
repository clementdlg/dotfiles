-- Keymaps
vim.keymap.set("n", "<leader>br", function()
  RunBuildCmd()
end, { silent = true })

vim.keymap.set("n", "<leader>bs", function()
  SetBuildCmd()
end, { silent = true })

-- Functions
function SetBuildCmd()
  local cmd = vim.fn.input("Set build cmd: ")

  if cmd == "" then
    return
  end

  vim.g.build_cmd = cmd
  vim.fn.setreg("b", cmd)
end

function RunBuildCmd()
  if not vim.g.build_cmd or vim.g.build_cmd == "" then
    vim.notify("No build cmd set. Use <leader>bs", vim.log.levels.WARN)
    return
  end

	vim.cmd("belowright terminal sh -c " .. vim.fn.escape(vim.g.build_cmd, " \\"))
end

-- Load at startup
local function LoadBuildCmd()
  local reg = vim.fn.getreg("b")
  if reg ~= "" then
    vim.g.build_cmd = reg
  end
end

-- Autocommand
vim.api.nvim_create_autocmd("VimEnter", {
  callback = LoadBuildCmd,
})
