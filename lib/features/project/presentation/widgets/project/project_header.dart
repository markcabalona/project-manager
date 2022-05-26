import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/project.dart';

class ProjectHeader extends StatelessWidget {
  const ProjectHeader({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMMMMd();
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Last updated at: ${formatter.format(project.lastUpdated)}',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Text(
          project.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          project.description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
