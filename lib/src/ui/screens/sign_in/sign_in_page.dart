import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_distance/src/ui/screens/sign_up_page/sign_up_page.dart';
import '../../../bloc/auth_bloc/auth_bloc.dart';
import '../forgot_password/forgot_password.dart';
import '../main_page/main_page.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            // Navigate to the Main Page on success
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const MainPage()),
            );
          } else if (state is AuthFailure) {
            // Show an alert dialog with an option to go to the Sign Up page
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Sign In Failed'),
                  content: const Text('It seems like you do not have an account. Would you like to sign up?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Dismiss the dialog
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
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
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0), // Set the circular radius here
                        borderSide: const BorderSide(), // You can customize the border side if needed
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0), // Optional padding
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      final email = emailController.text;
                      final password = passwordController.text;
                      context.read<AuthBloc>().add(SignInRequested(email, password));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50), // Button expands to the full width
                    ),
                    child: const Text('Sign In'),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignUpPage()),
                          );
                        },
                        child: const Text('Sign Up'),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          // Navigate to the Forgot Password page (replace with your own logic)
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ForgotPasswordPage()), // Implement this page
                          );
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ],
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
