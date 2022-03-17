class ApiResponse<T> {
  Status status;
  T? data;
  String? message;

  ApiResponse.loading() : status = Status.loading;

  ApiResponse.completed(this.data) : status = Status.completed;

  ApiResponse.error(this.message) : status = Status.error;
}

enum Status { loading, completed, error }
