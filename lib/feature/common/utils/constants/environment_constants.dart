abstract class EnvironmentConstants {
  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: '',
  );
  static const String appID = String.fromEnvironment(
    'APP_ID',
    defaultValue: '',
  );
  static const String messagingSenderId = String.fromEnvironment(
    'MESSAGING_SENDER_ID',
    defaultValue: '',
  );
  static const String projectId = String.fromEnvironment(
    'PROJECT_ID',
    defaultValue: '',
  );
  static const String authDomain = String.fromEnvironment(
    'AUTH_DOMAIN',
    defaultValue: '',
  );
  static const String storageBucket = String.fromEnvironment(
    'STORAGE_BUCKET',
    defaultValue: '',
  );
  static const String measurementId = String.fromEnvironment(
    'MEASUREMENT_ID',
    defaultValue: '',
  );
  static const String gitOrigin = String.fromEnvironment(
    'GIT_ORIGIN',
    defaultValue: '',
  );
}