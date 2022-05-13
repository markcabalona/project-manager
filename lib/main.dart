import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/constants.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: kPrimaryColor,
        fontFamily: GoogleFonts.poppins().fontFamily,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: kPrimaryColor,
              displayColor: kPrimaryColor,
            ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            BlocProvider.of<ProjectBloc>(context).add(FetchProjectsEvent());
            return HomePage(user: snapshot.data!);
          }
          return const AuthenticatePage(
            child: Left(SignInPage()),
          );
        },
      ),
      routes: {
        '/signIn': (context) =>
            const AuthenticatePage(child: Left(SignInPage())),
        '/signUp': (context) =>
            const AuthenticatePage(child: Right(SignUpPage())),
      },
    );
  }
}
