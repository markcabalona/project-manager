import 'package:dartz/dartz.dart' as dartz;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/themes.dart';
import 'dependency_injection.dart' as di;
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/authenticate_page.dart';
import 'features/auth/presentation/pages/sign_in_page.dart';
import 'features/auth/presentation/pages/sign_up_page.dart';
import 'features/project/presentation/bloc/project_bloc.dart';
import 'features/project/presentation/bloc/subtask_bloc.dart';
import 'features/project/presentation/pages/homepage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await customTheme.initTheme();
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
        BlocProvider<SubtaskBloc>(
          create: (context) => di.sl<SubtaskBloc>(),
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
  }

  @override
  void dispose() {
    customTheme.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Manager',
      debugShowCheckedModeBanner: false,
      theme: customTheme.lightTheme,
      darkTheme: customTheme.darkTheme,
      themeMode: customTheme.currentTheme,
      home: const MyHomePage(),
      routes: {
        '/signIn': (context) =>
            const AuthenticatePage(child: dartz.Left(SignInPage())),
        '/signUp': (context) =>
            const AuthenticatePage(child: dartz.Right(SignUpPage())),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      initialData: FirebaseAuth.instance.currentUser,
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.active) {
          return HomePage(user: snapshot.data!);
        }
        return const AuthenticatePage(
          child: dartz.Left(SignInPage()),
        );
      },
    );
  }
}
