import 'package:bucket_list/services/notification_services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:bucket_list/data/categories.dart';
import 'package:bucket_list/models/category.dart';
import 'package:bucket_list/models/todolist.dart';
import 'package:bucket_list/widgets/button.dart';
import 'package:bucket_list/widgets/pin.dart';
import 'package:bucket_list/widgets/tiles.dart';

import '../services/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ToDoItem> toDoList = [];
  List<ToDoItem> toDoListPinned = [];

  final Services _s = Services();

  Future<void> _removeItem(String documentId) async {
    _s.deleteTodoItem(documentId);
    await readTasks();
    SnackBar snackBar = const SnackBar(
      content: Text("Task completed successfully"),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> readTasks() async {
    //readTasks() is a function that reads the tasks from the database and updates the list
    List<ToDoItem> temp = await _s.read() as List<ToDoItem>;
    List<ToDoItem> dupTasks = [];
    List<ToDoItem> dupPinedTasks = [];
    for (var element in temp) {
      if (element.isPinned) {
        dupPinedTasks.add(element);
      }
      dupTasks.add(element);
    }
    setState(() {
      //setState() is a function that updates the UI
      toDoList = dupTasks;
      toDoListPinned = dupPinedTasks;
    });
  }

  @override
  void initState() {
    //initState() is a function that is called when the widget is first created
    readTasks(); //Basic Constructor like operations are done here

    super.initState();
  }

  Future<dynamic> showDia() {
    String textTitle = '';
    TextEditingController dateinput = TextEditingController();
    TextEditingController timeinput = TextEditingController();
    var _selectedCategory = categories[Categories.Myself]!;
    int _selectedButtonIndex = 0;
    bool pin = false;
    void updatePin(bool contd) {
      pin = contd;
    }

    void _updateSelectedButtonIndex(int index) {
      setState(() {
        _selectedButtonIndex = index;
      });
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Text(
                'Task',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: 'RobotoMono'
                  ),
              ),
              const Spacer(),
              PinWidget(
                updatePin: updatePin,
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20)),
              height: 320,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Title',
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      textTitle = value;
                    },
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const Spacer(),
                  TextField(
                    controller: dateinput,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                      ),
                      hintText: "Enter Date",
                    ),
                    readOnly: true,
                    onTap: () async {
                      List<DateTime>? dateTimeList =
                          await showOmniDateTimeRangePicker(
                        context: context,
                        startInitialDate: DateTime.now(),
                        startFirstDate:
                            DateTime(1600).subtract(const Duration(days: 3652)),
                        startLastDate: DateTime.now().add(
                          const Duration(days: 3652),
                        ),
                        endInitialDate: DateTime.now(),
                        endFirstDate:
                            DateTime(1600).subtract(const Duration(days: 3652)),
                        endLastDate: DateTime.now().add(
                          const Duration(days: 3652),
                        ),
                        is24HourMode: false,
                        isShowSeconds: false,
                        minutesInterval: 1,
                        secondsInterval: 1,
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        constraints: const BoxConstraints(
                          maxWidth: 350,
                          maxHeight: 650,
                        ),
                        transitionBuilder: (context, anim1, anim2, child) {
                          return FadeTransition(
                            opacity: anim1.drive(
                              Tween(
                                begin: 0,
                                end: 1,
                              ),
                            ),
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 200),
                        barrierDismissible: true,

                      );
                      
                      if (dateTimeList != null) {
                        String formattedTime =
                            DateFormat('kk:mm').format(dateTimeList[0]);
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(dateTimeList[0]);
                        setState(() {
                          timeinput.text = formattedTime;
                          dateinput.text = formattedDate;
                        });
                      }
                    },
                  ),
                  const Spacer(),
                  TextField(
                    controller: timeinput,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      icon: const Icon(
                        Icons.access_time,
                        color: Colors.black,
                      ),
                      hintText: "Enter Time",
                    ),
                    readOnly: true,
                    onTap: () async {
                      List<DateTime>? dateTimeList =
                          await showOmniDateTimeRangePicker(
                        context: context,
                        startInitialDate: DateTime.now(),
                        startFirstDate:
                            DateTime(1600).subtract(const Duration(days: 3652)),
                        startLastDate: DateTime.now().add(
                          const Duration(days: 3652),
                        ),
                        endInitialDate: DateTime.now(),
                        endFirstDate:
                            DateTime(1600).subtract(const Duration(days: 3652)),
                        endLastDate: DateTime.now().add(
                          const Duration(days: 3652),
                        ),
                        is24HourMode: false,
                        isShowSeconds: false,
                        minutesInterval: 1,
                        secondsInterval: 1,
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        constraints: const BoxConstraints(
                          maxWidth: 350,
                          maxHeight: 650,
                        ),
                        transitionBuilder: (context, anim1, anim2, child) {
                          return FadeTransition(
                            opacity: anim1.drive(
                              Tween(
                                begin: 0,
                                end: 1,
                              ),
                            ),
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 200),
                        barrierDismissible: true,
                      );
                    
                      
                      if (dateTimeList != null) {
                        String formattedTime = DateFormat('kk:mm').format(dateTimeList[0]);
                        String formattedDate = DateFormat('yyyy-MM-dd').format(dateTimeList[0]);
                        setState(() {
                          timeinput.text = formattedTime;
                          dateinput.text = formattedDate;
                        });
                      }
                    },
                  ),
                  const Spacer(),
                  ColorChangingButton(
                    onButtonSelected: _updateSelectedButtonIndex,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel',
                  style: TextStyle(
                    color: Colors.black,
                  )),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () async {
                bool isPined = false;
                if (pin) {
                  isPined = true;
                }
        
                setState(() {
                  if (_selectedButtonIndex == 0) {
                    _selectedCategory = categories[Categories.Myself]!;
                  }
                  if (_selectedButtonIndex == 1) {
                    _selectedCategory = categories[Categories.Work]!;
                  }
                  if (_selectedButtonIndex == 2) {
                    _selectedCategory = categories[Categories.Other]!;
                  }
        
                  //toDoList.add(newItem);
                });
                ToDoItem newItem = ToDoItem(
                    title: textTitle,
                    category: _selectedCategory,
                    dateTime: DateTime.parse(dateinput.text),
                    id: textTitle + DateTime.parse(dateinput.text).toString(),
                    isPinned: isPined);
                _s.addTask(newItem);
                readTasks();
                Navigator.of(context).pop();

                //finding the difference between the current time and the input time
                DateTime now = DateTime.now();
                debugPrint('Now: $now');
                DateTime inputDateTime = DateTime.parse('${dateinput.text} ${timeinput.text}');
                debugPrint('Input: $inputDateTime');
                Duration difference = inputDateTime.difference(now);
                int seconds = difference.inSeconds;
                debugPrint('Seconds: $seconds');
                await NotificationService.showNotification(
                  title: textTitle,
                  body: 'You have a task to complete',
                  scheduled: true,
                  interval: seconds,
                );
        
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget showDialogBox() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0,25.0),
            child: Image.asset('assets/Denji.png'),
          ),
          Text(
            'Create your first task...',
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                
              ),
          
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              showDia();
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text(
              'Add Task',
              style:TextStyle(
                  color: Colors.white,

                ),
              
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            leading: SizedBox(
              height: 20,
              width: 20,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'assets/Only_bucket.png',
                ),
              ),
            ),
            title: Text(
              'My Bucket List',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            toDoList.isEmpty
                ? showDialogBox()
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Stack(
                      children: [
                        // This is the image

                        Positioned(
                          top:
                              114, // This positions the ListView 5 pixels from the top of the Stack
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: ListView.separated(
                            itemBuilder: (context, index) => tiles(
                              title: toDoList[index].title,
                              category: toDoList[index].category,
                              date: toDoList[index].dateTime,
                              onRemove: () => _removeItem(toDoList[index].id),
                            ),
                            separatorBuilder: ((context, index) =>
                                const SizedBox(
                                  height: 20,
                                )),
                            itemCount: toDoList.length,
                          ),
                        ),
                        Image.asset('assets/JJK_gang.png'),
                      ],
                    ),
                  ),
            toDoListPinned.isEmpty
                ? showDialogBox()
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Stack(
                      children: [
                        // This is the image
                        Positioned(
                          top:
                              114, // This positions the ListView 5 pixels from the top of the Stack
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: ListView.separated(
                            itemBuilder: (context, index) => tiles(
                              title: toDoListPinned[index].title,
                              category: toDoListPinned[index].category,
                              date: toDoListPinned[index].dateTime,
                              onRemove: () =>
                                  _removeItem(toDoListPinned[index].id),
                            ),
                            separatorBuilder: ((context, index) =>
                                const SizedBox(
                                  height: 20,
                                )),
                            itemCount: toDoListPinned.length,
                          ),
                        ),
                        Image.asset('assets/JJK_gang.png'),
                      ],
                    )),
          ],
        ),
        floatingActionButton: toDoList.isEmpty
            ? null
            : FloatingActionButton(
                onPressed: () {
                  showDia();
                },
                backgroundColor: Colors.black,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: TabBar(
            dividerHeight: 0,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "My Tasks",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono'
                      ),
                   
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Pinned Tasks",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono'
                      ),
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
