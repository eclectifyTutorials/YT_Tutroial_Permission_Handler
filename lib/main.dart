// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const customSwatch = MaterialColor(
    0xFFFF5252,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFFF5252),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Permission Handler"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              ElevatedButton(onPressed: requestCameraPermission,
                child: Text("Request Camera Permission", style: TextStyle(fontSize: 16,),),
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(onPressed: requestMultiplePermissions,
                child: Text("Request Multiple Permissions", style: TextStyle(fontSize: 16,),),
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(onPressed: requestPermissionWithOpenSettings,
                child: Text("Open Permission Settings", style: TextStyle(fontSize: 16,),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void requestCameraPermission() async {
    /// status can either be: granted, denied, restricted or permanentlyDenied
    var status = await Permission.camera.status;
    if (status.isGranted) {
      print("Permission is granted");
    }
    else if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      if (await Permission.camera.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        print("Permission was granted");
      }
    }

    // You can can also directly ask the permission about its status.
    // if (await Permission.location.isRestricted) {
    //   // The OS restricts access, for example because of parental controls.
    // }
  }

  /// Request multiple permissions at once.
  /// In this case location & storage
  void requestMultiplePermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
    print("location permission: ${statuses[Permission.location]}, "
        "storage permission: ${statuses[Permission.storage]}");
  }

  /// The user opted to never again see the permission request dialog for this
  /// app. The only way to change the permission's status now is to let the
  /// user manually enable it in the system settings.
  void requestPermissionWithOpenSettings() async {
    //if (await Permission.speech.isPermanentlyDenied) {
      openAppSettings();
    //}
  }

}

