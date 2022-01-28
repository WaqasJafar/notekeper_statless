import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notekeper_statless/getx_controller/notelist_controller.dart';
import 'package:notekeper_statless/pages/note_detail_page.dart';
import 'package:notekeper_statless/pages/note_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "Notekeeper",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: NoteListPage());
  }
}
