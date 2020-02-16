module.exports = (Handlebars, _) =>{

  Handlebars.registerHelper('acceptedValues', (items, pattern) =>{
    if (!items && pattern) {
      return `- <b>Matches Regex</b>: <code>${pattern}</code><br>`;
    }
    else if (!items) {
      return '';
    }

    return `- <b>Accepted Values</b>: ${items.map(i => `<code>${i}</code>`).join(', ')}<br>`;
  });

}
