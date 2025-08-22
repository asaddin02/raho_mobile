class AppRoutes {
  final String path;
  final String name;

  const AppRoutes._(this.path, this.name);

  // Static instance route
  static const splash = AppRoutes._("/", "splash");
  static const onboarding = AppRoutes._("/onboarding", "onboarding");
  static const verification = AppRoutes._("/verification", "verification");
  static const otp = AppRoutes._("/otp/:id_register/:mobile", "otp");
  static const createPassword = AppRoutes._(
    "/create-password/:patientId",
    "create-password",
  );
  static const login = AppRoutes._("/login", "login");

  // Shell
  static const dashboard = AppRoutes._("/dashboard", "dashboard");
  static const transaction = AppRoutes._("/transaction", "transaction");
  static const therapy = AppRoutes._("/therapy", "therapy");
  static const profile = AppRoutes._("/profile", "profile");

  // Child routes
  static const detailTransaction = AppRoutes._(
    "/transaction/detail-transaction/:id/:type",
    "detail-transaction",
  );
  static const detailTherapy = AppRoutes._(
    "/therapy/detail-therapy/:id",
    "detail-therapy",
  );
  static const detailLab = AppRoutes._(
    "/therapy/detail-lab/:id",
    "detail-lab",
  );
  static const personalData = AppRoutes._(
    "/profile/personal-data",
    "personal-data",
  );
  static const referenceCode = AppRoutes._(
    "/profile/reference-code",
    "reference-code",
  );
  static const branchLocation = AppRoutes._(
    "/profile/branch-location",
    "branch-location",
  );
  static const myDiagnosis = AppRoutes._(
    "/profile/diagnosis-me",
    "diagnosis-me",
  );
}
