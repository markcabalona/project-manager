import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/presentation/routes/routes.dart';
import 'core/themes.dart';
import 'dependency_injection.dart' as di;
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/project/presentation/bloc/project_bloc.dart';
import 'features/project/presentation/bloc/subtask_bloc.dart';
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
    BlocProvider.of<AuthBloc>(context).stream.listen(
      (state) {
        if (state is Authenticated) {
          loginInfo.login();
        }
        else if(state is UnAuthenticated){
          loginInfo.logout();
        }
      },
    );

    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  void dispose() {
    customTheme.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Project Manager',
      debugShowCheckedModeBanner: false,
      theme: customTheme.lightTheme,
      darkTheme: customTheme.darkTheme,
      themeMode: customTheme.currentTheme,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
    );
  }
}

// class InitialPage extends StatelessWidget {
//   const InitialPage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       initialData: FirebaseAuth.instance.currentUser,
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData &&
//             snapshot.connectionState == ConnectionState.active) {
//           return HomePage();
//         }
//         return const AuthenticatePage(
//           child: dartz.Left(SignInPage()),
//         );
//       },
//     );
//   }
// }
