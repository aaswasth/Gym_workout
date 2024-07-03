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

class UpperBodyPage extends StatelessWidget {
  final List<Exercise> chestExercises = [
    Exercise(
      name: 'Chest',
      assetImage: '',
      description: 'Description for Chest Press',
      subExercises: [
        Exercise(
          name: 'Barbell Incline Presses',
          assetImage: 'assets/incline_barbell.jpg',
          description:
              '1. Set the incline bench at about a 45 degree angle.\n2. Sit on the bench with your feet flat on the floor a little more than shoulder width apart.\n3. Position your back firmly against the bench.\n4. Using a grip slightly wider than shoulder width, hold the bar over your upper chest with your arms straight.\n5. Slowly lower the bar and make slight contact with your upper chest area.\n6. Drive the weight straight up over your chest until your elbows are locked, or close to it.',
        ),
        Exercise(
          name: 'Barbell Bench Presses',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Lie on a flat bench and firmly position your feet flat on the floor a little more than shoulder width apart.\n2. Keep your back flat on the bench! Using a grip broader than shoulder width, hold the barbell above your body, then lower slowly to the middle of your chest.\n 3.Without bouncing the weight off your chest, drive the barbell up over the middle of your chest until your arms are straight and your elbows are locked.\n 4. Lower the bar down slowly.',
        ),
        Exercise(
          name: 'Flat Dubmbell Flyes',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Sit down on a flat bench with a dumbbell in each hand.\n2. Then lie back, keeping the dumbbells close to your chest.\n3. Lift the dumbbells over your chest by extending your arms.\n4. Maintain a slight bend in your elbows.\n5. Keep your hips and shoulders flat on the bench and your feet on the floor.\n6. Lower the dumbbells to the sides of your body in an arc-like motion.\n7. At the lowest point, your bent elbows should be on a horizontal plane even with the bench.\n8. Slowly bring the weights back up over your chest in an arc. The bend in your elbows should stay the same throughout the exercise.',
        ),
        Exercise(
          name: 'Incline Cable Fly',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. This is like the flat bench flye, except you are lying on a low incline bench (about 30 degrees).\n2. Hold the handles above the top portion of your chest with your arms almost straight.\n3. You should keep a slight bend in them.\n4. Slowly lower the handles in a wide arc to shoulder level and then return to the starting position along the exact same path.\n5. Keep tension on your pecs throughout the movement and squeeze hard at the top',
        ),
        // Exercise(
        //   name: 'Cable Crossovers',
        //   assetImage: 'https://via.placeholder.com/300',
        //   description: 'Click for description ',
        // ),
      ],
    ),
    Exercise(
      name: 'Back',
      assetImage:
          'https://cdn.muscleandstrength.com/sites/default/files/best_back_exercises_-_1200x630.jpg',
      description: 'Description for Chest Press',
      subExercises: [
        Exercise(
          name: 'Lat Pull down',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Hold the Lat pull-down machine bar with an overhand grip, hands slightly wider than shoulder width apart and sit on the machine seat. Lock your knees under the support. At this point your arms are fully extended, stretching your back muscles.\n2. Now keeping your upper back straight pull the bar down bringing it up to the chest. As you pull down squeeze your shoulder blades together and feel back muscles contracting.\n3. Perform this movement using your upper lats and use the arms merely as a lever between bar and lats.\n4. Now release the bar with controlled motion and stretch your lats as much as possible. ',
        ),
        Exercise(
          name: 'Upright Rows',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Hold a bar with a narrow overhand grip and let it hang in front of you.\n2. Lift the bar and get it as close as possible to the chin using your arms and elevating your shoulders to squeeze your trapezius muscles.\n3. Now lower the bar under controlled motion until it comes back to starting position. ',
        ),
        Exercise(
          name: 'Bent Over Rows',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Stand with a narrow stance and grab hold a bar with overhand grip.\n2. Bend down with knees slightly and let the bar hang in front of you.\n3. Now use the back and raise the bar until it touches the abdominal region and NOT the chest region as it reduces back muscle contraction.\n4. Lower the bar under control to starting position. ',
        ),
        Exercise(
          name: 'Seated cable rows',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Sit on a Seated Cable Pulley rowing machine with legs slightly bent and feet supported against the crossbar.\n2. Take hold of the handles with your arms extended and back stretched.\n3. Pull the handles so that they come as close to the lower chest/abdomen as possible.\n4. Thrust your chest out while pulling with your body in upright position. ',
        ),
        // Exercise(
        //   name: 'Straight Arm Pulldowns',
        //   assetImage: 'https://via.placeholder.com/300',
        //   description: 'Click for description ',
        // ),
      ],
    ),
    Exercise(
      name: 'Shoulders',
      assetImage:
          'https://www.sportsinjuryclinic.net/wp-content/uploads/2018/08/shoulder-pain800.jpg',
      description: 'Description for Chest Press',
      subExercises: [
        Exercise(
          name: 'Seated Shoulder Presses',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Sit on an exercise bench and grab a bar with overhand grip.\n2. Now press the weight above the head.\n3. Now lower the bar under controlled motion until it reaches back to starting position. ',
        ),
        Exercise(
          name: 'Shoulder Machine Presses',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Grasp the bar on the shoulder machine at shoulder levels. \n2. Now press the bar overhead until your arms are nearly locked out.\n3. Lower the bar back to the starting position under controlled motion.   ',
        ),
        Exercise(
          name: 'Lateral Raises',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Hold a dumbbell in each hand and bring the weights together in front of you. The palms should be facing each other.\n2. Now bend your elbows and raise the dumbbells to your sides.\n3. Lift them to a point slightly higher than your shoulders.\n4. Now lower the dumbbells in a controlled manner back to the starting position. ',
        ),
        Exercise(
          name: 'Front Dumbbell Raises',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Stand straight with a dumbbell in each hand. Let the dumbbells hang in front of you with back of your hands facing forwards.\n2. Raise one dumbbell {say right } in front of you till it reaches just above shoulder level.\n3. Now lower the weight {right} while raising the left in front of you.\n4. Perform this exercise in this alternating manner. ',
        ),
        // Exercise(
        //   name: 'Upright Cable Rows',
        //   assetImage: 'https://via.placeholder.com/300',
        //   description: 'Click for description ',
        // ),
        // Exercise(
        //   name: 'Upright Barbell Rows',
        //   assetImage: 'https://via.placeholder.com/300',
        //   description: 'Click for description ',
        // ),
      ],
    ),
    Exercise(
      name: 'Biceps',
      assetImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjqQTRRif-pBF-DSX_Y5CKrhV5dJ2MRsjH0Q&usqp=CAU',
      description: 'Description for Chest Press',
      subExercises: [
        Exercise(
          name: 'Alternate Dumbbell Curls',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Stand with a dumbell in each hand with Elbows tucked in to sides.\n2. Bring the dumbbells up to the front your shoulders by bending your elbows.\n3. Hold for a second at the top before returning to start position. ',
        ),
        Exercise(
          name: 'Barbell Curls',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Hold the barbell with palms facing forward just outside of your hips.\n2. Maintaining tension on your biceps, curl the bar up to shoulder height.\n3. Lower the bar slowly, keeping your biceps tensed and engaged.',
        ),
        Exercise(
          name: 'Rope Curls',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Set up cable to low position and clip in the rope. Hold below rope caps.\n2. Bring the rope up to the front your shoulders by bending your elbows.\n3. Hold for a second at the top before returning to start position. ',
        ),
        Exercise(
          name: 'Concentration Curls',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Sit on bench with dumbell in one hand and elbow resting inside your knee.\n2. Lean forward so your torso is over your legs and place free hand on free knee.\n3. Curl the dumbbell up to shoulder level then slowly lower to start position.',
        ),
        // Exercise(
        //   name: 'cable Curls',
        //   assetImage: 'https://via.placeholder.com/300',
        //   description: 'Click for description ',
        // ),
        // Exercise(
        //   name: 'Hammer Curls',
        //   assetImage: 'https://via.placeholder.com/300',
        //   description: 'Click for description ',
        // ),
      ],
    ),
    Exercise(
      name: 'Tricpes',
      assetImage:
          'https://www.bodybuilding.com/images/2021/april/10-best-triceps-exercises-for-muscle-skinny-960x540.jpg',
      description: 'Description for Chest Press',
      subExercises: [
        Exercise(
          name: 'Cable Press Down',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Attach bar to top of cable stack. Stand holding bar with knuckles pointing upwards and elbows tucked in to your sides.\n2. Extend arms down until elbows are almost straight, then return to start.',
        ),
        Exercise(
          name: 'French Press',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Lie flat on bench with a close grip, with bar extended above shoulders.\n2. Slowly bring the bar down towards your forehead, keeping elbows pointing upwards and shoulder width apart. Extend back to start position at top. ',
        ),
        Exercise(
          name: 'Triceps Kickbacks',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Place knee and one hand on flat bench. Lift elbow up to start position at ribs.\n2. Extend arm backwards to almost straight, keeping shoulder still and elbow tucked in. Return to start position of 90-degree angle at elbow. ',
        ),
        Exercise(
          name: 'Tricpes Dips',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Hold parallel bars and jump/step up to straighten your arms.\n2. Lower your body by bending your arms until shoulders are below elbows.\n3. Lift your body back up by straightening your arms until fully extended. ',
        ),
        // Exercise(
        //   name: 'Cable Extension',
        //   assetImage: 'https://via.placeholder.com/300',
        //   description: 'Click for description ',
        // ),
        // Exercise(
        //   name: 'Bench Dips',
        //   assetImage: 'https://via.placeholder.com/300',
        //   description: 'Click for description ',
        // ),
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
          'Upper Body Exercises',
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
                    MaterialPageRoute(builder: (context) => UpperBodyPage())),
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
