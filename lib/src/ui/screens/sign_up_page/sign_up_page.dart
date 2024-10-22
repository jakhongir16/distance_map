import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_distance/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:map_distance/src/ui/screens/main_page/main_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? errorMessage; // Variable to store error message

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
            );
          } else if (state is AuthFailure) {
            // Store the error message in a variable instead of showing a dialog or SnackBar
            errorMessage = state.error;
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      final email = emailController.text;
                      final password = passwordController.text;
                      context
                          .read<AuthBloc>()
                          .add(SignUpRequested(email, password));
                    },
                    child: const Text('Sign Up'),
                  ),
                  // Display the error message if it exists
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
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
