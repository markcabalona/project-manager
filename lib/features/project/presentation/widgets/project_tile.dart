
import 'package:flutter/material.dart';

import '../../domain/entities/project.dart';

class ProjectTile extends StatelessWidget {
  final Project project;
  const ProjectTile({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(project.title),
      subtitle: Text(project.description),
      trailing: SizedBox(
        width: 96,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                // TODO: call edit project
              },
              icon: const Icon(Icons.edit_outlined),
            ),
            IconButton(
              onPressed: () {
                //TODO: call delete project
              },
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }
}
