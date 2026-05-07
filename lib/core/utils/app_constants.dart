class ApiConstants {
  static const String baseUrl = "http://216.250.14.29:8124";

  static String imageUrl(String path) {
    return "$baseUrl$path";
  }
}
