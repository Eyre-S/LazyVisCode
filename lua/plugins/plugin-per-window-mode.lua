--- Custom plugin that auto toggle modes between different windows.
---
--- This records window editing mode when leaving, and restore it when re-enter
--- that window.
---
--- recovery rule is :
--- * INSERT/SELECT --> INSERT
--- * any others --> NORMAL
--- * each editor/terminal window have its own editing mode saved
--- * all non-editor window share one global editing mode (this is to aviod incompatible, when
---   some extensions open a floating window and changes editing modes by them own)

return {
  dir = vim.fn.stdpath("config"),
  name = "per-window-mode",
  event = "VeryLazy",
  config = function()
    
    -- do return end
    
    local global = {
      ---@type "global"|"buf"
      last_window = "global",
      ---@type string[]
      buf_edit_modes = {},
      ---@type string
      global_edit_modes = "n",
      ---@type boolean
      notify_log = false,
    }

    ---@type integer
    local group = vim.api.nvim_create_augroup("PerWindowModeRestore", { clear = true })
    
    ---Log use vim.notify()
    ---@param message string Log message
    local function log (message)
      if not global.notify_log then
        do return end
      end
      vim.notify(message, vim.log.levels.DEBUG)
    end

    ---If this buffer should be a global buffer.
    ---
    ---Global buffer windows share one global edit mode state.
    ---
    ---@param buftype string
    ---@return _ boolean true if this is global buffer; false if this is a editor/terminal
    ---                  buffer
    local function is_global_buf (buftype)
      if (
        buftype == '' or
        buftype == 'terminal'
      ) then
        return false
      else
        return true
      end
    end

    ---Check if the mode code can be restored to INSERT
    ---@param mode string The previous editing mode code, should be in short case (i/v/niI etc.)
    ---@return _ boolean true if can/should restored to INSERT; false otherwise
    local function is_edit_mode (mode)
      if (
        mode:find("^[ist]") or
        mode:find("i[ILS]$") or
        mode == "nt"
      ) then
        return true
      else
        return false
      end
    end

    vim.api.nvim_create_autocmd("WinLeave", {
      group = group,
      callback = function()
        
        ---@type integer
        local winid = vim.api.nvim_get_current_win()
        ---@type string
        local buftype = vim.bo.buftype
        ---@type string
        local mode = vim.api.nvim_get_mode().mode
        
        if is_global_buf(buftype) then
          global.last_window = "global"
          global.global_edit_modes = mode
          log(string.format("Saved global => %s", mode))
        else
          global.last_window = "buf"
          global.buf_edit_modes[winid] = mode
          log(string.format("Saved win%s => %s", winid, mode))
        end
        
      end,
    })

    vim.api.nvim_create_autocmd("WinEnter", {
      group = group,
      callback = function()

        ---@type integer
        local winid = vim.api.nvim_get_current_win()
        ---@type string
        local buftype = vim.bo.buftype

        --- Restore to INSERT/NORMAL based on old mode
        ---@param old_mode string|nil
        ---@param window_name string
        local function restore_old_mode (old_mode, window_name)
          log(string.format("old mode is %s", old_mode))
          if !old_mode then
            vim.cmd("stopinsert")
            log(string.format("Init %s => NORMAL", window_name, old_mode))
            do return end
          end
          if is_edit_mode(old_mode) then
            vim.cmd("startinsert")
            log(string.format("Restore %s => %s => INSERT", window_name, old_mode))
          else
            vim.cmd("stopinsert")
            log(string.format("Restore %s => %s => NORMAL", window_name, old_mode))
          end
        end
        
        vim.schedule(function()
          if vim.api.nvim_win_is_valid(winid) then
            log("valid window")
            if is_global_buf(buftype) then
              if global.last_window == 'global' then
                log("Keep mode, still in global")
              else
                log("restoring old mode...")
                restore_old_mode(global.global_edit_modes, "Global")
              end
            else
              ---@type string|nil
              local old_mode = global.buf_edit_modes[winid]
              restore_old_mode(old_mode, string.format("Win%s", winid))
            end
          else
            log("invalid window")
          end
        end)
        
      end,
    })

  end,
}

