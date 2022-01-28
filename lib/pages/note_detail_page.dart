import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notekeper_statless/getx_controller/notedetail_controller.dart';



class NoteDetailPage extends StatelessWidget {
  NoteDetailController controllerDetail = Get.put(NoteDetailController());
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    return WillPopScope(
      onWillPop: () {
        controllerDetail.moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Notes"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                controllerDetail.moveToLastScreen();
              }),
        ),
        body: Form(

         key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextFormField(
                  controller: controllerDetail.titleController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: textStyle,
                  onChanged: (value) {
                    controllerDetail.updateTitle();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter the Title in String";
                    }else if (value.length >=16){
                      return "The value is greater then sixteen";
                    }else if (!GetUtils.isAlphabetOnly(value)){
                      return "Enter Only alphabets value";
                    }
                    return null;
                  },

                  decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextFormField(
                  controller: controllerDetail.descriptionController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: textStyle,
                  onChanged: (value) {
                    debugPrint('Something changed in Description Text Field');
                    controllerDetail.updateDescription();

                  },
                  maxLength: 8,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter the valide length";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(50, 50)

                  ),
                  child: Text(
                    'Save',
                    textScaleFactor: 1.5,
                  ),
                  onPressed: () {
                    debugPrint("Save button clicked");
                    if (_formKey.currentState.validate()) {
                      print("Data add Successfully");
                      controllerDetail.save();
                    }

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
