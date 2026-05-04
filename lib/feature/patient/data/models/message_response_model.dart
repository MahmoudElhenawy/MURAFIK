import 'package:murafik/feature/patient/domain/entities/message_response_entity.dart';

class MessageResponseModel extends MessageResponseEntity {
  MessageResponseModel({
    required String? message,
    required Map<String, dynamic>? raw,
  }) : super(message: message, raw: raw);

  factory MessageResponseModel.fromJson(dynamic data) {
    if (data is Map<String, dynamic>) {
      final message = data['message'];
      return MessageResponseModel(
        message: message is String ? message : null,
        raw: data,
      );
    }

    if (data is String) {
      return MessageResponseModel(message: data, raw: null);
    }

    return MessageResponseModel(message: null, raw: null);
  }
}
