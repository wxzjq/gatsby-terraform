'use strict';

const path = require('path');

// This will add a trailing slash to the end of the URL if not already present.
function shouldAddTrailingSlash(uri) {
  const extension = path.extname(uri);

  if (extension) return false;

  return !uri.endsWith('/');
}

// Redirects object's keys to values
const redirectMap = {
  '/': '/blog/',
};

function shouldRedirect(uri) {
  return Object.keys(redirectMap).includes(uri);
}

exports.handler = async (event) => {
  const { request } = event.Records[0].cf;
  const { uri } = request;
  const host = request.headers.host[0].value;
  const { querystring } = request;

  if (
    !host.startsWith('www.')
    || shouldAddTrailingSlash(uri)
    || shouldRedirect(uri)
  ) {
    let newUrl = 'https://www.skies.dev';

    // Add path
    if (uri) newUrl += shouldRedirect(uri) ? redirectMap[uri] : uri;

    // Add trailing slash
    if (!newUrl.endsWith('/')) newUrl += '/';

    // Add query string
    if (querystring && querystring !== '') newUrl += `?${querystring}`;

    return {
      status: '301',
      statusDescription: 'Moved Permanently',
      headers: {
        location: [
          {
            key: 'Location',
            value: newUrl,
          },
        ],
      },
    };
  }

  return request;
};
