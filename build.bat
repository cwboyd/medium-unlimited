REM @echo off

if x%AMO_JWT_ISSUER% == x goto error_no_issuer
if x%AMO_JWT_SECRET% == x goto error_no_secret

REM We need npx and web-ext
REM npm install --global npx
REM npm install --global web-ext

REM This will create the webpack, copy into dist directory.
call npx webpack --mode production

REM sign out of dist
pushd dist
call web-ext sign --channel=unlisted --api-key %AMO_JWT_ISSUER% --api-secret %AMO_JWT_SECRET% --verbose
popd

:done
exit /b 0

:error_no_issuer
echo You must specify env AMO_JWT_ISSUER!
exit /b 1

:goto error_no_secret
echo You must specify env AMO_JWT_SECRET!
exit /b 1


