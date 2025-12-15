

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ToDoList());
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool whichTask = false;
  List toDoList = [];
  List<Color> containerColors = [
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromARGB(255, 251, 249, 214),
    const Color.fromRGBO(250, 232, 250, 1),
  ];

  // List toDoList = ["1", "2", "3", "4", "5"];

  Future pickTheDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat("dd/MM/yyyy").format(pickedDate);
      dateController.text = formattedDate;
    }
  }

  void deleteNote(ToDoModelClass toDoModelObject) {
    setState(() {
      toDoList.remove(toDoModelObject);
    });
  }

  void editNote(ToDoModelClass toDoModelObject) {
    titleController.text = toDoModelObject.title!.trim();
    descriptionController.text = toDoModelObject.description!.trim();
    dateController.text = toDoModelObject.date.trim();
    setState(() {
      whichTask = true;
    });
    insertData(whichTask, toDoModelObject);
  }

  void addTheCard(ToDoModelClass? toDoModelObject) {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (whichTask == false) {
        setState(() {
          toDoList.add(
            ToDoModelClass(
              title: titleController.text.trim(),
              description: descriptionController.text.trim(),
              date: dateController.text.trim(),
            ),
          );
        });
      } else {
        setState(() {
          toDoModelObject?.title = titleController.text.trim();
          toDoModelObject?.description = descriptionController.text.trim();
          toDoModelObject?.date = dateController.text.trim();
        });
      }
    }

    setState(() {
      whichTask = false;
    });
    clearControllers();
  }

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  void insertData(bool whichTask, [ToDoModelClass? toDoModelObject]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width - 50,
          height: 380,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      const Spacer(),
                      Text(
                        "Create Task",
                        style: GoogleFonts.quicksand(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                ///////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Title",
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: titleController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5, left: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 179, 219, 252),
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ///////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Description",
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: SizedBox(
                    height: 70,
                    child: TextField(
                      controller: descriptionController,
                      maxLines: null,
                      expands: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 179, 219, 252),
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ///////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Text(
                    "Date",
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: dateController,
                      onTap: () => pickTheDate(),
                      readOnly: true,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_month_outlined),
                        contentPadding: EdgeInsets.only(bottom: 5, left: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color.fromARGB(255, 179, 219, 252),
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ///////////////////////////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      addTheCard(toDoModelObject);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 179, 219, 252),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 179, 219, 252),
        title: Text("To-Do List", style: GoogleFonts.quicksand(fontSize: 20)),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  height: 130,
                  decoration: BoxDecoration(
                    color: containerColors[index % containerColors.length],
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all(width: 0.2),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 0.1),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: Image.asset("Images/Image.png"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  toDoList[index].date.toString(),
                                  style: GoogleFonts.quicksand(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                toDoList[index].title.toString(),
                                style: GoogleFonts.quicksand(fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: 220,
                                height: 60,
                                child: Text(
                                  toDoList[index].description.toString(),
                                  style: GoogleFonts.quicksand(fontSize: 12),
                                ),
                              ),
                              Row(
                                children: [
                                  // const Spacer(),
                                  const SizedBox(width: 170),
                                  //////////////////////////////////////////////////////////////
                                  //////////////////////////////////////////////////////////////
                                  GestureDetector(
                                    onTap: () {
                                      editNote(toDoList[index]);
                                    },
                                    child: Icon(
                                      Icons.edit_outlined,
                                      size: 20,
                                      color: const Color.fromARGB(
                                        255,
                                        119,
                                        118,
                                        118,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 10),
                                  //////////////////////////////////////////////////////////////
                                  //////////////////////////////////////////////////////////////
                                  GestureDetector(
                                    onTap: () {
                                      deleteNote(toDoList[index]);
                                    },
                                    child: Icon(
                                      Icons.delete_outline_outlined,
                                      size: 20,
                                      color: const Color.fromARGB(
                                        255,
                                        119,
                                        118,
                                        118,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // const SizedBox(height: 40),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          clearControllers();
          insertData(false);
        },
        backgroundColor: const Color.fromARGB(255, 179, 219, 252),
        child: Icon(Icons.add, size: 35),
      ),
    );
  }
}

class ToDoModelClass {
  String? title;
  String? description;
  String date;

  ToDoModelClass({
    required this.title,
    required this.description,
    required this.date,
  });
}
