const rootId = ''

var lastRootKey = ''
var lastRootType = ''

module.exports = (Handlebars, _) =>{

  Handlebars.registerHelper('tree', (path, rootKey, rootType, propName) => {
    if (typeof(rootKey) === 'string' && rootKey) {
      lastRootKey = rootKey
    } else if ((typeof(rootKey) !== 'string' || !rootKey) && lastRootKey) {
      rootKey = lastRootKey
    }

    if (typeof(rootType) === 'string' && rootType) {
      lastRootType = rootType
    } else if ((typeof(rootType) !== 'string' || !rootType) && lastRootType) {
      rootType = lastRootType
    }
  
    if (typeof(path) !== 'string') {
      path = '';
    }
  
    if (typeof(propName) !== 'string') {
      propName = '';
    }

    if (propName === rootKey) {
      propName = '-root-';
    }
  
    if (!path) return propName;
    let filteredPaths = path.split('.').filter(Boolean);
    if (!filteredPaths.length) return propName;
    let dottedPath = filteredPaths.join('.');

    if (rootKey && rootType && rootType === 'array') {
      return rootId === '' ?
        (`${dottedPath}.${propName}`).replace(rootKey, rootId) :
        (`${dottedPath}.${propName}`).replace(rootKey, rootId).replace(`${rootId}.`, `${rootId}`)
    }

    return rootKey ? 
      (`${dottedPath}.${propName}`).replace(rootKey, rootId).replace(/^[.]/, '') :
      `${dottedPath}.${propName}`;
  });

}
