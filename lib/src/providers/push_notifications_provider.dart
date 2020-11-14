import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';

//e3kVsICPQ6q25VA12nRWl_:APA91bHDiTHexH-1HCE8DgXtgCcroRH58cdbHJxQWMUdmp1Cny4lKvF8nNQoV_4Ale-8leT2VObQ2tj2WJ4Cf5PuuDr3DB8jaZ37qQAuLHF5NQTlvk13vrvMnHMAdEWmT3zSfwlhRWrK

class PushNotificationsProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajeStream => _mensajesStreamController.stream;

  @override
  void dispose() {
    _mensajesStreamController?.close();
  }

  static Future<dynamic> onBackgroundMessage(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
    // Or do other work.
  }

  initNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions();

    final token = await _firebaseMessaging.getToken();

    print('Token : $token');

    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume,
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print('On Message');
    final argumento = message['data']['comida'] ?? 'no-data';
    _mensajesStreamController.sink.add(argumento);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print('On onLaunch');
    final argumento = message['data']['comida'] ?? 'no-data';
    _mensajesStreamController.sink.add(argumento);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print('On onResume');
    final argumento = message['data']['comida'] ?? 'no-data';
    _mensajesStreamController.sink.add(argumento);
  }
}
