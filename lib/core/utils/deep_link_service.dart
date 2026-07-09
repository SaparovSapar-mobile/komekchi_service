import 'dart:async';

import 'package:app_links/app_links.dart';

import 'router.dart';

/// Handles incoming `komekchi://detail?uuid=...` links (from the share
/// landing page or elsewhere) and routes them to the DetailScreen.
class DeepLinkService {
  static final AppLinks _appLinks = AppLinks();
  static StreamSubscription<Uri>? _subscription;

  static Future<void> init() async {
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) _handle(initialUri);

    _subscription = _appLinks.uriLinkStream.listen(_handle);
  }

  static void dispose() {
    _subscription?.cancel();
  }

  static void _handle(Uri uri) {
    if (uri.host != 'detail') return;

    final uuid = uri.queryParameters['uuid'];
    if (uuid == null || uuid.isEmpty) return;

    appRouter.push('/detail', extra: {'uuid': uuid});
  }
}
