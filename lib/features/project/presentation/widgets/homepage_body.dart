import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (activeProjs.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Active Projects",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          ...activeProjs.map(
            (unfinishedProj) => ProjectTile(project: unfinishedProj),
          ),
        ] else ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "No Active Projects",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
        if (finishedProjs.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Finished Projects",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          ...finishedProjs
              .map((finishedProj) => ProjectTile(project: finishedProj))
        ]
      ],
    );
  }
}
