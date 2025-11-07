/// Generic API response wrapper for handling network responses
/// 
/// This class provides a consistent way to handle API responses across the app
/// with success/error states and optional status codes.
class ApiResponse<T> {
  /// Whether the request was successful
  final bool success;
  
  /// The response data of type T
  final T? data;
  
  /// Error or success message
  final String? message;
  
  /// HTTP status code if available
  final int? statusCode;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse(
      success: true,
      data: data,
    );
  }

  factory ApiResponse.error(String message, {int? statusCode}) {
    return ApiResponse(
      success: false,
      message: message,
      statusCode: statusCode,
    );
  }
}
