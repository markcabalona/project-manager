import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:todo/features/project/domain/entities/subtask.dart';
import 'package:todo/features/project/presentation/widgets/subtask/subtask_tile.dart';

import '../../bloc/subtask_bloc.dart';

class SubtaskBody extends StatelessWidget {
  const SubtaskBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Subtask> subtasks = const [];

    return BlocConsumer<SubtaskBloc, SubtaskState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case UpdatingSubtask:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text("Updating Subtask"),
                ),
              );
            break;
          case SubtaskUpdated:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text("Subtask Updated"),
                ),
              );
            break;
          case DeletingSubtask:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text("Deleting Subtask"),
                ),
              );
            break;
          case SubtaskDeleted:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text("Subtask Deleted"),
                ),
              );
            break;
          default:
        }

        if (state is SubtasksLoaded) {
          subtasks = state.subtasks;
        }
        if (state is CreatingSubtask) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("Creating Subtask"),
              ),
            );
        }
        if (state is SubtaskCreated) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("${state.subtask.title} is created"),
              ),
            );
        }
        if (state is SubtaskError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
        }
      },
      builder: (context, state) {
        if (subtasks.isEmpty && state is SubtasksLoaded) {
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
          return Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...subtasks.map(
                (subtask) => Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: SubtaskTile(
                    subtask: subtask,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
