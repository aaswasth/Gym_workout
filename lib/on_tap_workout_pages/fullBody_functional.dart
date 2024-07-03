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

class fullBodyPage extends StatelessWidget {
  final List<Exercise> chestExercises = [
    Exercise(
      name: 'Upper Body Functional Training',
      assetImage: '',
      description: 'Description for Quads',
      subExercises: [
        Exercise(
          name: 'Push-Ups (Variations)',
          assetImage: 'assets/incline_barbell.jpg',
          description:
              'Engages the chest, shoulders, triceps, and core. Start with traditional push-ups; for added challenge, try decline or diamond push-ups.',
        ),
        Exercise(
          name: 'Pull-Ups or Inverted Rows',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Strengthens the back, biceps, and grip. If pull-ups are too challenging, inverted rows are a great alternative that still targets these muscles effectively.',
        ),
        Exercise(
          name: 'Dumbbell Shoulder Press',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Works the shoulders and upper arms, with a focus also on stability through the core. Perform either standing or seated for added core engagement.',
        ),
        Exercise(
          name: 'Plank Up-Downs ',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Start in a plank position on your forearms and then push up to a high plank, one arm at a time. This works the arms, chest, and core while challenging stability.',
        ),
      ],
    ),
    Exercise(
      name: 'Lower Body Functional Training',
      assetImage:
          'https://cdn.muscleandstrength.com/sites/default/files/best_back_exercises_-_1200x630.jpg',
      description: 'Description for Chest Press',
      subExercises: [
        Exercise(
          name: 'Squats (Variations)',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Fundamental for building strength in the quads, hamstrings, glutes, and core. Try variations like goblet squats, single-leg squats, or jump squats for variety and added challenge. ',
        ),
        Exercise(
          name: 'Lunges (Variations)',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Target the glutes, quads, and hamstrings. Variations can include forward, reverse, lateral, or walking lunges.',
        ),
        Exercise(
          name: 'Deadlifts',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Essential for developing posterior chain strength, impacting the lower back, glutes, hamstrings, and core.',
        ),
        Exercise(
          name: 'Step-Ups',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Using a bench or a sturdy platform, step-ups engage the quads, hamstrings, and glutes while also improving balance and coordination.',
        ),
      ],
    ),
    Exercise(
      name: 'Full Body Functional Training',
      assetImage:
          'https://www.sportsinjuryclinic.net/wp-content/uploads/2018/08/shoulder-pain800.jpg',
      description: 'Description for Chest Press',
      subExercises: [
        Exercise(
          name: 'Burpees',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'A high-intensity exercise that combines a squat, push-up, and jump into one movement, engaging most of the body’s muscle groups.',
        ),
        Exercise(
          name: 'Kettlebell Swings',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'argets the posterior chain (glutes, hamstrings, lower back) and also engages the core, shoulders, and arms.',
        ),
        Exercise(
          name: 'Farmer’s Walk',
          assetImage: 'https://via.placeholder.com/300',
          description:
              'Simply carry heavy weights (dumbbells or kettlebells) in each hand and walk a specific distance. This engages the entire body, with a focus on grip strength, core stability, and overall endurance.',
        ),
        Exercise(
          name: 'Medicine Ball Slams',
          assetImage: 'https://via.placeholder.com/300',
          description:
              ' Great for developing power, coordination, and engaging the upper body, core, and legs.',
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
                    MaterialPageRoute(builder: (context) => fullBodyPage())),
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
