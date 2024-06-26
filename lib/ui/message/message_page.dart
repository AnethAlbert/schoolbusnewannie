import 'package:flutter/material.dart';
import 'package:newschoolbusapp/core/controllers/message_controller.dart';

import '../../core/utils/app_colors.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/loading_dialog.dart';

class MessageEditorPage extends StatefulWidget {
  const MessageEditorPage({
    super.key,
    required this.tripId,
  });

  final int tripId;

  @override
  State<MessageEditorPage> createState() => _MessageEditorPageState();
}

class _MessageEditorPageState extends State<MessageEditorPage> {
  final TextEditingController _editingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late MessageController messageController;

  @override
  void initState() {
    messageController = MessageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Create Message"),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Create emergency broadcast message to reach out the parents for all students in this route.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          15.0,
                          5,
                          15,
                          15,
                        ),
                        child: TextField(
                          focusNode: _focusNode,
                          controller: _editingController,
                          cursorColor: AppColors.linearBottom,
                          style: const TextStyle(
                            color: AppColors.blackColor,
                          ),
                          decoration: const InputDecoration(
                            hintText: "Write your message here...",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          scrollPadding: const EdgeInsets.all(20.0),
                          keyboardType: TextInputType.multiline,
                          maxLines: 99999,
                          autofocus: true,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.linearMiddle,
            onPressed: () async {
              if (_editingController.text.isEmpty) {
                return;
              }
              FocusScope.of(context).unfocus();

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Alert"),
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            "By tapping 'Yes', this broadcast message will be sent to all students' parents for this route. Are you sure you want to proceed?"),
                        SizedBox(height: 10),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "No",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          loadingDialog(context);
                          bool result = await messageController.sendMessage(
                              _editingController.text, widget.tripId);
                          if (mounted) {
                            Navigator.pop(context);
                            if (result) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              customSnackBar(
                                context,
                                "Success",
                                Colors.green,
                              );
                            } else {
                              customSnackBar(
                                context,
                                "Error: Failed to send message.",
                                Colors.red,
                              );
                            }
                          }
                        },
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
