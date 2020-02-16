module.exports = (Handlebars, _) =>{

  Handlebars.registerHelper('buildPath', (propName, path, key, propType) => {
    if (typeof(propType) === 'string' && propType === 'array') {
      // ensure that the array annotation carries in the path
      propName = `${propName}[]`
    }

    if (!path) return propName;
    return `${path}.${propName}`;
  });

}
