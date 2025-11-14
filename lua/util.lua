local M = {}

-- debounce function with timeout
M.debounce = function(fn, timeout)
  local is_running = false

  return function()
    if is_running then
      return
    end

    vim.defer_fn(function()
      is_running = false
    end, timeout)

    is_running = true
    vim.schedule_wrap(fn)()
  end
end

return M
