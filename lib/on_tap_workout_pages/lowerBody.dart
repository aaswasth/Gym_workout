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

class lowerBodyPage extends StatelessWidget {
  final List<Exercise> chestExercises = [
    Exercise(
      name: 'Quads',
      assetImage: '',
      description: 'Description for Quads',
      subExercises: [
        Exercise(
          name: 'Squats',
          assetImage: 'assets/incline_barbell.jpg',
          description:
              '1.  Step on the rack so that the Barbell rests across the back of your shoulders. {Raise the barbell and get away from the rack if you are doing with free weights}.\n2. Bend your knees and lower yourself with your back straight and head up until your thighs are parallel to the ground. You can also go a little below the parallel if there is no reason not to go deep. .\n3. Now raise yourself up using only the thigh power keeping your back straight to a position with legs nearly locked out.',
        ),
        Exercise(
          name: 'Leg Extensions',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Sit on a Leg Extensions Machine with your legs under the padded bar and hold the side bars with your hands for support.\n2. Extend as far as possible until your legs are locked out to get a maximum thigh contraction.\n3. Get back to the start position and repeat. ',
        ),
        Exercise(
          name: 'Barbell Lunges',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Holding a barbell behind the neck stand upright.\n2. Keeping your back straight take a step forward bending your knees and getting them as close to the floor as possible.\n3. Push yourself back to the starting position and repeat with the other foot. ',
        ),
        Exercise(
          name: 'Dumbell Squats ',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Grab hold of a pair of heavy dumbbells and stand upright with feet shoulder feet apart.\n2. Bend your knees and lower yourself with your back straight and head up until your thighs are parallel to the ground.\n3. Now raise yourself up using only the thigh power keeping your back straight to a position with legs nearly locked out. ',
        ),
        Exercise(
          name: 'Front Squat',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Sit on a Leg Extensions Machine with your legs under the padded bar and hold the side bars with your hands for support.\n2. Extend as far as possible until your legs are locked out to get a maximum thigh contraction.\n3. Get back to the start position and repeat.',
        ),
      ],
    ),
    Exercise(
      name: 'Hamstrings',
      assetImage:
          'https://cdn.muscleandstrength.com/sites/default/files/best_back_exercises_-_1200x630.jpg',
      description: 'Description for Chest Press',
      subExercises: [
        Exercise(
          name: 'Leg Curls',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Lie face down on a lying leg curl machine and extend your legs straight. Position your legs under the support pads.\n2. Curl your legs as far as possible until they are fully contracted {heals up towards your buttocks }. Hold the handles or bench to prevent yourself from lifting off the bench. Keep the movement smooth.\n3. Lower the weight to the starting position. ',
        ),
        Exercise(
          name: 'Leg Press',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Position yourself under the machine {Vertical Type} and sit upright {Seated type} and place the feet together placed against the crosspiece.\n2. Bend your knees and allow the weight to lower itself until your knees are near 90 degrees.\n3. Now extend your legs and press the weight back. ',
        ),
      ],
    ),
    Exercise(
      name: 'Calf',
      assetImage:
          'https://www.sportsinjuryclinic.net/wp-content/uploads/2018/08/shoulder-pain800.jpg',
      description: 'Description for Chest Press',
      subExercises: [
        Exercise(
          name: 'Donkey Calf Raises',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Stand on a board and bend forward holding a table for support. Ask a training partner to sit across your back.\n2. Lower your heels and get as low as possible and fully contract your calf muscles fully.\n3. Extend your calves and get back to starting position.  ',
        ),
        Exercise(
          name: 'Calf Raises',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Step on a Calf Raise Machine with your toes on a block and heals extended into space. Place the shoulders under the pads and hook the weight off the support.\n2. Lower your heals as far as possible towards the floor. Keep your knees slightly bent. \n3. Now raise yourself up using only the toes and come as far as possible.\n4. Go as heavy as possible. With time you can perform partial repetitions once you get tired on a set.  ',
        ),
        Exercise(
          name: 'One leg Calf Raise',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Step on a Calf Raise Machine with your toes on a block and heals extended into space. Place the shoulders under the pads and hook the weight off the support.\n2. Lower your heals as far as possible towards the floor. Keep your knees slightly bent. \n3. Now raise yourself up using only the toes and come as far as possible.\n4. Go as heavy as possible. With time you can perform partial repetitions once you get tired on a set.  ',
        ),
      ],
    ),
    Exercise(
      name: 'Quad & Glutes',
      assetImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjqQTRRif-pBF-DSX_Y5CKrhV5dJ2MRsjH0Q&usqp=CAU',
      description: 'Description for Chest Press',
      subExercises: [
        Exercise(
          name: 'Squats',
          assetImage: 'assets/incline_barbell.jpg',
          description:
              '1.  Step on the rack so that the Barbell rests across the back of your shoulders. {Raise the barbell and get away from the rack if you are doing with free weights}.\n2. Bend your knees and lower yourself with your back straight and head up until your thighs are parallel to the ground. You can also go a little below the parallel if there is no reason not to go deep. .\n3. Now raise yourself up using only the thigh power keeping your back straight to a position with legs nearly locked out.',
        ),
        Exercise(
          name: 'Barbell Lunges',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Holding a barbell behind the neck stand upright.\n2. Keeping your back straight take a step forward bending your knees and getting them as close to the floor as possible.\n3. Push yourself back to the starting position and repeat with the other foot. ',
        ),
        Exercise(
          name: 'Hack Squats',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Get on a Hack Squats machine and get your shoulders under the support. \n2. Bend your knees and go down as low as possible - thighs parallel to the floor.\n3. Get back to the start position and repeat. ',
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
                    MaterialPageRoute(builder: (context) => lowerBodyPage())),
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
