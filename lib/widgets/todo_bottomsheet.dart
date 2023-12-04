import "dart:ffi";

import "package:flutter/material.dart";

class TodoBottomSheet extends StatefulWidget {
  TodoBottomSheet({super.key});

  @override
  State<TodoBottomSheet> createState() => _TodoBottomSheetState();
}

TextEditingController textController = TextEditingController();
String? errorText;

class _TodoBottomSheetState extends State<TodoBottomSheet> {
  bool validate() {
    final text = textController.value.text;

    if (text.isEmpty) {
      setState(() {
        errorText = "Pole nie może być puste";
      });
      return false;
    }
    setState(() {
      errorText = null;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Wrap(
        runSpacing: 20,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 30,
            ),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: "Dodaj todo",
                border: OutlineInputBorder(),
                errorText: errorText,
              ),
              onChanged: (value) {
                validate();
              },
              onEditingComplete: () {
                validate() ? Navigator.pop(context, textController.text) : null;
                textController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
