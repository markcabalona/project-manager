import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/features/project/domain/entities/subtask.dart';
import 'package:todo/features/project/presentation/bloc/subtask_bloc.dart';
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
  late final GlobalKey editBtnKey;

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
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          widget.subtask.title,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: AnimatedSize(
          duration: _controller.duration!,
          curve: Curves.easeInOut,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.subtask.description,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        height: 1,
                        fontStyle: FontStyle.italic,
                        overflow: TextOverflow.ellipsis,
                      ),
                ),
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
                                  initialTitle: widget.subtask.title,
                                  initialDesc: widget.subtask.description,
                                  onSubmit: (String title, String description) {
                                    BlocProvider.of<SubtaskBloc>(context).add(
                                      UpdateSubtaskEvent(
                                        subtask: widget.subtask.copyWith(
                                          subtaskTitle: title,
                                          description: description,
                                        ),
                                      ),
                                    );
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
                            transitionDuration:
                                const Duration(milliseconds: 300),
                          );
                        },
                        icon: const Icon(Icons.edit_outlined),
                      ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<SubtaskBloc>(context).add(
                          DeleteSubtaskEvent(subtaskID: widget.subtask.id),
                        );
                      },
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
