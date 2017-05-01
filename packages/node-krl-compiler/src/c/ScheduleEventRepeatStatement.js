var callModuleFn = require("../utils/callModuleFn");

module.exports = function(ast, comp, e){

    var args = [e("obj", {
        domain: e("string", ast.event_domain.value, ast.event_domain.loc),
        type: comp(ast.event_type),
        timespec: ast.timespec ? comp(ast.timespec) : e("nil"),
        attributes: ast.attributes ? comp(ast.attributes) : e("nil")
    })];

    return e(";", callModuleFn(e, "schedule", "eventRepeat", e("array", args), ast.loc));
};
