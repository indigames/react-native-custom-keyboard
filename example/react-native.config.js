const path = require('path');
const pak = require('../package.json');

module.exports = {
  dependencies: {
    [pak.name]: {
      platforms: {
        android: null,
      },
      root: path.join(__dirname, '..'),
    },
  },
};
