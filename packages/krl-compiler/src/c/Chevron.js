var callStdLibFn = require('../utils/callStdLibFn')

module.exports = function (ast, comp, e) {
  if (ast.value.length < 1) {
    return e('string', '')
  }
  var compElm = function (elm) {
    if (elm.type === 'String') {
      return e('string', elm.value, elm.loc)
    }
    return callStdLibFn(e, 'beesting', [comp(elm)], elm.loc)
  }
  var curr = compElm(ast.value[0])
  var i = 1
  while (i < ast.value.length) {
    curr = e('+', curr, compElm(ast.value[i]))
    i++
  }
  return curr
}
