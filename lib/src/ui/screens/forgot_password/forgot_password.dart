import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_distance/src/bloc/auth_bloc/auth_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message))
            );
            Navigator.of(context).pop();
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error))
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0), // Set the circular radius here
                        borderSide: const BorderSide(), // You can customize the border side if needed
                      ),
                     contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // Optional padding
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                     final email = emailController.text;
                     context.read<AuthBloc>().add(ResetPasswordRequest(email));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(
                          50), // Full-width button
                    ),
                    child: const Text('Send Reset Link'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}