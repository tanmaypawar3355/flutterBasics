import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:intl/intl.dart';
import 'package:practice_flutter_application_22/models/toDoListModel.dart';
import 'package:practice_flutter_application_22/services/myDatabase.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final DatabaseServices _databaseService = DatabaseServices.instance;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  List toDoList = [];
  List<Color> containerColors = [
    Color.fromRGBO(250, 232, 232, 1),
    Color.fromRGBO(232, 237, 250, 1),
    Color.fromRGBO(250, 226, 214, 1),
    Color.fromRGBO(250, 232, 250, 1),
  ];

  //
  bool isEditing = false;
  int? sentId;

  ////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    loadTasks();
  }
  //

  Future<void> loadTasks() async {
    List tasks = await _databaseService.getMyTasks();

    setState(() {
      toDoList = tasks;
    });
  }

  ////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////

  void addTheCard(TodoListModel? toDoListModelObject) {
    if (_titleController.text.trim().isNotEmpty &&
        _descriptionController.text.trim().isNotEmpty &&
        _dateController.text.trim().isNotEmpty) {
      if (isEditing == false) {
        _databaseService.addTask(
          _titleController.text,
          _descriptionController.text,
          _dateController.text,
        );
      } else {
        _databaseService.updateMyTask(
          sentId,
          _titleController.text.trim(),
          _descriptionController.text.trim(),
          _dateController.text.trim(),
        );
      }
    }
    loadTasks();
    clearControllers();
    setState(() {
      isEditing = false;
      if (sentId != null) {
        sentId = null;
      }
    });
  }

  ////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////
  void editTask(int? id, TodoListModel toDoModelObject) {
    _titleController.text = toDoModelObject.title;
    _descriptionController.text = toDoModelObject.description;
    _dateController.text = toDoModelObject.date;

    setState(() {
      isEditing = true;
      sentId = id;
      showMyDialog(isEditing);
    });
  }

  ////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////
  void deleteMyTasks(int id) async {
    await _databaseService.deleteTask(id);
    await loadTasks();
  }
  ////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////

  void clearControllers() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (toDoList.isEmpty)
          ? Center(
              child: Text(
                "Nothing added yet! Add Some tasks",
                style: GoogleFonts.quicksand(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                final TodoListModel task = toDoList[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Align(
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width - 70,
                      decoration: BoxDecoration(
                        color: containerColors[index % containerColors.length],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: 90,
                                height: 150,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40.0),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Icon(
                                          Icons.task,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Text(
                                        task.date,
                                        style: GoogleFonts.quicksand(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ////////////////////////////////////////////
                          ////////////////////////////////////////////
                          ////////////////////////////////////////////
                          Expanded(
                            child: SizedBox(
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10,
                                  top: 15,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.title,
                                      style: GoogleFonts.quicksand(
                                        fontSize: 25,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 70,
                                            child: Text(
                                              task.description,
                                              style: GoogleFonts.quicksand(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 20,
                                            child: Row(
                                              children: [
                                                const Spacer(),
                                                GestureDetector(
                                                  onTap: () {
                                                    sentId = task.id;
                                                    editTask(
                                                      sentId = task.id,
                                                      toDoList[index],
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.edit_outlined,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                GestureDetector(
                                                  onTap: () {
                                                    deleteMyTasks(task.id);
                                                  },
                                                  child: Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(width: 15),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 124, 174, 227),
        onPressed: () {
          clearControllers();
          showMyDialog(false);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void showMyDialog(bool whichTask, [TodoListModel? toDoModelObject]) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Create Task", style: GoogleFonts.quicksand(fontSize: 25)),
              ],
            ),
            //////////////////////////////////////////
            //////////////////////////////////////////
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: Text(
                    "Title",
                    style: GoogleFonts.quicksand(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 4.0, left: 10),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ///////////////////////////////////////////////
                ///////////////////////////////////////////////
                ///////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: Text(
                    "Description",
                    style: GoogleFonts.quicksand(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ),
                    ),
                  ),
                ),
                ///////////////////////////////////////////////
                ///////////////////////////////////////////////
                ///////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                  child: Text(
                    "Date",
                    style: GoogleFonts.quicksand(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    onTap: () {
                      dateTime();
                    },
                    controller: _dateController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 4.0, left: 10),
                      suffixIcon: Icon(Icons.calendar_month_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ///////////////////////////////////////////////
                ///////////////////////////////////////////////
                ///////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      addTheCard(toDoModelObject);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 175, 211, 240),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: GoogleFonts.quicksand(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////

  void dateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat("dd/MM/yyyy").format(pickedDate);
      _dateController.text = formattedDate;
    }
  }
}
