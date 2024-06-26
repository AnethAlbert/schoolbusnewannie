import 'package:newschoolbusapp/core/services/message_service.dart';

class MessageController {
  late MessageService messageService;

  MessageController() {
    messageService = MessageService();
  }

  Future<bool> sendMessage(String message, int tripId) async {
    return messageService.sendMessage(message, tripId);
  }
}
