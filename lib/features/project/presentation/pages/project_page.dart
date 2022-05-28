import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/routes/routes.dart';
import '../../../../core/presentation/widgets/error_widget.dart';
import '../../domain/entities/project.dart';
import '../../domain/usecases/create_subtask.dart';
import '../bloc/project_bloc.dart';
import '../bloc/subtask_bloc.dart';
import '../widgets/project/project_header.dart';
import '../widgets/subtask/subtask_body.dart';
import '../widgets/task_dialog_form.dart';

class ProjectPage extends StatelessWidget {
  final Project? projectParams;
  final String projectID;
  const ProjectPage({
    Key? key,
    this.projectParams,
    required this.projectID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Project? project;
    if (projectParams == null) {
      BlocProvider.of<ProjectBloc>(context).add(
        FetchProjectsEvent(),
      );
    } else {
      project = projectParams!;
    }
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, projectState) {
        if (projectState is LoadingProject) {
          return const Scaffold(
            body: Center(
              child: RepaintBoundary(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (projectState is ProjectsLoaded) {
          if (projectParams == null) {
            final projects = projectState.projects
                .where((project) => project.id == projectID)
                .toList();

            if (projects.isNotEmpty) {
              project = projects.first;
            } else {
              return const CustomErrorWidget(
                errorMessage:
                    "This project might be deleted\nor\nYou do not have permission to see this project.",
              );
            }
          }
          BlocProvider.of<SubtaskBloc>(context).add(
            FetchSubtasksEvent(projectId: projectID),
          );
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => context.goNamed(Routes.home.name),
              ),
            ),
            floatingActionButton: RepaintBoundary(
              child: FloatingActionButton(
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    pageBuilder: (context, anim1, anim2) {
                      return RepaintBoundary(
                        child: TaskDialogForm(
                          headerTitle: 'New Subtask',
                          buttonText: 'Create',
                          loadingMessage: 'Creating Subtask',
                          onSubmit: (String title, String description) {
                            BlocProvider.of<SubtaskBloc>(context).add(
                              CreateSubtaskEvent(
                                newSubtask: CreateSubtaskParams(
                                  projectId: project!.id,
                                  title: title,
                                  description: description,
                                  isPriority: false,
                                ),
                              ),
                            );
                          },
                        ),
                      );
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
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProjectHeader(project: project!),
                  ),
                  const SubtaskBody(),
                ],
              ),
            ),
          );
        }

        return const CustomErrorWidget(
          errorMessage: 'Error occured while fetching data to the server.',
        );
      },
    );
  }
}
