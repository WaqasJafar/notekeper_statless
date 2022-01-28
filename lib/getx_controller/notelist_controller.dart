import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notekeper_statless/database_utils/database_helper.dart';
import 'package:notekeper_statless/models/note.dart';
import 'package:notekeper_statless/pages/note_detail_page.dart';
import 'package:sqflite/sqlite_api.dart';

class NoteListController extends GetxController {
  DatabaseHelper databaseHelper = DatabaseHelper();
  RxList<Note> list = RxList<Note>();

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Notes Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String title) async {
    bool result = await Get.to(NoteDetailPage());

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() async {
    List<Note> noteListFuture = await databaseHelper.getNoteList();
    list.assignAll(noteListFuture);
    print(list.length);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updateListView();
  }
}
