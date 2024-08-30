import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YOUR TO-DO LIST'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          //show guiding text when the list is empty
          Padding(
              padding: const EdgeInsets.all(8),
              child: Obx(() => Text(controller.textCheck()))),

          //adding tasks section
          AddTask(controller: controller),

          //a responsive space between sections
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),

          //viewing tasks
          TaskTile(controller: controller),
        ],
      ),
    );
  }
}

class AddTask extends StatelessWidget {
  const AddTask({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.75,
            child: TextField(
              controller: controller.inputController.value,
              decoration: const InputDecoration(hintText: "Add a task..."),
            )),
        ElevatedButton.icon(
          label: const Text('ADD'),
          icon: const Icon(Icons.add),
          onPressed: () {
            controller.addTask(
                controller.inputController.value.text); //adding to tasks list
            controller.inputController.value.text =
                ''; //empty text field when task is added
          },
        ),
      ],
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        //interactive list updating when a task is added or deleted
        return ListView.builder(
          itemCount: controller.tasks.length,
          itemBuilder: (context, index) {
            return Card(
                //decorate each task with an elevated card
                color: //with two colors alternating (easier on the eyes)
                    (index % 2 == 0) ? Colors.white : Colors.blueGrey.shade50,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.05,
                    vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      //task title or name
                      padding: const EdgeInsets.all(8.0),
                      child: Text(controller.tasks[index].name),
                    ),
                    Row(
                      children: [
                        Obx(() {
                          //checkbox value changing when pressed
                          return Checkbox(
                              value: controller.tasks[index].checked.value,
                              onChanged: (value) {
                                controller.markCompleted(index);
                              });
                        }),
                        IconButton(
                            //a remove button beside each task
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              controller.removeTask(index);
                            }),
                      ],
                    )
                  ],
                ));
          },
        );
      }),
    );
  }
}
