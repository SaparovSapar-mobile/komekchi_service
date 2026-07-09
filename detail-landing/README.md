# Detail share landing page

Deploy `index.html` on the web server at `http://216.250.12.53:5073/` so that
it's served for the path `/detail` (e.g. `/detail/index.html`, or configure
the server to serve it for any request under `/detail`). It reads the
service id from the query string:

```
http://216.250.12.53:5073/detail?uuid=<subcategory-uuid>
```

This is the link the app shares via the "Paýlaşmak" button
(`WebConstants.detailShareUrl` in `lib/core/utils/app_constants.dart`).

## What it does

1. On load, tries to open `komekchi://detail?uuid=...` (the app's custom
   URL scheme, registered in `AndroidManifest.xml` / `Info.plist`). If the
   app is installed, this opens it directly to that service's detail page.
2. Regardless of whether the auto-open worked, it fetches the service from
   the API (`GET /subcategory/{uuid}`) and shows a preview (name,
   description, price, image) with manual "Open in app" / store buttons.

## Before this is production-ready

- Fill in `PLAY_STORE_URL` / `APP_STORE_URL` in `index.html` once the app is
  published (currently placeholders — the Android `applicationId` is still
  the default `com.example.komekchi_service`).
- Once the site has a real HTTPS domain: add
  `.well-known/assetlinks.json` (Android) and
  `.well-known/apple-app-site-association` (iOS), turn on
  `autoVerify="true"` in the Android intent filter, and add the Associated
  Domains capability on iOS. That upgrades this from "best-effort custom
  scheme + landing page" to real App Links / Universal Links, where the OS
  opens the app with no landing page flash at all.
