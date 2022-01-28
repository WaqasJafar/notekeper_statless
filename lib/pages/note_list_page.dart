import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notekeper_statless/getx_controller/notelist_controller.dart';
import 'package:notekeper_statless/models/note.dart';
import 'package:notekeper_statless/pages/note_detail_page.dart';

class NoteListPage extends StatelessWidget {
  NoteListPage({Key key}) : super(key: key);

  int count = 0;
  NoteListController controller = Get.put(NoteListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool result = await Get.to(() => NoteDetailPage());
          if (result == true) {
            controller.updateListView();
          }
        },
        tooltip: 'Add Notes',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getNoteListView() {
    return Obx(
      () => ListView.builder(
        itemCount: controller.list.length,
        itemBuilder: (BuildContext context, int position) {
          Note note = controller.list[position];

          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text(controller.getFirstLetter(note.title) ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              title: Text(note.title,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(note.description ?? ""),
                  Text(note.date ?? ""),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onTap: () {
                      controller.delete(context, note);
                    },
                  ),
                ],
              ),
              onTap: () {
                debugPrint("ListTile Tapped");
                controller.navigateToDetail(note, 'Edit Notes');
              },
            ),
          );
        },
      ),
    );
  }
}
