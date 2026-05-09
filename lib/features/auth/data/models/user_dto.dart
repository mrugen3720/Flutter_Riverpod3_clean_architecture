import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

/// Wire-format representation of a user record. JSON-serializable; mirrors
/// the backend payload exactly. Mapping into the domain [UserProfile] entity
/// happens in `data/mappers/auth_mapper.dart`.
@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'phone') String? phone,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
