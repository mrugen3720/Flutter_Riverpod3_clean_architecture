/// Strips sensitive values from request/response payloads before they reach a
/// log sink. Used by [ApiInterceptors] and any other transport-layer logger.
class LogRedactor {
  const LogRedactor._();

  static const _sensitiveKeys = <String>{
    'authorization',
    'password',
    'new_password',
    'old_password',
    'confirm_password',
    'current_password',
    'token',
    'access_token',
    'refresh_token',
    'bearer_token',
    'id_token',
    'otp',
    'pin',
    'cvv',
    'cvc',
    'secret',
    'api_key',
    'apikey',
    'key',
    'set-cookie',
    'cookie',
  };

  static const _redactedPlaceholder = '[REDACTED]';

  static Map<String, dynamic> redactHeaders(Map<String, dynamic> headers) {
    final result = <String, dynamic>{};
    headers.forEach((key, value) {
      result[key] = _isSensitive(key) ? _redactedPlaceholder : value;
    });
    return result;
  }

  static dynamic redactBody(dynamic body) {
    if (body is Map) {
      final result = <String, dynamic>{};
      body.forEach((key, value) {
        final keyStr = key.toString();
        if (_isSensitive(keyStr)) {
          result[keyStr] = _redactedPlaceholder;
        } else if (value is Map || value is List) {
          result[keyStr] = redactBody(value);
        } else {
          result[keyStr] = value;
        }
      });
      return result;
    }
    if (body is List) {
      return body.map(redactBody).toList();
    }
    return body;
  }

  static bool _isSensitive(String key) {
    return _sensitiveKeys.contains(key.toLowerCase());
  }
}
