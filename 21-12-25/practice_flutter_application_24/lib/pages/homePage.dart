import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:practice_flutter_application_24/models/ToDoListMOdel.dart';
import 'package:practice_flutter_application_24/services/DatabaseService.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _HomePageState();
}

class _HomePageState extends State<ToDoList> {
  //
  bool isEditing = false;

  //
  int sentId = 0;

  //
  List<ToDoListModelClass> toDoList = [];

  //
  final DatabaseServices _databaseService = DatabaseServices.instance;

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

  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////

  void showDateTimeModule() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String myDate = DateFormat("dd/MM/yyyy").format(pickedDate);
      _dateController.text = myDate;
    }
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    List<ToDoListModelClass> tasks = await _databaseService.getMyTasks();
    setState(() {
      toDoList = tasks;
    });
  }

  /////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  void deleteMyTask(int id) {
    print("-----------------$id------------------");
    _databaseService.deleteTask(id);
    loadTasks();
  }

  /////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  void editTask(ToDoListModelClass toDoModelObject) {
    _titleController.text = toDoModelObject.title;
    _descriptionController.text = toDoModelObject.description;
    _dateController.text = toDoModelObject.date;

    setState(() {
      isEditing = true;
    });

    _showMyDialog(toDoModelObject);
  }

  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  void addTheCard(ToDoListModelClass? toDoModelObject) {
    if (_titleController.text.trim().isNotEmpty &&
        _descriptionController.text.trim().isNotEmpty &&
        _dateController.text.trim().isNotEmpty) {
      if (isEditing == false) {
        _databaseService.addTask(
          _titleController.text,
          _descriptionController.text,
          _dateController.text,
        );
        loadTasks();
      } else {
        _databaseService.updateMyTask(
          sentId,
          _titleController.text.trim(),
          _descriptionController.text.trim(),
          _dateController.text.trim(),
        );
        loadTasks();
      }
    }
    setState(() {
      isEditing = false;
    });
  }

  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  void clearControllers() {
    _titleController.clear();
    _descriptionController.clear();
    _dateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List", style: GoogleFonts.quicksand(fontSize: 25)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 172, 164, 245),
      ),
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
                        border: Border.all(
                          width: 2.5,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 208, 207, 207),
                            blurRadius: 10,
                            spreadRadius: 3,
                            offset: Offset(0, 20),
                          ),
                          BoxShadow(
                            color: const Color.fromARGB(255, 237, 237, 237),
                            offset: Offset(0, 5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            blurStyle: BlurStyle.inner,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: 90,
                                height: 144,
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
                                                      sentId = task.id;
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
                                                      deleteMyTask(task.id);
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
        onPressed: () {
          clearControllers();
          _showMyDialog();
          // clearControllers();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showMyDialog([ToDoListModelClass? toDoModelObject]) {
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
                      showDateTimeModule();
                    },
                    readOnly: true,
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
                      print("------------In submit----------------");
                      if (_titleController.text.trim().isEmpty ||
                          _descriptionController.text.trim().isEmpty ||
                          _dateController.text.trim().isEmpty) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: const Color.fromARGB(
                              255,
                              254,
                              101,
                              101,
                            ),

                            content: Text(
                              "Fill the remaining fields first!",
                              style: GoogleFonts.quicksand(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      } else {
                        print("------------Adding the task----------------");
                        addTheCard(toDoModelObject);
                        Navigator.pop(context);
                      }
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
}
