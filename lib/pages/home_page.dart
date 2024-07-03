import 'package:capstone_project/bottom_navigation_pages/profile_screen.dart';
import 'package:capstone_project/bottom_navigation_pages/temp_list.dart';
import 'package:capstone_project/helperfiles_notused/home.dart';
import 'package:capstone_project/pages/water_widget.dart';
import 'package:capstone_project/sidebar/RPE_calculator.dart';
import 'package:capstone_project/sidebar/body_mass_calc.dart';
import 'package:capstone_project/sidebar/quotes.dart';
import 'package:capstone_project/sidebar/social_media.dart';
import 'package:capstone_project/sidebar/workout_tracker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  double _waterIntake = 0.0; // Current water intake in liters
  final double _maxWaterIntake = 3.5; // Maximum water intake in liters

  final currentUser = FirebaseAuth.instance.currentUser;
  final textController = TextEditingController();

  late final QuoteWidget _quoteWidget;
  late final WaterIntakeWidget _waterIntakeWidget;

  @override
  void initState() {
    super.initState();
    _quoteWidget = const QuoteWidget();
    _waterIntakeWidget = WaterIntakeWidget();
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ACHIEVABLE',
          style: TextStyle(color: Colors.white60, fontSize: 35),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white60),
      ),
      drawer: _buildDrawer(context),
      body: _buildBodyContent(),
      backgroundColor: Colors.black,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    final double drawerWidth = MediaQuery.of(context).size.width;
    return Drawer(
      child: Container(
        color: Colors.black.withOpacity(0.7), // Semi-transparent background
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: drawerWidth,
              height: 190,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quote of the day',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    // SizedBox(height: 8),
                    _quoteWidget,
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.mark_chat_unread_rounded,
                  color: Colors.white),
              title:
                  const Text('Baatein', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.monitor_weight, color: Colors.white),
              title: const Text('BMI', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BmiCalc()),
                );
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.map, color: Colors.white),
            //   title: const Text('Maps', style: TextStyle(color: Colors.white)),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => MapScreen()),
            //     );
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.fitness_center, color: Colors.white),
              title: const Text('RPE Calculator',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CalculatorRPE()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.redAccent,
                      title: const Text(
                        'Confirm Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: const Text(
                        'Are you sure you want to log out?',
                        style: TextStyle(color: Colors.white),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text(
                            'Confirm',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            signOut();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            // Add more ListTile
          ],
        ),
      ),
    );
  }

  Widget _buildBodyContent() {
    // Depending on the _currentIndex, show the appropriate screen/widget
    switch (_currentIndex) {
      case 0:
        return const HomePg();
//         return SingleChildScrollView(
//           child: Column(
//             children: [
//               _quoteWidget, // Use the existing instance of QuoteWidget
//               _waterIntakeWidget, // Use the existing instance of WaterIntakeWidget
//               SizedBox(
//                 height: 200, // Set a fixed height for the container
//                 child: Center(
//                   child: _buildLatestWorkoutWidget(), // Display latest workout
//                 ),
//               ),
//               _buildCalendarWidget(),
// // You can keep the green container or replace it with another widget
//             ],
//           ),
      // );
      // case 1:
      // return const WorkoutScreen();
      case 1:
        return const WorkoutTracker();
      case 2:
        return const TemplateList();
      case 3:
        return const ProfilePage();
      // // case 5:
      //   return const HomePg();
      // Define other cases for other indices
      default:
        return const Center(
          child: Text(
            'Page not found',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        );
    }
  }

  Widget _buildBottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.black,
        primaryColor: Colors.white,
        textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(color: Colors.white.withOpacity(0.5)),
            ),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sticky_note_2),
            label: 'Exercise Tab',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Future<String> fetchLatestWorkoutName() async {
    // Fetch the latest workout document from the 'workouts' collection
    var workoutSnapshot = await FirebaseFirestore.instance
        .collection('workouts')
        .orderBy('timestamp',
            descending: true) // Assuming you have a 'timestamp' field
        .limit(1)
        .get();

    if (workoutSnapshot.docs.isNotEmpty) {
      return workoutSnapshot.docs.first.get('name');
    }
    return 'No workouts available';
  }

  // Widget _buildLatestWorkoutWidget() {
  //   return FutureBuilder<String>(
  //     future: fetchLatestWorkoutName(),
  //     builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
  //       Widget content;
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         content = const CircularProgressIndicator(
  //           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  //         );
  //       } else if (snapshot.hasError) {
  //         content = const Text(
  //           'Error fetching latest workout',
  //           style: TextStyle(
  //             color: Colors.redAccent,
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         );
  //       } else {
  //         content = Text(
  //           'Latest Workout:\n${snapshot.data}',
  //           textAlign: TextAlign.center,
  //           style: const TextStyle(
  //             fontSize: 32, // Larger font size
  //             color: Colors.white,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         );
  //       }

  //       return Container(
  //         margin: const EdgeInsets.symmetric(vertical: 8.0),
  //         padding: const EdgeInsets.symmetric(vertical: 21.0),
  //         decoration: BoxDecoration(
  //           gradient: const LinearGradient(
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //             colors: [
  //               Color.fromARGB(255, 41, 44, 49),
  //               Color.fromARGB(255, 59, 60, 61)
  //             ],
  //           ),
  //           borderRadius: BorderRadius.circular(8),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.black.withOpacity(0.2),
  //               spreadRadius: 5,
  //               blurRadius: 5,
  //               offset: const Offset(0, 3),
  //             ),
  //           ],
  //         ),
  //         child: Center(child: content),
  //       );
  //     },
  //   );
  // }

  // Widget _buildCalendarWidget() {
  //   return TableCalendar(
  //     focusedDay: DateTime.now(),
  //     firstDay: DateTime(2020),
  //     lastDay: DateTime(2030),
  //     calendarFormat: CalendarFormat.month,
  //     availableCalendarFormats: const {
  //       CalendarFormat.month: 'Month',
  //     },
  //     // Custom styles
  //     calendarStyle: const CalendarStyle(
  //       todayDecoration: BoxDecoration(
  //         color: Colors.blueAccent,
  //         shape: BoxShape.circle,
  //       ),
  //       // selectedDecoration: BoxDecoration(
  //       //   color: Colors.green,
  //       //   shape: BoxShape.circle,
  //       // ),
  //       weekendTextStyle: TextStyle(color: Colors.red),
  //       outsideTextStyle: TextStyle(color: Colors.white),
  //       defaultTextStyle: TextStyle(color: Colors.white),
  //     ),
  //     headerStyle: HeaderStyle(
  //       titleTextStyle: const TextStyle(
  //         fontSize: 20,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.white,
  //       ),
  //       formatButtonDecoration: BoxDecoration(
  //         color: Colors.blueAccent,
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
  //       rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white),
  //     ),
  //     daysOfWeekStyle: const DaysOfWeekStyle(
  //       weekdayStyle: TextStyle(color: Colors.white),
  //       weekendStyle: TextStyle(color: Colors.red),
  //     ),
  //     calendarBuilders: CalendarBuilders(
  //       // Hide the days of previous and next months
  //       outsideBuilder: (context, date, events) {
  //         return SizedBox.shrink(); // Return an empty sized box
  //       },
  //     ),
  //     // You can further customize the calendar as needed
  //   );
  // }
}
