import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectivityService {
  ConnectivityService._();
  static final _instance = ConnectivityService._();
  static ConnectivityService get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;
  // 1.
  void initialise() async {
    ConnectivityResult result = await _networkConnectivity.checkConnectivity();

    //_checkStatus(result);
    _networkConnectivity.onConnectivityChanged.listen((result) {
      result.printInfo();
      Get.snackbar(
          "internet status",
          result == ConnectivityResult.mobile ||
                  result == ConnectivityResult.wifi
              ? "you are connected"
              : "you are offline",
          duration: const Duration(seconds: 1, milliseconds: 300),
          colorText: Colors.white);
      //_checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
    Get.snackbar(
        "internet status",
        result != ConnectivityResult.none
            ? "you are connected"
            : "you are offline");
  }

  void disposeStream() => _controller.close();
}
