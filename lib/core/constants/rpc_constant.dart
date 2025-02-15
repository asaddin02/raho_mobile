class RpcConstant {
  // Base URLs environment
  static const String baseUrl =
      "http://192.168.50.145:8069/api/"; // Development
  // static const String baseUrl = "http://localhost:8069/api"; // Release

  // Database Set Up
  static var database = _Database();

  // Endpoint for API
  static var Endpoint = _RcpEndpoint();
}

class _Database {
  final String dbName = "raho17-trial";
  final String username = "odoo17";
  final String password = "asadin02";
}

class _RcpEndpoint {
  final String generateCaptcha = "generate_captcha";
  final String login = "login";
  final String profile = "profile";
  final String diagnosis = "diagnosis";
  final String editProfile = "profile/update";
  final String history = "history";
  final String detailHistory = "history/detail";
}
