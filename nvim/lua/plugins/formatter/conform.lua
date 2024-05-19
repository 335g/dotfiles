return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({
          async = true,
          lsp_fallback = true,
        })
      end,
      desc = "Format buffer",
    },
  },
  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_format" },
      javascript = { "biome-check" },
      rust = { "rustfmt" },
      sql = { "sql_formatter" },
      json = { "jq" },
      yaml = { "yamlfmt" },
      toml = { "taplo" },
      ["_"] = { "trim_whitespace", "trim_newlines" },
    },
    formatters = {
      deno_fmt = {
        cmd = function()
          require("conform.util").root_file({ "deno.json" })
        end,
      },
    },
  },
}
