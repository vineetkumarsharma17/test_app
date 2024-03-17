class ApiError {
  final int statusCode;
  final String message;
  final String? title;

  ApiError({required this.statusCode, required this.message, this.title});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
        statusCode: json['statusCode'] ?? 0,
        message: json['message'] ?? 'Unknown error occurred',
        title: json['title']);
  }

  @override
  String toString() {
    return 'API Error: Status Code - $statusCode, Message - $message, Title - $title';
  }
}
