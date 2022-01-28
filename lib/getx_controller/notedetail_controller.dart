import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:notekeper_statless/database_utils/database_helper.dart';
import 'package:notekeper_statless/models/note.dart';

class NoteDetailController extends GetxController {
  DatabaseHelper helper = DatabaseHelper();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void moveToLastScreen() {
    Get.back(result: true);
  }

  void save() async {
    moveToLastScreen();
    String titlename = titleController.text;
    String description = descriptionController.text;
    //moveToLastScreen();
    var datetime = DateFormat.yMMMd().format(DateTime.now());
    Note note = Note(titlename, datetime, description);
    int result;
    if (note.id != null) {
      // Case 1: Update operation
      result = await helper.updateNote(note);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    }
    else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void delete(int id) async {
    moveToLastScreen();

    if (id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    int result = await helper.deleteNote(id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    Get.dialog(alertDialog);
  }

  void updateTitle() {
    titleController.text;
  }

// Update the description of todo object
  void updateDescription() {
    descriptionController.text;
  }
}
