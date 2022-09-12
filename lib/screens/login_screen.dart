import 'package:flutter/material.dart';
import 'package:mocito_demo/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  GlobalKey<FormState>? formkey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              validator: (_) {
                return null;
              },
              key: const ValueKey('email_key'),
            ),
            TextFormField(
              controller: _passwordController,
              validator: (_) {
                return null;
              },
              key: const ValueKey('password_key'),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  if (formkey?.currentState!.validate() == true) {
                    debugPrint("Success login");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) =>  HomeScreen()));
                  }
                },
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
