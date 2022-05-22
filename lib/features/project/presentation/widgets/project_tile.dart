import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/project/domain/usecases/delete_project.dart';
import 'package:todo/features/project/presentation/bloc/project_bloc.dart';
import 'package:todo/features/project/presentation/widgets/project_dialog_form.dart';

import '../../domain/entities/project.dart';

class ProjectTile extends StatelessWidget {
  final Project project;
  const ProjectTile({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editBtnKey = GlobalKey();
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onTap: () {
        // TODO: Navigate to specific project page
      },
      leading: project.isFinished ? const Icon(Icons.done_rounded) : null,
      title: Text(
        project.title,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Text(
        project.description,
        maxLines: 3,
        style: Theme.of(context).textTheme.subtitle2?.copyWith(
              height: 1,
              fontStyle: FontStyle.italic,
              overflow: TextOverflow.ellipsis,
            ),
      ),
      trailing: SizedBox(
        width: 96,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (!project.isFinished)
              IconButton(
                key: editBtnKey,
                onPressed: () {
                  final offset = (editBtnKey.currentContext?.findRenderObject()
                          as RenderBox)
                      .localToGlobal(Offset.zero);
                  showGeneralDialog(
                    context: context,
                    pageBuilder: (context, anim1, anim2) {
                      return ProjectDialogForm(project: project);
                    },
                    transitionBuilder: (context, anim1, anim2, child) {
                      return Transform.scale(
                        scaleY: anim1.value,
                        origin: Offset(
                          0,
                          -((MediaQuery.of(context).size.height / 2) -
                              offset.dy),
                        ),
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 300),
                  );
                },
                icon: const Icon(Icons.edit_outlined),
              ),
            IconButton(
              onPressed: () {
                BlocProvider.of<ProjectBloc>(context).add(
                  DeleteProjectEvent(
                    params: DeleteProjectParams(projectId: project.id),
                  ),
                );
              },
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }
}
