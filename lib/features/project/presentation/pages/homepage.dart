import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/widgets/error_widget.dart';
import '../../../../core/presentation/widgets/theme_mode_iconbutton.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/project_bloc.dart';
import '../widgets/custom_appbar_leading.dart';
import '../widgets/homepage_body.dart';
import '../widgets/project/project_dialog_form.dart';


class HomePage extends StatelessWidget {
  final User user;
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: BlocProvider.of<ProjectBloc>(context).stream.isEmpty,
        builder: (context, result) {
          if (!result.hasData) {
            BlocProvider.of<ProjectBloc>(context).add(FetchProjectsEvent());
          }
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: kToolbarHeight,
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (context, anim1, anim2) {
                    return const ProjectDialogForm();
                  },
                  transitionBuilder: (context, anim1, anim2, child) {
                    return Transform.scale(
                      scale: anim1.value,
                      origin: Offset(
                        MediaQuery.of(context).size.width / 2,
                        MediaQuery.of(context).size.height / 2,
                      ),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                );
              },
              child: const Icon(Icons.add),
            ),
            body: SizedBox.expand(
              child: LayoutBuilder(
                builder: (context, boxConstraints) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<ProjectBloc>(context)
                          .add(FetchProjectsEvent());
                    },
                    triggerMode: RefreshIndicatorTriggerMode.onEdge,
                    child: BlocBuilder<ProjectBloc, ProjectState>(
                      builder: (context, state) {
                        if (state is LoadingProject) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is ProjectError) {
                          return CustomErrorWidget(
                              errorMessage: state.errorMessage);
                        }
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: boxConstraints.maxHeight,
                            ),
                            child: HomePageBody(
                              projects: (state as ProjectsLoaded).projects,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
