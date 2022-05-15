import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/entities/project.dart';

class ProjectHomePage extends StatelessWidget {
  final List<Project> projects;
  const ProjectHomePage({
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

    return SingleChildScrollView(
      child: Column(
        children: [
          const Text("Active Projects"),
          ...projects.map((project) {
            if (project.isFinished) {
              return const SizedBox();
            }
            return ListTile(
              title: Text(project.title),
            );
          }),
        ],
      ),
    );
  }
}
