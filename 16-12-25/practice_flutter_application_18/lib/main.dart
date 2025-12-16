import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:intl/intl.dart";

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ToDoList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class ToDoModelClass {
  String? title;
  String? description;
  String? date;
  bool isVisible;

  ToDoModelClass({
    required this.title,
    required this.description,
    required this.date,
    this.isVisible = true,
  });
}

class _ToDoListState extends State<ToDoList> {
  bool isEditing = false;
  List<ToDoModelClass> toDoList = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List colorsList = [
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromARGB(255, 251, 249, 214),
    const Color.fromRGBO(250, 232, 250, 1),
  ];
  ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////
  void deleteNote(ToDoModelClass toDoModelObject) {
    setState(() {
      toDoModelObject.isVisible = false;
    });
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        toDoList.remove(toDoModelObject);
      });
    });
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////
  void editTheCard(ToDoModelClass toDoModelObject) {
    titleController.text = toDoModelObject.title!;
    descriptionController.text = toDoModelObject.description!;
    dateController.text = toDoModelObject.date!;

    setState(() {
      isEditing = true;
      showMyModalBottomSheet(isEditing, toDoModelObject);
    });
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////
  void addingTheCard(ToDoModelClass? toDoModelObject) {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (isEditing == false) {
        setState(() {
          toDoList.add(
            ToDoModelClass(
              title: titleController.text,
              description: descriptionController.text,
              date: dateController.text,
            ),
          );
        });
      } else {
        toDoModelObject!.title = titleController.text.trim();
        toDoModelObject.description = descriptionController.text.trim();
        toDoModelObject.date = dateController.text.trim();
      }
    }
    setState(() {
      isEditing = false;
    });
    clearController();
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////
  void clearController() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////
  Future<void> showDate() async {
    print("In showdate");
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String choosedDate = DateFormat("dd/MM/yyyy").format(pickedDate);
      dateController.text = choosedDate;
      print(choosedDate);
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////
  void showMyModalBottomSheet(
    bool isEditing, [
    ToDoModelClass? toDoModelObject,
  ]) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: 380,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: Text(
                      "Create Task",
                      style: GoogleFonts.quicksand(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                //////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0, top: 10),
                        child: Text(
                          "Title",
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 183, 214, 240),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //////////////////////////////////////////////////////////
                      //////////////////////////////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0, top: 10),
                        child: Text(
                          "Description",
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        child: TextField(
                          controller: descriptionController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 183, 214, 240),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //////////////////////////////////////////////////////////
                      //////////////////////////////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0, top: 10),
                        child: Text(
                          "Date",
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            showDate();
                          },
                          controller: dateController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.calendar_month_sharp),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 183, 214, 240),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                      //////////////////////////////////////////////////////////
                      //////////////////////////////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          children: [
                            Container(
                              height: 45,
                              width:
                                  (MediaQuery.of(context).size.width - 100) / 2,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 183, 214, 240),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "Clear",
                                  style: GoogleFonts.quicksand(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                addingTheCard(toDoModelObject);
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 45,
                                width:
                                    (MediaQuery.of(context).size.width - 100) /
                                    2,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    183,
                                    214,
                                    240,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "Submit",
                                    style: GoogleFonts.quicksand(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
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
        backgroundColor: const Color.fromARGB(255, 152, 203, 245),
        centerTitle: true,
        title: Text("To-Do List", style: GoogleFonts.quicksand(fontSize: 30)),
      ),
      ///////////////////////////////////////////////////////////////////////////////////////
      ///////////////////////////////////////////////////////////////////////////////////////
      ///////////////////////////////////////////////////////////////////////////////////////
      body: (toDoList.isEmpty)
          ? Center(
              child: Text(
                "Nothing yet! Add some tasks.",
                style: GoogleFonts.quicksand(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    left: 40,
                    right: 40,
                  ),
                  child: AnimatedOpacity(
                    opacity: toDoList[index].isVisible ? 1.0 : 0,
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(215, 214, 214, 1),
                            offset: Offset(0, 20),
                            spreadRadius: 3,
                            blurRadius: 20,
                          ),
                        ],
                        color: colorsList[index % colorsList.length],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(Icons.task, color: Colors.grey),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    toDoList[index].date!,
                                    style: GoogleFonts.quicksand(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    toDoList[index].title!,
                                    style: GoogleFonts.quicksand(fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  height: 63,
                                  width:
                                      MediaQuery.of(context).size.width - 180,
                                  // color: Colors.pink,
                                  child: Text(
                                    toDoList[index].description!,
                                    style: GoogleFonts.quicksand(fontSize: 12),
                                    maxLines: 3,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 180,
                                  // color: Colors.red,
                                  child: Row(
                                    children: [
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          editTheCard(toDoList[index]);
                                        },
                                        child: Icon(
                                          Icons.edit_outlined,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      GestureDetector(
                                        onTap: () {
                                          deleteNote(toDoList[index]);
                                        },
                                        child: Icon(
                                          Icons.delete_forever,
                                          size: 20,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
        onPressed: () {
          clearController();
          showMyModalBottomSheet(false);
        },
        backgroundColor: const Color.fromARGB(255, 183, 214, 240),
        child: Icon(Icons.add_box_outlined),
      ),
    );
  }
}
