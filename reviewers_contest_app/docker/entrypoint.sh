#!/bin/sh -eu

cd /app & flutter build web --release --dart-define REVIEWERS_CONTEST_SSO_TOKEN_ENDPOINT=${REVIEWERS_CONTEST_SSO_TOKEN_ENDPOINT:-} --dart-define GITHUB_SSO_CLIENT_ID=${GITHUB_SSO_CLIENT_ID:-}

chmod -R 755 /usr/share/nginx/html
cp -r /app/build/web/* /usr/share/nginx/html/

nginx -g "daemon off;"