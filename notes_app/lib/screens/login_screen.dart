import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      appBar: AppBar(title: Text("Login / Signup")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: emailCtrl, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passCtrl, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      try {
                        await authCubit.signUp(emailCtrl.text, passCtrl.text);
                        Navigator.pushReplacementNamed(context, '/notes');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signup Error: $e')));
                      }
                    },
                    child: Text("Sign Up")),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        await authCubit.login(emailCtrl.text, passCtrl.text);
                        Navigator.pushReplacementNamed(context, '/notes');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Error: $e')));
                      }
                    },
                    child: Text("Login")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
