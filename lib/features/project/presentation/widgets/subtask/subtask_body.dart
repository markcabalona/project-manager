import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/presentation/widgets/error_widget.dart';
import '../../bloc/subtask_bloc.dart';

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
