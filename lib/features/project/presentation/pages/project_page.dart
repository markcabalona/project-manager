import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/project.dart';
import '../../domain/usecases/create_subtask.dart';
import '../bloc/subtask_bloc.dart';
import '../widgets/project/project_header.dart';
import '../widgets/subtask/subtask_body.dart';
import '../widgets/task_dialog_form.dart';

class ProjectPage extends StatelessWidget {
  final Project project;
  const ProjectPage({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                            projectId: project.id,
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
              child: ProjectHeader(project: project),
            ),
            const SubtaskBody(),
          ],
        ),
      ),
    );
  }
}
