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
  State<ToDoList> createState() => _ToDoList();
}

class _ToDoList extends State<ToDoList> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List<_ToDoList> toDoListObjects = [];
  List<ToDoModelClass> addList = [];
  bool doEdit = false;

  List<Color> containerColors = [
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromRGBO(250, 249, 232, 1),
    const Color.fromRGBO(250, 232, 250, 1),
  ];

  void deletNote(ToDoModelClass toDoModelObject) {
    setState(() {
      addList.remove(toDoModelObject);
    });
  }

  void editNote(ToDoModelClass toDoModelObject) {
    print("Edit mdhi");
    titleController.text = toDoModelObject.title!.trim();
    descriptionController.text = toDoModelObject.description!.trim();
    dateController.text = toDoModelObject.date!.trim();

    setState(() {
      doEdit = true;
    });
    insertData(doEdit, toDoModelObject);
  }

  void addTheCard(ToDoModelClass? toDoModelObject) {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      print("Value of doEdit = $doEdit");
      if (doEdit == false) {
        print("nvin mdhi");
        setState(() {
          addList.add(
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
    clearingTheController();
    setState(() {
      doEdit = false;
    });
  }

  void clearingTheController() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  Future<void> pickDate() async {
    print("In pickDate");
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2028),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat("dd/MM/yyyy").format(pickedDate);
      setState(() {
        dateController.text = formattedDate;
      });
    }
  }

  void insertData(bool whichTask, [ToDoModelClass? toDoModelObject]) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            width: 360,
            height: 363,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Create Task",
                  style: GoogleFonts.quicksand(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 330,
                  height: 13,
                  // color: Colors.red,
                  child: Text(
                    "Title",
                    style: GoogleFonts.quicksand(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(0, 139, 148, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 330,
                  height: 40,
                  child: TextField(
                    controller: titleController,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 139, 148, 1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                    cursorHeight: 20,
                  ),
                ),
                //////////////////////////////////////////////////////////
                const SizedBox(height: 10),
                //////////////////////////////////////////////////////
                SizedBox(
                  width: 330,
                  height: 13,
                  // color: Colors.red,
                  child: Text(
                    "Description",
                    style: GoogleFonts.quicksand(
                      fontSize: 12,
                      color: const Color.fromRGBO(0, 139, 148, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 330,
                  height: 72,
                  child: TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 15.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 139, 148, 1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                    cursorHeight: 20,
                  ),
                ),
                //////////////////////////////////////////////////////////////////
                const SizedBox(height: 5),
                SizedBox(
                  width: 330,
                  height: 13,
                  // color: Colors.red,
                  child: Text(
                    "Date",
                    style: GoogleFonts.quicksand(
                      fontSize: 12,
                      color: const Color.fromRGBO(0, 139, 148, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 330,
                  height: 40,
                  child: TextField(
                    readOnly: true,
                    controller: dateController,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month_outlined, size: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 139, 148, 1),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                    cursorHeight: 20,
                    onTap: pickDate,
                  ),
                ),
                ///////////////////
                const SizedBox(height: 20),
                /////////////////////////////////////////////////
                GestureDetector(
                  onTap: () {
                    addTheCard(toDoModelObject);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 300,
                    height: 50,
                    color: const Color.fromRGBO(0, 139, 148, 1),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
        title: Text(
          "To-do list",
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w700,
            fontSize: 26,
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: addList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(height: 30),
              Container(
                width: 330,
                height: 112,
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 5,
                  right: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: containerColors[index % containerColors.length],
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 20,
                      spreadRadius: 1,
                      offset: Offset(0, 20),
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    children: [
                      ///////////////////////////////// C 1 //////////////////////////////
                      Column(
                        children: [
                          SizedBox(
                            width: 65,
                            height: 92,
                            // color: Colors.black,
                            child: Column(
                              children: [
                                Container(
                                  height: 52,
                                  width: 52,
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.07),
                                        blurRadius: 10,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Image.asset("Images/Image.png"),
                                ),
                                Container(
                                  height: 13,
                                  width: 80,
                                  // color: Colors.red,
                                  margin: const EdgeInsets.only(top: 14),
                                  child: Center(
                                    child: Text(
                                      addList[index].date.toString(),
                                      style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 9,
                                        color: const Color.fromRGBO(
                                          132,
                                          132,
                                          132,
                                          1,
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
                      ///////////////////////////////////// C 2 /////////////////////////////////
                      Column(
                        children: [
                          SizedBox(
                            width: 253,
                            height: 92,
                            // color: Colors.red,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 243,
                                  height: 25,
                                  // color: Colors.blueAccent,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    addList[index].title.toString(),
                                    style: GoogleFonts.quicksand(
                                      fontSize: 12,
                                      color: Colors.black,

                                      // fontWeight: FontWeight.w600)
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 243,
                                  height: 45,
                                  // color: Colors.limeAccent,
                                  child: Text(
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    addList[index].description.toString(),
                                    style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromRGBO(
                                        84,
                                        84,
                                        84,
                                        1,
                                      ),
                                      fontSize: 9,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 200,
                                      height: 22,
                                      // color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 22,
                                      // color: Colors.black,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                editNote(addList[index]),
                                            child: const Icon(
                                              Icons.edit_outlined,
                                              size: 17,
                                              fill: null,
                                              color: Color.fromRGBO(
                                                0,
                                                139,
                                                148,
                                                1,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 13,
                                            // color: Colors.orange,
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                deletNote(addList[index]),
                                            child: const Icon(
                                              Icons.delete_outline_rounded,
                                              size: 17,
                                              fill: null,
                                              color: Color.fromRGBO(
                                                0,
                                                139,
                                                148,
                                                1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      ////////////////////////// Bottom sheet ////////////////////////////////
      floatingActionButton: FloatingActionButton(
        // clipBehavior: Clip.hardEdge,
        shape: const CircleBorder(eccentricity: 0.7),
        backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
        onPressed: () {
          insertData(false);
        },
        child: const Icon(Icons.add, size: 50, color: Colors.white),
      ),
    );
  }
}

class ToDoModelClass {
  String? title;
  String? description;
  String? date;

  ToDoModelClass({
    required this.title,
    required this.description,
    required this.date,
  });
}
