class ApiConstants {
  static const String baseUrl = 'https://api.github.com';
  static const String userEndpoint = '/users';
  static const String reposEndpoint = '/repos';
  
  // Timeout durations
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;
}
