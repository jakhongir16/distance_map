import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_distance/src/bloc/auth_bloc/auth_bloc.dart';
import 'package:map_distance/src/bloc/trip/trip_bloc.dart';
import 'package:map_distance/src/data/repositories/auth_repositories/auth_repositories.dart';
import 'package:map_distance/src/data/repositories/trip_repository/trip_repository.dart';
import 'package:map_distance/src/services/locator.dart';
import 'package:map_distance/src/ui/screens/error_page/error_page.dart';
import 'package:map_distance/src/ui/screens/sign_in/sign_in_page.dart';
import 'firebase_options.dart';
import 'src/ui/screens/main_page/main_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(authRepository: AuthRepository())),
        BlocProvider(create: (context) => TripBloc(TripRepository()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/': (context) => SignInScreen(),
          '/main': (context) => const MainPage(),
        },
      ),
    );
  }
}

