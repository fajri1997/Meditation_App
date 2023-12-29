import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meditation_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signup(String username, String password) async {
    final url = Uri.parse('https://coded-meditation.eapi.joincoded.com/signup');
    final response = await http.post(url, headers: {
      'Content-Type': 'application/json'
    }, body: jsonEncode({
      'username': username,
      'password': password
    }));

    if (response.statusCode == 200) {
      // Handle success
      final token = jsonDecode(response.body)['token'];
      // Do something with the token, like storing it or navigating to another screen
    } else {
      // Handle error
      // You might want to show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Sign Up"),
            TextField(
              decoration: const InputDecoration(hintText: 'Username'),
              controller: usernameController,
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Password'),
              controller: passwordController,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                signup(usernameController.text, passwordController.text).then((_) {
                  // Navigate to sign in page or other page as needed
                  context.pushNamed("signin");
                });
              },
              child: const Text("Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}
