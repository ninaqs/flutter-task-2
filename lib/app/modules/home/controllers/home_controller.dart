import 'package:flutter/material.dart';
import 'package:flutter2/app/data/task.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<Task> tasks = RxList<Task>([]);                                    //list of current tasks
  Rx<TextEditingController> inputController = TextEditingController().obs;  //cotroller of task input
  RxString text = RxString('');                                             //guiding text on the top of page

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  addTask(String task) {
    if (task.isNotEmpty) {
      //not adding empty strings as tasks
      tasks.add(Task(name: task, checked: false));
    }
  }

  removeTask(int index) {
    //index is always in range (listview builer)
    tasks.removeAt(index);
  }

  void markCompleted(index) {
    //reverse the value of checkbox
    tasks[index].checked.value = !tasks[index].checked.value;
  }

  String textCheck() {
    if (tasks.isEmpty) {
      return "Your curreny To-Do list is empty, try adding some tasks";
    } else {
      return '';
    }
  }
}
