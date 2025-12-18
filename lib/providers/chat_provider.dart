import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    _messages.add(
      ChatMessage(
        sender: "You",
        message: text,
        time: _getTime(),
        isMe: true,
      ),
    );

    notifyListeners();
  }

  void receiveMessage(String text, String senderName) {
    _messages.add(
      ChatMessage(
        sender: senderName,
        message: text,
        time: _getTime(),
        isMe: false,
      ),
    );

    notifyListeners();
  }

  String _getTime() {
    final now = TimeOfDay.now();
    return "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
  }
}


class ChatMessage {
  final String sender;
  final String message;
  final String time;
  final bool isMe;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.time,
    required this.isMe,
  });
}


