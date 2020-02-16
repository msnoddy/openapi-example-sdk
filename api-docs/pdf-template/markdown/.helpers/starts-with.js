module.exports = (Handlebars, _) =>{

  Handlebars.registerHelper('startsWith', (lvalue, rvalue, options) => {
    if (arguments.length < 3)
      throw new Error('Handlebars Helper startsWith needs 2 parameters');
    if (!lvalue.startsWith(rvalue)) {
      return options.inverse(this);
    }

    return options.fn(this);
  });

}
