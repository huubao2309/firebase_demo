import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Analytics Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String messageStr = 'No message';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseNotification();
  }

  void _firebaseNotification() {
    _firebaseMessaging.configure(
      onMessage: (message) async {
        print('onMessage Firebase: $message');
        setState(() {
          messageStr = message.toString();
        });
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (message) async {
        print('onLaunch Firebase: $message');
        setState(() {
          messageStr = message.toString();
        });
      },
      onResume: (message) async {
        print('onResume Firebase: $message');
        setState(() {
          messageStr = message.toString();
        });
      },
    );

    // // ignore: cascade_invocations
    // _firebaseMessaging
    //     // ignore: cascade_invocations
    //     .requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true));

    // _firebaseMessaging.onIosSettingsRegistered.listen((settings) {
    //   print('Settings registered: $settings');
    // });

    _firebaseMessaging.getToken().then((token) async {
      assert(token != null, 'Token is null');
      if (token == null) {
        setState(() {
          token = 'Token is null';
        });
      } else if (messageStr == 'No message') {
        // Send Email
        await sendEmail(token);
        setState(() {
          messageStr = token;
        });
      }

      print('Push Messaging token: $token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Firebase'),
      ),
      body: Center(
        child: Text(messageStr),
      ),
    );
  }
}

Future<void> sendEmail(String token) async {
  final Email email = Email(
    body: 'Token: $token',
    subject: 'Token gui ve',
    recipients: ['huubao2309@gmail.com'],
    isHTML: false,
  );

  await FlutterEmailSender.send(email);
}

// ignore: missing_return
Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
    await sendEmail('Data: ${message.toString()}');
    print('$data');
  }

  if (message.containsKey('notification')) {
    final dynamic notification = message['notification'];
    await sendEmail('Notification: ${message.toString()}');
    print('$notification');
  }
}
