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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onTap: () {},
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
