return {
  "saghen/blink.cmp",
  opts = {

    keymap = {
      
      -- default enter mode
      preset = "enter",
      
      -- tab select
      ["<Tab>"] = { "accept", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      -- Hide only when auto-fill is shown
      ["<Esc>"] = { "hide", "fallback" },

    },

    completion = {
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
    },

  },
}

