import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/presentation/widgets/theme_mode_iconbutton.dart';
import 'package:todo/core/themes.dart';

import '../../../../core/presentation/widgets/error_widget.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/project_bloc.dart';
import 'project_home_page.dart';

class HomePage extends StatelessWidget {
  final User user;
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Image.asset(
              'assets/images/${customTheme.currentTheme == ThemeMode.light ? 'logo-light' : 'logo-dark'}.png',
            ),
          ),
        ),
        title: const Center(
          child: Text(
            "Projects",
          ),
        ),
      ),
      endDrawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
              },
              icon: const Icon(Icons.logout),
            ),
            const ThemeModeIconButton(),
          ],
        ),
      ),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        builder: (context, state) {
          if (state is ProjectsLoaded) {
            return ProjectHomePage(projects: state.projects);
          } else if (state is ProjectError) {
            return CustomErrorWidget(errorMessage: state.errorMessage);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
