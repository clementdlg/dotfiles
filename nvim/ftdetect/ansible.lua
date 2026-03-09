vim.filetype.add {
  pattern = {
    -- Match playbooks
    ['.*/playbooks/.*%.yml'] = 'yaml.ansible',
    -- Match roles/tasks
    ['.*/roles/.*/tasks/.*%.yml'] = 'yaml.ansible',
    -- Match handlers
    ['.*/roles/.*/handlers/.*%.yml'] = 'yaml.ansible',
  },
}
