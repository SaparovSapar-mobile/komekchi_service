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
