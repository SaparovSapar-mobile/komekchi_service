class ApiConstants {
  static const String baseUrl = "http://216.250.12.53:8124";

  /// Prefixes a relative image path (e.g. "/uploads/img.png") coming from the
  /// API with the server's root domain. Returns [path] unchanged if it is
  /// already an absolute URL or empty.
  static String imageUrl(String path) {
    if (path.isEmpty || path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }
    return "$baseUrl$path";
  }
}

class WebConstants {
  // TODO: swap for the real HTTPS domain once it's ready, then wire up
  // Android App Links / iOS Universal Links (see detail-landing/README.md).
  static const String webBaseUrl = "http://216.250.12.53:5073";

  // Custom URL scheme registered on Android/iOS so the app can be opened
  // directly from the landing page without needing a verified domain.
  static const String appScheme = "komekchi";

  static String detailShareUrl(String uuid) => "$webBaseUrl/detail?uuid=$uuid";

  static String detailAppLink(String uuid) => "$appScheme://detail?uuid=$uuid";
}
