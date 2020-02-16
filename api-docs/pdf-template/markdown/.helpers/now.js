const moment = require('moment')

module.exports = (Handlebars, _) =>{
  Handlebars.registerHelper('now', () => {
    return moment().format("MMMM Do YYYY");
  });
}
