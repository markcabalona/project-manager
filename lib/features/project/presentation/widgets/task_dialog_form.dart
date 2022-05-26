import 'package:flutter/material.dart';

class TaskDialogForm extends StatelessWidget {
  final String headerTitle;
  final String buttonText;
  final String? initialTitle;
  final String? initialDesc;
  final void Function(String title, String description) onSubmit;
  final String loadingMessage;

  const TaskDialogForm({
    Key? key,
    required this.headerTitle,
    required this.buttonText,
    this.initialTitle,
    this.initialDesc,
    required this.onSubmit,
    required this.loadingMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final titleCtrl = TextEditingController(text: initialTitle);
    final descCtrl = TextEditingController(text: initialDesc);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        vertical: 80,
        horizontal: 20,
      ),
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            bottom: 10,
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    headerTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      hintText: "Project Title",
                      label: Text("Title"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descCtrl,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: "Project Short Description",
                      hintMaxLines: 3,
                      alignLabelWithHint: true,
                      label: Text("Description"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              onSubmit(
                                titleCtrl.text,
                                descCtrl.text,
                              );

                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text(loadingMessage),
                                  ),
                                );
                              Navigator.pop(context);
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
