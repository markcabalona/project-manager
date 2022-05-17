
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/core/presentation/widgets/theme_mode_iconbutton.dart';
import 'package:todo/features/project/presentation/widgets/custom_appbar_leading.dart';

import '../../../../core/presentation/widgets/error_widget.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/project_bloc.dart';
import '../widgets/homepage_body.dart';

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
        leading: const CustomAppBarLeading(),
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
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<ProjectBloc>(context).add(FetchProjectsEvent());
        },
        child: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is LoadingProject) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProjectError) {
              return CustomErrorWidget(errorMessage: state.errorMessage);
            }
            return HomePageBody(projects: (state as ProjectsLoaded).projects);
          },
        ),
      ),
    );
  }
}
