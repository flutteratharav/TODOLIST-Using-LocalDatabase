import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tododatabase/main.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State createState() => _ToDoListState();
}

class _ToDoListState extends State {
  bool isEdit = false;

  final GlobalKey<FormFieldState> _titlekey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _desKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _dateKey = GlobalKey<FormFieldState>();

  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  void showData() async {
    maplist = await getAllTask();
  }

  void editTask(bool isEdit, ToDoList1 toDoList1) {
    _titlecontroller.text = toDoList1.title;
    _desController.text = toDoList1.description;
    _dateController.text = toDoList1.date;

    showBottomSheet1(isEdit, toDoList1);
  }

  void submit(bool isEdit, [ToDoList1? toDoList1]) async {
    if (!isEdit) {
      await insertNewTask(ToDoList1(
          title: _titlecontroller.text,
          description: _desController.text,
          date: _dateController.text));
      setState(() {
        showData();
      });
    } else {
      setState(() {
        toDoList1!.title = _titlecontroller.text;
        toDoList1.description = _desController.text;
        toDoList1.date = _dateController.text;
      });
    }
    Navigator.of(context).pop();
    _titlecontroller.clear();
    _desController.clear();
    _dateController.clear();
  }

  void showBottomSheet1(bool isEdit, [ToDoList1? toDoList1]) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 10,
              right: 10,
              top: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Create To-Do",
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: const Color.fromRGBO(0, 0, 0, 1)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    TextFormField(
                      key: _titlekey,
                      controller: _titlecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Title";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                    ),
                    Text(
                      "Description",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    TextFormField(
                      key: _desKey,
                      controller: _desController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Description";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                    ),
                    Text(
                      "Date",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    TextFormField(
                      key: _dateKey,
                      controller: _dateController,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2025));

                        String formatedDate =
                            DateFormat.yMMMd().format(pickedDate!);
                        setState(() {
                          _dateController.text = formatedDate;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Date";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: 300,
                  height: 50,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: ElevatedButton(
                    onPressed: () {
                      bool titleFlag = _titlekey.currentState!.validate();
                      bool desFlag = _desKey.currentState!.validate();
                      bool dateFlag = _dateKey.currentState!.validate();
                      if (titleFlag && desFlag && dateFlag) {
                        if (!isEdit) {
                          submit(false);
                        } else {
                          submit(true, toDoList1);
                        }
                      }
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(89, 57, 241, 1))),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(111, 81, 255, 1),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 29),
              child: Text(
                "Good Morning",
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                    color: const Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 29),
              child: Text(
                "ATHARAV",
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: const Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(217, 217, 217, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "CREATE TASKS TO DO ",
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: const Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            )),
                        width: double.infinity,
                        child: ListView.separated(
                          itemCount: maplist.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                            width: double.infinity,
                          ),
                          itemBuilder: (context, index) => Slidable(
                            endActionPane: ActionPane(
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    deletetask(maplist[index].id!);
                                    maplist.removeAt(index);
                                    setState(() {});
                                  },
                                  backgroundColor: Colors.blue,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            startActionPane: ActionPane(
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    editTask(true, maplist[index]);
                                  },
                                  backgroundColor: Colors.blue,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                              ],
                            ),
                            child: Container(
                              width: 400,
                              height: 90,
                              decoration: const BoxDecoration(boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 20,
                                    spreadRadius: 0,
                                    color: Color.fromRGBO(0, 0, 0, 0.08)),
                              ], color: Color.fromRGBO(255, 255, 255, 1)),
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 12, bottom: 11),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 52,
                                    width: 52,
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(217, 217, 217, 1),
                                        shape: BoxShape.circle),
                                    child: const Icon(Icons.image_sharp),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        maplist[index].title,
                                        style: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1)),
                                      ),
                                      Text(
                                        maplist[index].description,
                                        style: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1)),
                                      ),
                                      Text(
                                        "${maplist[index].date}",
                                        style: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11,
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1)),
                                      ),
                                    ],
                                  )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(Icons.check_box_sharp)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showBottomSheet1(false);
          },
          backgroundColor: const Color.fromRGBO(89, 57, 241, 1),
          shape: const CircleBorder(eccentricity: 1),
          tooltip: "Click here for adding new task",
          child: const Icon(Icons.add)),
    );
  }
}
