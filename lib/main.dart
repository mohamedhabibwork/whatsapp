import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/screens/CameraScreen.dart';
import 'package:whatsapp/screens/LoginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      locale: const Locale('en'),
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
          // primarySwatch: Colors.blue,
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF075E54),
          // ignore: deprecated_member_use
          accentColor: const Color(0xFF128C7E),
          fontFamily: 'OpenSans'),
      home: LoginScreen(),
    );
  }
}
