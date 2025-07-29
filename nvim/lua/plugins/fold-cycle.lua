-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  'jghauser/fold-cycle.nvim',
  config = function()
    require('fold-cycle').setup()
  end
}
