module.exports = (Handlebars, _) =>{

  Handlebars.registerHelper('endsWith', (lvalue, rvalue, options) => {
    if (arguments.length < 3)
      throw new Error('Handlebars Helper endsWith needs 2 parameters');
    if (!lvalue.endsWith(rvalue)) {
      return options.inverse(this);
    }

    return options.fn(this);
  });

}
