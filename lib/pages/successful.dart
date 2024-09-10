import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // For navigation

class SuccessfulPage extends StatelessWidget {
  const SuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
        automaticallyImplyLeading: false, // Hide the back button
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login successful"),
            const SizedBox(height: 20),
            buildLogoutButton(context), // Logout button
          ],
        ),
      ),
    );
  }

  // Logout Button Widget
  Widget buildLogoutButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45,
        width: 270,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(const StadiumBorder(
                side: BorderSide(style: BorderStyle.none))),
          ),
          child: const Text(
            'Logout',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () async {
            await FirebaseAuth.instance.signOut(); // Log out the user
            Get.offAllNamed('/login'); // Navigate back to login page
          },
        ),
      ),
    );
  }
}
