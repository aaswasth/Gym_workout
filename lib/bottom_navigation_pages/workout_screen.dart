import 'package:capstone_project/on_tap_workout_pages/abs.dart';
import 'package:capstone_project/on_tap_workout_pages/flexibility.dart';
import 'package:capstone_project/on_tap_workout_pages/fullBody_functional.dart';
import 'package:capstone_project/on_tap_workout_pages/lowerBody.dart';
import 'package:capstone_project/on_tap_workout_pages/upperBody.dart';
import 'package:flutter/material.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Workout Categories',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
          children: <Widget>[
            _buildWorkoutItem(
              title: 'Upper Body',
              imageUrl:
                  'https://blog.squatwolf.com/wp-content/uploads/2018/09/shutterstock_657442150-min.jpg',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpperBodyPage(),
                  ),
                );
              },
            ),
            _buildWorkoutItem(
              title: 'Lower Body',
              imageUrl:
                  'https://previews.123rf.com/images/naiklon/naiklon2305/naiklon230506096/204484904-pumped-quads-during-a-leg-press.jpg',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => lowerBodyPage(),
                  ),
                );
              },
            ),
            _buildWorkoutItem(
              title: 'Abs',
              imageUrl:
                  'https://previews.123rf.com/images/staras/staras1708/staras170800138/84807359-man-doing-exercise-on-abdominal-bench-in-gym-perfect-muscular-male-body-black-and-white-background.jpg',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => absPage(),
                  ),
                );
              },
            ),
            // _buildWorkoutItem(
            //   title: 'Endurance',
            //   imageUrl:
            //       'https://images.unsplash.com/photo-1535743686920-55e4145369b9?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            //   onTap: () {
            //     // Navigate to the Endurance workout details
            //   },
            // ),
            // _buildWorkoutItem(
            //   title: 'Cardio',
            //   imageUrl:
            //       'https://images.unsplash.com/photo-1626252346582-c7721d805e0d?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            //   onTap: () {
            //     // Navigate to the Cardio workout details
            //   },
            // ),
            _buildWorkoutItem(
              title: 'Full-Body Functional Training',
              imageUrl:
                  'https://images.unsplash.com/photo-1688359147115-8e266c32c4ed?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => fullBodyPage(),
                  ),
                );
              },
            ),
            _buildWorkoutItem(
              title: 'Flexibility',
              imageUrl:
                  'https://images.unsplash.com/photo-1562771379-eafdca7a02f8?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => flexibilityPage(),
                  ),
                );
              },
            ),
            // _buildWorkoutItem(
            //   title: 'Polymetric Exercises',
            //   imageUrl:
            //       'https://www.sciencetraining.io/wp-content/uploads/2022/02/1200-628-1.png',
            //   onTap: () {
            //     // Navigate to the Polymetric Exercises details
            //   },
            // ),
            // Add more categories here...
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutItem({
    required String title,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
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

// final List<Exercise> upperBodyExercises = [
  // Exercise(
  //   name: 'Barbell Bencsh Presses',
  //   imageUrl: 'https://via.placeholder.com/300',
  //   description: 'Description for Barbell Bench Presses',
  //   subExercises: [
  //     Exercise(
  //       name: 'Incline Bench Press',
  //       imageUrl: 'https://via.placeholder.com/300',
  //       description: 'Description for Incline Bench Press',
  //     ),
  //     // Add more sub-exercises here...
  //   ],
  // ),
  // Exercise(
  //   name: 'Pull-sadsa s',
  //   imageUrl: 'https://via.placeholder.com/300',
  //   // description: 'Description for Pull-Ups',
  // ),
  // Add more exercises here...
// ];
