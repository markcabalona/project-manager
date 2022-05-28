import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/features/project/domain/entities/subtask.dart';
import 'package:todo/features/project/presentation/bloc/project_bloc.dart';
import 'package:todo/features/project/presentation/widgets/task_dialog_form.dart';

class SubtaskTile extends StatefulWidget {
  final Subtask subtask;
  const SubtaskTile({
    Key? key,
    required this.subtask,
  }) : super(key: key);

  @override
  State<SubtaskTile> createState() => _SubtaskTileState();
}

class _SubtaskTileState extends State<SubtaskTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late bool isExpanded;
  double _angle = 0;
  late final editBtnKey;

  @override
  void initState() {
    isExpanded = false;
    editBtnKey = GlobalKey();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _controller.addListener(() {
      setState(() {
        _angle = (_controller.value * 90 * math.pi) / 180;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      tileColor: Theme.of(context).colorScheme.onSecondary,
      textColor: Theme.of(context).colorScheme.secondary,
      title: Text(widget.subtask.title),
      subtitle: AnimatedSize(
        duration: _controller.duration!,
        curve: Curves.easeInOut,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.subtask.description),
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  height: 200,
                  alignment: Alignment.topLeft,
                  //TODO: implement todos
                  child: const Text('List of TODOs\n...\n...\n...\n...'),
                ),
              ),
          ],
        ),
      ),
      leading: IconButton(
        onPressed: () {
          setState(() {
            !isExpanded ? _controller.forward() : _controller.reverse();
            isExpanded = !isExpanded;
          });
        },
        icon: Transform.rotate(
          angle: _angle,
          child: const Icon(
            FontAwesomeIcons.angleRight,
          ),
        ),
      ),
      trailing: widget.subtask.isFinished
          ? null
          : SizedBox(
              width: 96,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!widget.subtask.isFinished)
                    IconButton(
                      key: editBtnKey,
                      onPressed: () {
                        final offset = (editBtnKey.currentContext
                                ?.findRenderObject() as RenderBox)
                            .localToGlobal(Offset.zero);
                        showGeneralDialog(
                          context: context,
                          pageBuilder: (context, anim1, anim2) {
                            return RepaintBoundary(
                              child: TaskDialogForm(
                                headerTitle: 'Update Subtask',
                                buttonText: 'Update',
                                loadingMessage: 'Updating Subtask',
                                onSubmit: (String title, String description) {
                                  // TODO: Implement Update subtask
                                },
                              ),
                            );
                          },
                          transitionBuilder: (context, anim1, anim2, child) {
                            return Transform.scale(
                              scaleY: anim1.value,
                              origin: Offset(
                                0,
                                -((MediaQuery.of(context).size.height / 2) -
                                    offset.dy),
                              ),
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 300),
                        );
                      },
                      icon: const Icon(Icons.edit_outlined),
                    ),
                  IconButton(
                    onPressed: () {
                      // TODO: Implement delete subtask
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            ),
    );
  }
}
