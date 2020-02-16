module.exports = (Handlebars, _) =>{
  Handlebars.registerHelper('restoreLineBreaks', v => v.replace(/&lt;br&gt;/g, "<br>"));
}
