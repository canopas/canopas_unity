import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';

@freezed
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse.idle() = Idle<T>;

  const factory ApiResponse.loading() = Loading<T>;

  const factory ApiResponse.completed({required T data}) = Success<T>;

  const factory ApiResponse.error({required String error}) = Failure<T>;
}
