import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: const Text('Error Page'),
        centerTitle: true,
       ),
      body: const Center(
        child: Text('Not found ! 404'),
      ),
    );
  }
}
