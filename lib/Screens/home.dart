import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/taskModel.dart';
import '../controllers/task_db_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskDB = Get.put(TaskDBController());
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context, builder: (context) => mydialogbox(null));
          },
          child: Text('Add'),
        ),
        body: ListView.builder(
            itemCount: taskDB.tasklist.length,
            itemBuilder: (context, index) {
              TaskModel myData = taskDB.tasklist[index];
              return ListTile(
                title: Text(myData.title),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => mydialogbox(myData));
                        },
                        icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          taskDB.deleteData(myData.id);
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              );
            }),
      ),
    );
  }
}

Widget mydialogbox(TaskModel? item) {
  final taskDB = Get.put(TaskDBController());
  final TextEditingController titleController = TextEditingController();

  if (item != null) {
    titleController.text = item.title;
  }
  return AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(item != null ? "Update Item" : "Add Item"),
        TextFormField(
          controller: titleController,
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          if (titleController.text.isNotEmpty) {
            item != null
                ? taskDB.updateData(titleController.text, item.id)
                : taskDB.addData(titleController.text);
            Get.back();
            titleController.clear();
          }
        },
        child: Text(item != null ? "Update" : "Add"),
      ),
      TextButton(
        onPressed: () {
          Get.back();
          titleController.clear();
        },
        child: Text("Cancel"),
      ),
    ],
  );
}
