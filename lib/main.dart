import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_statenf_auth/pages/home_page.dart';
import 'package:fb_statenf_auth/pages/signin_page.dart';
import 'package:fb_statenf_auth/pages/splash_page.dart';
import 'package:fb_statenf_auth/providers/providers.dart';
import 'package:fb_statenf_auth/repositories/auth_repository.dart';
import 'package:fb_statenf_auth/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:fb_statenf_auth/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: fbAuth.FirebaseAuth.instance,
          ),
        ),
        Provider<ProfileRepository>(
          create: (context) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        StreamProvider<fbAuth.User?>(
          create: (context) => context.read<AuthRepository>().user,
          initialData: null,
        ),
        StateNotifierProvider<AuthProvider, AuthState>(
          create: (context) => AuthProvider(),
        ),
        StateNotifierProvider<SigninProvider, SigninState>(
          create: (context) => SigninProvider(),
        ),
        StateNotifierProvider<SignupProvider, SignupState>(
          create: (context) => SignupProvider(),
        ),
        // ChangeNotifierProvider<SignupProvider>(
        //   create: (context) => SignupProvider(
        //     authRepository: context.read<AuthRepository>(),
        //   ),
        // ),
        StateNotifierProvider<ProfileProvider, ProfileState>(
          create: (context) => ProfileProvider(),
        ),
        // ChangeNotifierProvider<ProfileProvider>(
        //   create: (context) => ProfileProvider(
        //     profileRepository: context.read<ProfileRepository>(),
        //   ),
        // ),,
      ],
      child: MaterialApp(
        title: 'auth provider',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashPage(),
        routes: {
          SignupPage.routeName: (context) => const SignupPage(),
          SigninPage.routeName: (context) => const SigninPage(),
          HomePage.routeName: (context) => const HomePage(),
        },
      ),
    );
  }
}
