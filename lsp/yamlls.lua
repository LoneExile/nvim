-- Load schemas immediately instead of using a function
-- Functions cannot be serialized with vim.lsp.enable()
local schemas = {}
local status, schemastore = pcall(require, 'schemastore')
if status then
  schemas = schemastore.yaml.schemas()
end

return {
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = '',
      },
      schemas = schemas,
      customTags = {
        -- AWS CloudFormation
        '!And scalar',
        '!And mapping',
        '!And sequence',
        '!If scalar',
        '!If mapping',
        '!If sequence',
        '!Not scalar',
        '!Not mapping',
        '!Not sequence',
        '!Equals scalar',
        '!Equals mapping',
        '!Equals sequence',
        '!Or scalar',
        '!Or mapping',
        '!Or sequence',
        '!FindInMap scalar',
        '!FindInMap mappping',
        '!FindInMap sequence',
        '!Base64 scalar',
        '!Base64 mapping',
        '!Base64 sequence',
        '!Cidr scalar',
        '!Cidr mapping',
        '!Cidr sequence',
        '!Ref scalar',
        '!Ref mapping',
        '!Ref sequence',
        '!Sub scalar',
        '!Sub mapping',
        '!Sub sequence',
        '!GetAtt scalar',
        '!GetAtt mapping',
        '!GetAtt sequence',
        '!GetAZs scalar',
        '!GetAZs mapping',
        '!GetAZs sequence',
        '!GetAZs',
        '!ImportValue scalar',
        '!ImportValue mapping',
        '!ImportValue sequence',
        '!Select scalar',
        '!Select mapping',
        '!Select sequence',
        '!Select',
        '!Split scalar',
        '!Split mapping',
        '!Split sequence',
        '!Join scalar',
        '!Join mapping',
        '!Join sequence',
      },
    },
  },
}
