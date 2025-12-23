import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:practice_flutter_application_25/models/toDoListModelClass.dart';
import 'package:practice_flutter_application_25/services/databaseService.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final DatabaseServices _databaseServices = DatabaseServices.instance;

  //
  List<ToDoListModelClass> toDoList = [];

  //
  bool isEditing = false;

  //
  int sentId = 0;

  //
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  //
  List<Color> containerColors = [
    Color.fromRGBO(253, 236, 236, 1),
    Color.fromRGBO(239, 236, 255, 1),
    Color.fromRGBO(250, 255, 214, 1),
    Color.fromRGBO(220, 251, 228, 1),
  ];

  ////////////////////////////////////////////////////
  ////////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    List<ToDoListModelClass> tasks = await _databaseServices.getMyTask();
    setState(() {
      toDoList = tasks;
    });
    print("--------------------In loadTasks-------------------------------\n");
    int num = toDoList.length;
    print("$num");
  }

  ////////////////////////////////////////////////////
  ////////////////////////////////////////////////////
  void showMyDatePicker() async {
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

  ////////////////////////////////////////////////////
  ////////////////////////////////////////////////////
  void editTask(ToDoListModelClass toDoModelObject) {
    _titleController.text = toDoModelObject.title;
    _descriptionController.text = toDoModelObject.description;
    _dateController.text = toDoModelObject.date;

    _showMyDialog(toDoModelObject);
    setState(() {
      isEditing = true;
    });
  }
  ////////////////////////////////////////////////////
  ////////////////////////////////////////////////////

  void addTheCard(ToDoListModelClass? toDoModelObjet) {
    if (_titleController.text.trim().isNotEmpty &&
        _descriptionController.text.trim().isNotEmpty &&
        _dateController.text.trim().isNotEmpty) {
      if (isEditing == false) {
        _databaseServices.addTheTask(
          _titleController.text.trim(),
          _descriptionController.text.trim(),
          _dateController.text.trim(),
        );
        loadTasks();
      } else {
        _databaseServices.updateMyTask(
          sentId,
          toDoModelObjet!.title,
          toDoModelObjet.description,
          toDoModelObjet.date,
        );
        loadTasks();
      }
    }
    setState(() {
      isEditing = false;
    });
    clearControllers();
  }

  ////////////////////////////////////////////////////
  ////////////////////////////////////////////////////
  void clearControllers() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("To-Do List", style: GoogleFonts.quicksand(fontSize: 25)),
        backgroundColor: const Color.fromARGB(255, 161, 208, 246),
      ),
      body: (toDoList.isEmpty)
          ? Center(
              child: Text(
                "Nothing added yet! Add task.",
                style: GoogleFonts.quicksand(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                final task = toDoList[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Align(
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width - 70,
                      decoration: BoxDecoration(
                        color: containerColors[index % containerColors.length],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 202, 201, 201),
                            blurRadius: 20,
                            spreadRadius: 3,
                            offset: Offset(0, 20),
                          ),
                        ],
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
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
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
                                            height: 60,
                                            child: SingleChildScrollView(
                                              child: Text(
                                                task.description,
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 20,
                                              child: Row(
                                                children: [
                                                  const Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      print(task.id);
                                                      editTask(task);
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
                                                      _databaseServices
                                                          .deleteTask(task.id);
                                                      loadTasks();
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
        mini: true,
        backgroundColor: const Color.fromARGB(255, 161, 208, 246),
        onPressed: () {
          clearControllers();
          _showMyDialog();
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  void _showMyDialog([ToDoListModelClass? toDoModelObject]) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Add task", style: GoogleFonts.quicksand(fontSize: 25)),
              ],
            ),
            //////////////////////////////////////////////
            //////////////////////////////////////////////
            //////////////////////////////////////////////
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title", style: GoogleFonts.quicksand(fontSize: 15)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: 40,
                      width: 400,
                      child: TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  //////////////////////////////
                  //////////////////////////////
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      "Description ",
                      style: GoogleFonts.quicksand(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: 70,
                      width: 400,
                      child: TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),

                  //////////////////////////////
                  //////////////////////////////
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      "Date ",
                      style: GoogleFonts.quicksand(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: 40,
                      width: 400,
                      child: TextField(
                        controller: _dateController,
                        readOnly: true,
                        onTap: () => showMyDatePicker(),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  //////////////////////////////
                  //////////////////////////////
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: GestureDetector(
                      onTap: () {
                        addTheCard(toDoModelObject);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 400,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 161, 208, 246),
                          borderRadius: BorderRadius.circular(20),
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
            ),
          ],
        ),
      ),
    );
  }
}
