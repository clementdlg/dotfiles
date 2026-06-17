local statusline = require('mini.statusline')

statusline.setup({
  use_icons = true,
})

-- Override the location section
statusline.section_location = function()
  return '%2l:%-2v'
end
