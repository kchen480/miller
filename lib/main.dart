import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Correct import for GetX
import 'package:miller/pages/login.dart'; // Import login page
import 'package:miller/pages/successful.dart'; // Import success page
import 'package:miller/state/app_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: () {
        ApplicationState();
      },
      initialRoute: '/login', // Define the initial route
      getPages: [
        GetPage(name: '/login', page: () => const LoginPage(title: 'Miller')), // Define the login route
        GetPage(name: '/success', page: () => const SuccessfulPage()), // Define the success route
      ],
    );
  }
}
