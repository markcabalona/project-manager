
import 'package:dartz/dartz.dart' as dartz;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:todo/core/presentation/widgets/error_widget.dart';
import 'package:todo/core/themes.dart';

import 'dependency_injection.dart' as di;
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/authenticate_page.dart';
import 'features/auth/presentation/pages/sign_in_page.dart';
import 'features/auth/presentation/pages/sign_up_page.dart';
import 'features/project/presentation/bloc/project_bloc.dart';
import 'features/project/presentation/pages/homepage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>(),
        ),
        BlocProvider<ProjectBloc>(
          create: (context) => di.sl<ProjectBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    customTheme.addListener(() {
      setState(() {});
    });
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Manager',
      debugShowCheckedModeBanner: false,
      theme: customTheme.lightTheme,
      darkTheme: customTheme.darkTheme,
      themeMode: customTheme.currentTheme,
      home: StreamBuilder<User?>(
        initialData: FirebaseAuth.instance.currentUser,
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              BlocProvider.of<ProjectBloc>(context).add(FetchProjectsEvent());
              return HomePage(user: snapshot.data!);
            } else {
              return const AuthenticatePage(
                child: dartz.Left(SignInPage()),
              );
            }
          } else {
            return const Center(
              child: CustomErrorWidget(errorMessage: 'Connection breaks'),
            );
          }
        },
      ),
      routes: {
        '/signIn': (context) =>
            const AuthenticatePage(child: dartz.Left(SignInPage())),
        '/signUp': (context) =>
            const AuthenticatePage(child: dartz.Right(SignUpPage())),
      },
    );
  }
}
