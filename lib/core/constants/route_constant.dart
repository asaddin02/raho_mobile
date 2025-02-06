class RouteName {
  static const String splash = "splash";
  static const String welcome = "welcome";
  static const String login = "login";
  static const String dashboard = "dashboard";
  static const String transaction = "transaction";
  static const String history = "history";
  static const String profile = "profile";
  static const String myVoucher = "voucher-me";
  static const String detailTransaction = "detail-transaction";
  static const String personalData = "personal-data";
  static const String referenceCode = "reference-code";
  static const String rahoBranchLocation = "raho-branch-location";
  static const String myDiagnosis = "diagnosis-me";
}

class RouteApp {
  static const String splash = "/";
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String dashboard = "/dashboard";
  static const String transaction = "/transaction";
  static const String history = "/history";
  static const String profile = "/profile";
  static const String myVoucher = "$dashboard/voucher-me";
  static const String detailTransaction = "$transaction/detail-transaction";
  static const String personalData = "$profile/personal-data";
  static const String referenceCode = "$profile/reference-code";
  static const String rahoBranchLocation = "$profile/raho-branch-location";
  static const String myDiagnosis = "$profile/diagnosis-me";
}
