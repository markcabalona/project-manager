import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../core/presentation/widgets/error_widget.dart';
import '../../domain/entities/project.dart';
import '../bloc/subtask_bloc.dart';

class ProjectPage extends StatelessWidget {
  final Project project;
  const ProjectPage({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubtaskBloc, SubtaskState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: AppBar(),
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
      ),
    );
  }
}

class SubtaskBody extends StatelessWidget {
  const SubtaskBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubtaskBloc, SubtaskState>(
      builder: (context, state) {
        if (state is SubtasksLoaded) {
          if (state.subtasks.isEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.listOl,
                    size: 64,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "No subtasks yet.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              children: const [],
            );
          }
        } else if (state is SubtaskError) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        } else {
          return const Center(
            child: RepaintBoundary(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

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
