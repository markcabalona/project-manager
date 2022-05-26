import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/project.dart';
import '../../../domain/usecases/create_project.dart';
import '../../bloc/project_bloc.dart';



class ProjectDialogForm extends StatelessWidget {
  final Project? project;

  const ProjectDialogForm({
    Key? key,
    this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final titleCtrl = TextEditingController(text: project?.title);
    final descCtrl = TextEditingController(text: project?.description);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        vertical: 80,
        horizontal: 20,
      ),
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            bottom: 10,
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    project == null ? "New Project" : 'Update Project',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      hintText: "Project Title",
                      label: Text("Title"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descCtrl,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: "Project Short Description",
                      hintMaxLines: 3,
                      alignLabelWithHint: true,
                      label: Text("Description"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<ProjectBloc>(context).add(
                                project == null
                                    ? CreateProjectEvent(
                                        newProj: CreateProjectParams(
                                          title: titleCtrl.text,
                                          description: descCtrl.text,
                                          isPriority: false,
                                        ),
                                      )
                                    : UpdateProjectEvent(
                                        project: project!.copyWith(
                                          title: titleCtrl.text,
                                          description: descCtrl.text,
                                        ),
                                      ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text(project==null?"Creating project":"Updating project"),
                                  ),
                                );
                              Navigator.pop(context);
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            project == null ? "Add" : 'Update',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
