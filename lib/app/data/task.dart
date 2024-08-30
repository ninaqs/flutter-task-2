import 'package:get/get.dart';

class Task {
  //each task is an object with name and boolean checked value
  String name;
  late RxBool checked;

  Task({required this.name, required bool checked}) {
    this.checked = checked.obs;
    this.name = name;
  }
}
