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

class absPage extends StatelessWidget {
  final List<Exercise> chestExercises = [
    Exercise(
      name: 'Upper Abs',
      assetImage: '',
      description: 'Description for Abs',
      subExercises: [
        Exercise(
          name: 'Crunches',
          assetImage: 'assets/incline_barbell.jpg',
          description:
              '1. Start Position: Lie on your back with your knees bent and feet flat on the floor, hip-width apart. Place your hands behind your head, lightly supporting it with your fingers.\n2. Movement: Engage your core and lift your upper body towards your knees, keeping your lower back pressed into the floor. Your neck should remain relaxed, and your chin slightly up.\n 3.Return: Slowly lower back down to the starting position, controlling the movement with your abs.',
        ),
        Exercise(
          name: 'High Crunches',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Start in the same position as regular crunches, lying on your back with knees bent, feet flat, and hands behind your head.\n2. Engage your core and lift your upper body off the floor higher than in a regular crunch, aiming to bring your chest closer to your knees.\n3. Hold the position at the top for a moment, then slowly lower yourself back down to the starting position.',
        ),
        Exercise(
          name: 'Long Arm Crunches',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Lie on your back with your knees bent and feet flat on the floor. Stretch your arms straight behind your head, with your hands clasped together.\n2. Engage your core and lift your upper body off the floor, keeping your arms next to your ears. Try to lift your shoulder blades as high off the mat as you can.\n3. Slowly lower yourself back to the starting position, keeping your arms extended throughout the movement.',
        ),
        Exercise(
          name: 'Knee Crunches',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Lie on your back on a mat with your knees bent in towards your chest and hands behind your head, elbows wide.\n2. Engage your core, pulling your belly button towards your spine. Lift your upper body off the floor, aiming to bring your elbows closer to your knees.\n 3. Slowly lower your upper body back down to the starting position, while simultaneously straightening your legs back to the bent-knee position',
        ),
        // Exercise(
        //   name: 'Front Squat',
        //   assetImage: 'https://via.placeholder.com/300',
        //   description:
        //       '1. Sit on a Leg Extensions Machine with your legs under the padded bar and hold the side bars with your hands for support.\n2. Extend as far as possible until your legs are locked out to get a maximum thigh contraction.\n3. Get back to the start position and repeat.',
        // ),
      ],
    ),
    Exercise(
      name: 'Lower Abs',
      assetImage:
          'https://cdn.muscleandstrength.com/sites/default/files/best_back_exercises_-_1200x630.jpg',
      description: 'Description for Lower Abs',
      subExercises: [
        Exercise(
          name: 'Reverse Crunches',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Lie on your back with your hands by your sides or underneath your glutes for support. Lift your legs off the ground, bending at the knees to create a 90-degree angle.\n2. Using your core muscles, pull your knees towards your chest, lifting your hips off the floor. Keep your chin off your chest and gaze upwards.\n3. Slowly lower your legs back to the starting position without letting your feet touch the ground to maintain tension in the abs.',
        ),
        Exercise(
          name: 'Scissors',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Lie on your back with your legs extended and arms by your sides. Lift your head, neck, and shoulders slightly off the floor, engaging your core.\n2. Lift both legs off the ground, keeping them straight. Lower one leg towards the floor while keeping the other leg up.\n3. Switch legs in a scissor motion, alternating each leg up and down without touching the floor. Keep your core engaged and move in a controlled manner.',
        ),
        Exercise(
          name: 'Leg Raises',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Lie on your back with your legs extended and hands by your sides or under your lower back for support. Press your lower back into the floor.\n2. Keeping your legs straight and together, slowly lift them up towards the ceiling until they are about perpendicular to the floor. Keep your core engaged and avoid arching your lower back.\n3. Slowly lower your legs back down just above the floor without touching it, and then raise them again. Keep the movement controlled and do not let your lower back lift off the floor.',
        ),
      ],
    ),
    Exercise(
      name: 'Obliques',
      assetImage:
          'https://www.sportsinjuryclinic.net/wp-content/uploads/2018/08/shoulder-pain800.jpg',
      description: 'Description for Chest Press',
      subExercises: [
        Exercise(
          name: 'Sitting Twists(Russian Twists)',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Sit on the floor with your knees bent and feet flat. Lean back slightly to find your balance on your sit bones, keeping your spine straight and chest lifted.\n2. Clasp your hands together or hold a weight in front of your chest. Lift your feet off the floor to increase the challenge, or keep them on the ground for a more moderate exercise.\n3. Twist your torso to the right, bringing your hands or weight towards the floor beside you. Then, twist to the left side. Continue alternating sides, keeping your core engaged and movements controlled',
        ),
        Exercise(
          name: 'Cross Crunches',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Lie on your back with your knees bent and feet flat on the floor. Place your hands lightly behind your head, elbows wide.\n2. Bring your right shoulder and elbow across your body towards your left knee, lifting your left foot off the floor to meet your elbow. Simultaneously straighten your right leg.\n3.  Return to the starting position and repeat on the other side, bringing your left elbow towards your right knee. Alternate sides in a controlled manner, keeping your core engaged throughout.',
        ),
        Exercise(
          name: 'Side Plank',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Lie on your side with your legs straight. Prop your upper body up on your elbow and forearm, which should be directly beneath your shoulder for proper alignment.\n2. Lift your hips off the ground so that your body forms a straight line from your ankles to your shoulders. Keep your core engaged and avoid letting your hips drop.\n3. Hold the position for a set amount of time, then gently lower your hips back to the floor. Repeat on the other side.',
        ),
      ],
    ),
    Exercise(
      name: 'Core',
      assetImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjqQTRRif-pBF-DSX_Y5CKrhV5dJ2MRsjH0Q&usqp=CAU',
      description: 'Description for Chest Press',
      subExercises: [
        Exercise(
          name: 'Half Wipers',
          assetImage: 'assets/incline_barbell.jpg',
          description:
              '1. Lie on your back with your arms extended out to the sides for stability, palms facing down. Raise your legs together towards the ceiling so that your body forms a 90-degree angle.\n2. Keeping your legs straight and together, lower them to one side, stopping before they touch the floor. Keep your shoulders pressed firmly against the floor to avoid rolling over.\n3. Bring your legs back to the center and then lower them to the opposite side. Move in a controlled manner, engaging your core to control the motion. Repeat, alternating sides.',
        ),
        Exercise(
          name: 'Arm/Leg Raises ',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Start in a plank position with your body in a straight line from head to heels, hands directly under your shoulders, and feet hip-width apart.\n2. Raise your right arm and extend it forward while simultaneously lifting your left leg and extending it backward. Keep your body as stable and straight as possible.\n3. Lower your right arm and left leg back to the plank position. Repeat with your left arm and right leg. Continue alternating sides, maintaining balance and form.',
        ),
        Exercise(
          name: 'Knee-In Twists',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Sit on the floor with your knees bent slightly and heels touching the ground. Lean back at a comfortable angle and place your hands on the floor behind you for support.\n2. Lift your feet off the ground and bring your knees towards your chest to engage your core.\n3. Twist your torso and knees to one side, then to the center, and then to the other side. Keep your movements controlled and deliberate, focusing on engaging your obliques.',
        ),
      ],
    ),
    Exercise(
      name: 'Complete',
      assetImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjqQTRRif-pBF-DSX_Y5CKrhV5dJ2MRsjH0Q&usqp=CAU',
      description: 'Description for Core',
      subExercises: [
        Exercise(
          name: 'Knee to Elbow',
          assetImage: 'assets/incline_barbell.jpg',
          description:
              '1. Start in a high plank position with your hands directly under your shoulders and your body in a straight line from your head to your heels.\n2. Bring your right knee towards your right elbow, engaging your core and obliques as you do so. Try to touch your knee to your elbow or bring it as close as possible.\n3. Return your right leg to the starting position and repeat the movement with your left knee to your left elbow. Continue alternating sides, maintaining a strong plank position throughout.',
        ),
        Exercise(
          name: 'Dead Bug',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Start in a high plank position with your hands directly under your shoulders and your body in a straight line from your head to your heels.\n2. Bring your right knee towards your right elbow, engaging your core and obliques as you do so. Try to touch your knee to your elbow or bring it as close as possible.\n3. Return your right leg to the starting position and repeat the movement with your left knee to your left elbow. Continue alternating sides, maintaining a strong plank position throughout.',
        ),
        Exercise(
          name: 'Side Plank Crunches',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Start in a side plank position on your right side, supporting your body on your right forearm with your elbow under your shoulder. Stack your legs and lift your hips to form a straight line with your body.\n2. Place your left hand behind your head. Crunch your left elbow down towards your hip, engaging the side obliques.\n3. Return to the straight side plank position. Repeat the crunches on this side before switching to the other side..',
        ),
        Exercise(
          name: 'V-Sit with Rotations',
          assetImage: 'https://via.placeholder.com/300',
          description:
              '1. Sit on the floor with your legs extended in front of you and lean back slightly to engage your core. Lift your legs off the floor to form a V-shape with your body.\n2. Clasp your hands together or hold a weight in front of your chest. Rotate your torso to the right, bringing your hands or weight towards the floor beside you.\n3. Rotate to the left side, keeping your movements controlled and your core engaged. Continue alternating sides, maintaining the V-sit posture throughout.',
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
          'Abs Exercises',
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
                    MaterialPageRoute(builder: (context) => absPage())),
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
