enum Environment { development, staging, production }

class AppConfig {
  static final Environment currentEnvironment = _parseEnv(
    const String.fromEnvironment('FLAVOR', defaultValue: 'development'),
  );

  static String get baseUrl {
    switch (currentEnvironment) {
      case Environment.development:
        return 'http://192.168.50.147:8069/api/';
      case Environment.staging:
        return 'https://staging.example.com/api/';
      case Environment.production:
        return 'https://api.example.com/';
    }
  }

  static Environment _parseEnv(String env) {
    switch (env) {
      case 'production':
        return Environment.production;
      case 'staging':
        return Environment.staging;
      default:
        return Environment.development;
    }
  }
}
