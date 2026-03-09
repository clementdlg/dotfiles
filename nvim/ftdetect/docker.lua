vim.filetype.add {
  pattern = {
    ['docker-compose.*%.yml'] = 'yaml.docker-compose', -- docker-compose.yml or docker-compose.override.yml
    ['docker-compose.*%.yaml'] = 'yaml.docker-compose',
    ['compose.yaml'] = 'yaml.docker-compose',
  },
}

vim.filetype.add {
  pattern = {
    ['dockerfile.*'] = 'dockerfile', -- matches dockerfile.* files
    ['.+%.dockerfile$'] = 'dockerfile', -- matches anything ending with .dockerfile
  },
}
