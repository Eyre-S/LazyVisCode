return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
      },
    },
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    source_selector = {
      enabled = true,
      winbar = true,
      status_bar = true,
      sources = {
        { source = "filesystem", display_name = "󰉓 File" },
        { source = "buffers", display_name = " Buffers" },
        { source = "git_status", display_name = "󰊢 Git"},
        { source = "document_symbols", display_name = "󰆧 Symbols"},
      },
      content_layout = "center",
    },
  },
}

