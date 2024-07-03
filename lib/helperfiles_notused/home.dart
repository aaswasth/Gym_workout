import 'dart:ui';

import 'package:capstone_project/bottom_navigation_pages/workout_screen.dart';
import 'package:capstone_project/pages/water_widget.dart';
import 'package:capstone_project/sidebar/workout_tracker.dart';
import 'package:flutter/material.dart';

class HomePg extends StatefulWidget {
  const HomePg({Key? key}) : super(key: key);

  @override
  State<HomePg> createState() => _HomePgState();
}

class _HomePgState extends State<HomePg> {
  bool viewAllClicked = false;
  double _waterIntake = 0.0; // Current water intake in liters
  final double _maxWaterIntake = 4.0;

  late final WaterIntakeWidget _waterIntakeWidget;

  @override
  void initState() {
    super.initState();
    _waterIntakeWidget = WaterIntakeWidget();
  }

  List<Widget> initialTiles() {
    return [
      buildTile('Upper Body', Icons.accessibility, Colors.redAccent),
      buildTile('Lower Body', Icons.directions_walk, Colors.redAccent),
      buildTile('Abs', Icons.boy_rounded, Colors.redAccent),
      buildTile('Legs', Icons.nordic_walking_outlined, Colors.redAccent),
    ];
  }

  Widget buildTile(String title, IconData iconData, Color color) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final itemWidth = (screenWidth - 5 * 10) /
            4; // 5 is the total horizontal padding (left + right), 10 is the spacing between tiles
        return Container(
          height: 70,
          width: itemWidth,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData),
              Text(title),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tiles = initialTiles();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Category',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        viewAllClicked = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkoutScreen()),
                        );
                      });
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(color: Colors.white),
                    ),
                    // style: TextButton.styleFrom(
                    //   backgroundColor: Colors.blue,
                    // ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Wrap(
                spacing: 10,
                children: tiles,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding:
                  const EdgeInsets.all(5), // Add spacing between the containers
              child: Container(
                height: 130,
                width: double.infinity,
                // color: Colors.green,
                child: _waterIntakeWidget,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                  image: const DecorationImage(
                    image: AssetImage('assets/homebg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      //  blur effect to  boundaries of the container
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: 2.0, sigmaY: 2.0), // blur effect
                        child: Container(
                          color: Colors.white.withOpacity(0.0),
                          padding: EdgeInsets.all(20),
                          child: const Text(
                            "Start Body Training\nExercise",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                            // textAlign: TextAlign.center, // Remove this line
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 15,
                        left: 15,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WorkoutTracker()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text(
                              '    Begin a workout    ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            // child: Center(
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Famous Influencers',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 170,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                            image: const DecorationImage(
                              image: AssetImage('assets/cbum.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Text(
                            "Chris Bumstead",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w900),
                            // textAlign: TextAlign.center, // Remove this line
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          // margin: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                            image: const DecorationImage(
                              image: AssetImage('assets/saket.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Text(
                            "Saket Gokhale",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w900),
                            // textAlign: TextAlign.center, // Remove this line
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          // margin: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                            image: const DecorationImage(
                              image: AssetImage('assets/aryan.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Text(
                            "Aryan Awasthi",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w900),
                            // textAlign: TextAlign.center, // Remove this line
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void main() {
    runApp(MaterialApp(
      home: HomePg(),
    ));
  }
}
