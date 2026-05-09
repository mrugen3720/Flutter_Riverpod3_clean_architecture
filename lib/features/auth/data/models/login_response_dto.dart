import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_dto.dart';

part 'login_response_dto.freezed.dart';
part 'login_response_dto.g.dart';

/// Wire-format payload returned by `POST /auth/login` and `POST /auth/register`.
@freezed
abstract class LoginResponseDto with _$LoginResponseDto {
  const factory LoginResponseDto({
    @JsonKey(name: 'token') String? token,
    @JsonKey(name: 'user') UserDto? user,
  }) = _LoginResponseDto;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);
}
