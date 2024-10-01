return {
  setup = function(lspconfig, on_attach, capabilities)
    lspconfig["sqls"].setup {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        local ok, sqls = pcall(require, "sqls")

        if ok then
          sqls.on_attach(client, bufnr)
        end

        on_attach(client, bufnr)
      end,

      settings = {
        sqls = {
          connections = {
            {
              driver = "sqlite3",
              dataSourceName = "/home/omareloui/myhome/repos/financial-planner/data/db.sqlite",
            },
          },
        },
      },
    }
  end,
}
