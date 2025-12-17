import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoList(),
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
  bool? isVisible;

  ToDoModelClass({
    required this.title,
    required this.description,
    required this.date,
    this.isVisible = true,
  });
}

class _ToDoListState extends State<ToDoList> {
  //
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  //
  bool whichTask = false;

  //
  List<ToDoModelClass> toDoList = [];

  //
  List<Color> containerColors = [
    Color.fromRGBO(250, 232, 232, 1),
    Color.fromRGBO(232, 237, 250, 1),
    Color.fromRGBO(250, 226, 214, 1),
    Color.fromRGBO(250, 232, 250, 1),
  ];
  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  Future<void> pickTheDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color.fromARGB(255, 204, 222, 236),
              onPrimary: Colors.black,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 2, 188, 245),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formatDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      dateController.text = formatDate;
    }
  }

  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////

  void editCard(ToDoModelClass toDoModelObject) {
    titleController.text = toDoModelObject.title!;
    descriptionController.text = toDoModelObject.description!;
    dateController.text = toDoModelObject.date!;

    setState(() {
      whichTask = true;
      showMyModalBottomSheet(whichTask, toDoModelObject);
    });
  }

  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  void deleteCard(ToDoModelClass toDoModelObject) {
    setState(() {
      toDoModelObject.isVisible = false;
    });

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        toDoList.remove(toDoModelObject);
      });
    });
  }

  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  void addTheCard(ToDoModelClass? toDoModelObject) {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (whichTask == false) {
        setState(() {
          toDoList.add(
            ToDoModelClass(
              title: titleController.text,
              description: descriptionController.text,
              date: dateController.text,
              isVisible: true,
            ),
          );
        });
      } else {
        toDoModelObject!.title = titleController.text.trim();
        toDoModelObject.description = descriptionController.text.trim();
        toDoModelObject.date = dateController.text.trim();
      }
      setState(() {
        whichTask = false;
      });
      clearControllers();
    }
  }

  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////

  void showMyModalBottomSheet(
    bool whichTask, [
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
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            height: 340,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Create Task",
                      style: GoogleFonts.quicksand(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ////////////////////////////////////////////////
                      ////////////////////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5),
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
                            contentPadding: EdgeInsets.only(
                              bottom: 5,
                              left: 10,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 140, 197, 240),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ////////////////////////////////////////////////
                      ////////////////////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                        child: Text(
                          "Description",
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        child: TextField(
                          controller: descriptionController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              bottom: 5,
                              left: 10,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 140, 197, 240),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ////////////////////////////////////////////////
                      ////////////////////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 5),
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
                          controller: dateController,
                          onTap: () {
                            pickTheDate();
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                              bottom: 5,
                              left: 10,
                            ),
                            suffixIcon: Icon(Icons.calendar_month_outlined),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: const Color.fromARGB(255, 140, 197, 240),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ///////////////////////////////////////////////////
                      ///////////////////////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            addTheCard(toDoModelObject);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 140, 197, 240),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 204, 222, 236),
        centerTitle: true,
        title: Text(
          "To-Do List",
          style: GoogleFonts.quicksand(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              top: 20,
              left: 50,
              right: 50,
            ),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: toDoList[index].isVisible! ? 1.0 : 0,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: containerColors[index % containerColors.length],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    /////////////////////////////////////////
                    Column(
                      children: [
                        SizedBox(
                          width: 80,
                          height: 150,
                          // color: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.task_sharp,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Text(
                                  toDoList[index].date!,
                                  style: GoogleFonts.quicksand(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    /////////////////////////////////////////
                    /////////////////////////////////////////
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 5.0,
                        right: 10,
                        top: 15,
                      ),
                      child: SizedBox(
                        width: 210,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              toDoList[index].title!,
                              style: GoogleFonts.quicksand(fontSize: 18),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SizedBox(
                                height: 70,
                                child: Text(
                                  toDoList[index].description!,
                                  style: GoogleFonts.quicksand(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      editCard(toDoList[index]);
                                    },
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.edit_outlined,
                                        color: Colors.grey,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  GestureDetector(
                                    onTap: () {
                                      deleteCard(toDoList[index]);
                                    },
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.delete_outline_outlined,
                                        color: Colors.grey,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),
                            ),
                          ],
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
        onPressed: () {
          clearControllers();
          showMyModalBottomSheet(false);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

