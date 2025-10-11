---@diagnostic disable: undefined-global

local snippets = {
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
  ),
  s(
    { trig = "f (.*)", regTrig = true },
    fmta("function <>(<>: <>) {\n  <> \n};", {
      f(function(_, s) return s.captures[1] end),
      i(1),
      i(2),
      i(3)
    })
  ),
  s(
    { trig = "af (.*)", regTrig = true },
    fmta("async function <>(<>: <>) {\n  <> \n};", {
      f(function(_, s) return s.captures[1] end),
      i(1),
      i(2),
      i(3)
    })
  ),
}

return snippets
