import 'package:get/get.dart';
import 'package:sqlitedemo/Database/task_db.dart';

class TaskDBController extends GetxController {
  RxList tasklist = [].obs;

  getData() async {
    tasklist.value = await TaskDB().fetchAllData();
  }

  addData(title) async {
    await TaskDB().insertData(title: title);
    getData();
  }

  updateData(title, id) async {
    await TaskDB().updateData(id: id, title: title);
    getData();
  }

  deleteData(id) async {
    await TaskDB().deleteData(id: id);
    getData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }
}
