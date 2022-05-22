import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/features/project/presentation/bloc/project_bloc.dart';
import 'package:todo/features/project/presentation/widgets/project_tile.dart';

import '../../domain/entities/project.dart';

class HomePageBody extends StatelessWidget {
  final List<Project> projects;
  const HomePageBody({
    Key? key,
    required this.projects,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.listCheck,
              size: 64,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "No projects to show.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      );
    }
    List<Project> activeProjs =
        projects.where((proj) => !proj.isFinished).toList();
    List<Project> finishedProjs =
        projects.where((proj) => proj.isFinished).toList();
    return BlocConsumer<ProjectBloc, ProjectState>(listener: (context, state) {
      if (state is ProjectError) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
      }
      if (state is ProjectCreated) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text("${state.newProject.title} is created"),
            ),
          );
      }
      if (state is ProjectUpdated) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text("Project updated."),
            ),
          );
      }
      if (state is ProjectDeleted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text("Project deleted."),
            ),
          );
      }
      if (state is ProjectsLoaded) {}
    }, builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (activeProjs.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Active Projects",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            ...activeProjs.map(
              (activeProj) => Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                child: ProjectTile(project: activeProj),
              ),
            ),
          ] else ...[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "No Active Projects",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ],
          if (finishedProjs.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Finished Projects",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            ...finishedProjs.map(
              (finishedProj) => Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                child: ProjectTile(project: finishedProj),
              ),
            )
          ],
          const SizedBox(
            height: 60,
          ),
        ],
      );
    });
  }
}
