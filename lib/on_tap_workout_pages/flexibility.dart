import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Transparent status bar
  ));
}

class Exercise {
  final String name;
  final String assetImage;
  final String description;
  final List<Exercise>? subExercises;

  Exercise({
    required this.name,
    required this.assetImage,
    required this.description,
    this.subExercises,
  });
}

class flexibilityPage extends StatelessWidget {
  final List<Exercise> chestExercises = [
    Exercise(
      name: 'Neck',
      assetImage: '',
      description: 'Description for Neck',
      subExercises: [
        Exercise(
          name: 'Benders',
          assetImage: 'assets/incline_barbell.jpg',
          description:
              'Tilt head to the side toward one shoulder.\n\n Hold for 20-30 seconds.\n Repeat one or more times with each side.',
        ),
        Exercise(
          name: 'Rotators',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Turn head slowly to look over one shoulder.\n\n Hold for 20-30 seconds.\n Repeat one or more times with each side.',
        ),
      ],
    ),
    Exercise(
      name: 'Arms',
      assetImage:
          'https://cdn.muscleandstrength.com/sites/default/files/best_back_exercises_-_1200x630.jpg',
      description: 'Description for Chest Press',
      subExercises: [
        Exercise(
          name: 'Biceps',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'With arms straight and fingers interlaced  behind back, raise hands toward ceiling.\n\n Hold for 20-30 seconds.\n Repeat one or more times.',
        ),
        Exercise(
          name: 'Triceps',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Bend elbow and place hand of bent arm on back of neck. Using the other hand, pull elbow behind head.\n\n Hold for 20-30 seconds.\n Repeat one or more times with each side.',
        ),
        Exercise(
          name: 'Wrist Flexors',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Stretch arm out in front with elbow straight and palm facing away. With other hand, pull fingers backward.\n\n Repeat with other arm. Hold for 20-30 seconds.\n Repeat one or more times.',
        ),
      ],
    ),
    Exercise(
      name: 'Shoulders and chest',
      assetImage:
          'https://www.sportsinjuryclinic.net/wp-content/uploads/2018/08/shoulder-pain800.jpg',
      description: 'Description for Chest Press',
      subExercises: [
        Exercise(
          name: 'Deltoid',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Pull right arm across chest with left hand. Turn head away from pull. Repeat with other arm.\n\n Hold for 20-30 seconds.\n Repeat one or more times',
        ),
        Exercise(
          name: 'Rhomboids',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Pull right arm across chest with left hand. Turn head away from pull. Repeat with other arm.\n\n Hold for 20-30 seconds.\n Repeat one or more times',
        ),
        Exercise(
          name: 'Pecs',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Grab both sides of doorway one inch below shoulder height.  Lean forward until stretch is felt in chest.  Keep back straight and feet shoulder width apart.\n\n Hold for 20-30 seconds.\n Repeat one or more times.',
        ),
      ],
    ),
    Exercise(
      name: 'Legs',
      assetImage:
          'https://www.sportsinjuryclinic.net/wp-content/uploads/2018/08/shoulder-pain800.jpg',
      description: 'Description for Chest Press',
      subExercises: [
        Exercise(
          name: 'Quadriceps',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Lie on side with knees bent and hold top foot with same-side hand.   Pull heel in toward buttock, keeping knees in line and hip pressed forward.\n\n Hold for 20-30 seconds.\n Repeat one or more times with each leg.',
        ),
        Exercise(
          name: 'Lumbar Extensions',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'With head raised up and lower back slightly arched, tuck chin to chest and round back toward ceiling. Return to starting position.\n\n Hold the arched and round back positions briefly.\n Repeat one or more times.',
        ),
        Exercise(
          name: 'Hamstrings',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'With head raised up and lower back slightly arched, tuck chin to chest and round back toward ceiling. Return to starting position. Hold the arched and round back positions briefly.\n\n Repeat one or more times.',
        ),
        Exercise(
          name: 'Adductors/Groin',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'With legs apart, knees straight and back straight slide hands forward.\n\n Hold for 20-30 seconds.\n Repeat one or more times.',
        ),
        Exercise(
          name: 'Internal Rotators',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Lie on back and gently pull right foot and knee toward right shoulder. Repeat with other leg.\n\n Hold for 20-30 seconds.\n Repeat one or more times.',
        ),
      ],
    ),
    // Add more chest exercises here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Lower Body Exercises',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: chestExercises.length,
        itemBuilder: (context, index) {
          final exercise = chestExercises[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                ExpansionTile(
                  backgroundColor: Colors.black,
                  tilePadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  title: Text(
                    exercise.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.redAccent),
                  ),
                  children: exercise.subExercises
                          ?.map((subExercise) => ListTile(
                                title: Text(
                                  subExercise.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: const Text("Click for Description",
                                    style: TextStyle(color: Colors.white70)),
                                onTap: () =>
                                    _showExerciseDetails(context, subExercise),
                              ))
                          .toList() ??
                      [],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showExerciseDetails(BuildContext context, Exercise exercise) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.dark().copyWith(
            dialogBackgroundColor: Colors.grey[900],
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: Colors.redAccent),
            ),
          ),
          child: AlertDialog(
            title: Text(exercise.name,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  // Image.asset(exercise.assetImage, // Display the asset image
                  //     width: 100, // Set the width as needed
                  //     height: 100, // Set the height as needed
                  //     fit: BoxFit.contain),
                  SizedBox(height: 10),
                  Text(exercise.description,
                      style: TextStyle(fontSize: 16, color: Colors.white70)),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Close',
                    style: TextStyle(fontSize: 16, color: Colors.redAccent)),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Workout Categories'),
          backgroundColor: Colors.deepPurple,
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
                title: 'Chest',
                imageUrl: 'https://via.placeholder.com/300',
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => flexibilityPage())),
              ),
              // Add more workout items here...
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutItem(
      {required String title,
      required String imageUrl,
      required VoidCallback onTap}) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.network(imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.deepPurple.withOpacity(0.7)
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    title,
                    style: TextStyle(
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
