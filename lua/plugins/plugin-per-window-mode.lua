--- Custom plugin that auto toggle modes between different windows.
---
--- This records window editing mode when leaving, and restore it when re-enter
--- that window.
---
--- recovery rule is :
--- * INSERT/SELECT --> INSERT
--- * any others --> NORMAL
--- * ignore all non-editing window

return {
  dir = vim.fn.stdpath("config"),
  name = "per-window-mode",
  event = "VeryLazy",
  config = function()

    ---@type string[]
    local win_modes = {}
    local group = vim.api.nvim_create_augroup("PerWindowModeRestore", { clear = true })

    vim.api.nvim_create_autocmd("WinLeave", {
      group = group,
      callback = function()
        ---@type integer
        local winid = vim.api.nvim_get_current_win()
        -- local bt = vim.bo.buftype
        -- local ft = vim.bo.fimetype
        ---@type string
        local mode = vim.api.nvim_get_mode().mode
        win_modes[winid] = mode
        -- vim.notify(string.format("Saved win%s => %s", winid, mode))
      end,
    })

    vim.api.nvim_create_autocmd("WinEnter", {
      group = group,
      callback = function()
        ---@type integer
        local winid = vim.api.nvim_get_current_win()
        ---@type string
        local buf = vim.bo.buftype
        ---@type string
        local last_mode = win_modes[winid]
        if last_mode and (
          last_mode:find("^[ist]") or
          last_mode:find("i[IRV]$") or
          last_mode == "nt"
        ) then
          vim.schedule(function()
            if vim.api.nvim_win_is_valid(winid) then
              vim.cmd("startinsert")
              -- vim.notify(string.format("Restore win%s => %s => insert", winid, last_mode))
            end
          end)
        else
          vim.schedule(function ()
            if buf == 'terminal' then
              vim.cmd("startinsert")
              -- vim.notify(string.format("init win%s => terminal"), winid)
            else
              vim.cmd("stopinsert")
              -- vim.notify(string.format("Init win%s => normal", winid))
            end
          end)
        end
      end,
    })

  end,
}

