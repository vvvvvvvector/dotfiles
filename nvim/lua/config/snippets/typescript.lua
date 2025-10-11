---@diagnostic disable: undefined-global

return {
  s(
    { trig = "cl (.*)", regTrig = true },
    fmta([[console.log(<>, <>);]], {
      i(1),
      f(function(_, s) return s.captures[1] end)
    })
  ),
  s(
    'cl',
    fmta([[console.log(<>, <>);]], {
      i(1),
      i(2)
    })
  ),
  s(
    'cd',
    fmta([[console.dir(<>, { depth: null });]], {
      i(1),
    })
  )
}
