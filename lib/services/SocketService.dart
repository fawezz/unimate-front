import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:univ_chat_gpt/app/Constants.dart';
import 'package:univ_chat_gpt/services/NotificationService.dart';

class SocketService {
  static StreamController<String> streamController =
      StreamController<String>.broadcast();
  int notifId = 0;
  static Socket socket = io(
      socketBaseUrl,
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect()
          //.setExtraHeaders({'foo': 'bar'}) // optional
          .build());

  static void initializeSocket() {
    socket.connect();
    socket.on('connect', (_) {
      print('connected to server');
    });
    socket.on('message', (data) {
      print('received message: $data');
      NotificationService().showNotif();
    });
  }
}
