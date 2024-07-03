import 'dart:convert';

import 'package:capstone_project/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class WorkoutTracker extends StatefulWidget {
  const WorkoutTracker({Key? key}) : super(key: key);
  static String latestWorkoutName = '';

  @override
  State<WorkoutTracker> createState() => _WorkoutTrackerState();
}

class _WorkoutTrackerState extends State<WorkoutTracker> {
  TextEditingController _nameController = TextEditingController();
  List<Workout> workouts = [];

  @override
  void initState() {
    super.initState();
    fetchWorkouts(); // Fetch workouts when the widget initializes
  }

  Future<void> fetchWorkouts() async {
    try {
      // Get the workout snapshot from the workouts collection
      QuerySnapshot workoutSnapshot =
          await FirebaseFirestore.instance.collection('workouts').get();
      List<Workout> fetchedWorkouts = [];

      // Check if there are workouts and set the latest workout name
      if (workoutSnapshot.docs.isNotEmpty) {
        var lastWorkoutDoc =
            workoutSnapshot.docs.last.data() as Map<String, dynamic>;
        WorkoutTracker.latestWorkoutName = lastWorkoutDoc['name'];
      } else {
        WorkoutTracker.latestWorkoutName = 'No workouts available';
      }

      // Iterate over each workout document
      for (var workoutDoc in workoutSnapshot.docs) {
        var data = workoutDoc.data() as Map<String, dynamic>;
        List<Exercise> exercises = [];

        // Fetch the subcollection of exercises for this particular workout
        QuerySnapshot exerciseSnapshot =
            await workoutDoc.reference.collection('exercises').get();

        // Iterate over each exercise document within the subcollection
        for (var exerciseDoc in exerciseSnapshot.docs) {
          Map<String, dynamic> exerciseData =
              exerciseDoc.data() as Map<String, dynamic>;
          String exerciseId = exerciseDoc.id;
          exercises.add(Exercise.fromFirestore(exerciseId, exerciseData));
        }

        // Add the workout with its exercises to the list
        fetchedWorkouts.add(Workout(
          id: workoutDoc.id,
          name: data['name'],
          exercises: exercises,
        ));
      }

      // Update the state to display workouts
      setState(() {
        workouts = fetchedWorkouts;
      });
    } catch (e) {
      print("Error fetching workouts: $e");
    }
  }

  void addWorkout(String name) async {
    try {
      var docRef = await FirebaseFirestore.instance.collection('workouts').add({
        'name': name,
        'timestamp':
            FieldValue.serverTimestamp(), // Adds a server-side timestamp
      });

      setState(() {
        workouts.add(Workout(id: docRef.id, name: name, exercises: []));
        WorkoutTracker.latestWorkoutName = name;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Workout added successfully')),
      );

      _nameController.clear();
    } catch (e) {
      print("Error adding workout: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true, // Disables the back button action
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Text(
            'Workout Tracker',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter a workout name',
                  hintStyle: TextStyle(color: Colors.white38),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey.shade900,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => addWorkout(_nameController.text),
                icon: Icon(Icons.add),
                label: Text('Add Workout'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange, // Background color
                  onPrimary: Colors.white, // Text color
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: workouts.length,
                  itemBuilder: (context, index) {
                    return ExpandableColumn(
                      workout: workouts[index],
                      onDelete: () async {
                        // Reference to the workout document
                        DocumentReference workoutRef = FirebaseFirestore
                            .instance
                            .collection('workouts')
                            .doc(workouts[index].id);

                        // First delete all documents in the subcollection 'exercises'
                        QuerySnapshot exercisesSnapshot =
                            await workoutRef.collection('exercises').get();
                        for (QueryDocumentSnapshot exerciseDoc
                            in exercisesSnapshot.docs) {
                          await workoutRef
                              .collection('exercises')
                              .doc(exerciseDoc.id)
                              .delete();
                        }

                        // After all subdocuments are deleted, delete the workout document
                        try {
                          await workoutRef.delete();
                          setState(() {
                            workouts.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Workout deleted successfully')),
                          );
                        } catch (e) {
                          print("Error deleting workout: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Error deleting workout')),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Exercise {
  final String id;
  final String name;
  final List<ExerciseSet> sets;

  Exercise({required this.id, required this.name, required this.sets});

  factory Exercise.fromFirestore(String id, Map<String, dynamic> doc) {
    final setsData = doc['sets'];
    List<Map<String, dynamic>> setsListMaps = [];

    try {
      if (setsData is String) {
        final parsedData = jsonDecode(setsData);
        if (parsedData is List) {
          setsListMaps = List<Map<String, dynamic>>.from(parsedData);
        } else {
          print("Parsed data is not a List");
        }
      } else if (setsData is Iterable) {
        setsListMaps = List<Map<String, dynamic>>.from(setsData);
      } else {
        print("Unexpected data type for 'sets': ${setsData.runtimeType}");
      }
    } catch (e) {
      print("Error parsing 'sets' data: $e");
    }

    var setsList = setsListMaps.map((set) {
      final String sets = set['sets'] == null ? '' : set['sets'].toString();
      final String reps = set['reps'] == null ? '' : set['reps'].toString();
      final String weight =
          set['weight'] == null ? '' : set['weight'].toString();
      return ExerciseSet(sets: sets, reps: reps, weight: weight);
    }).toList();

    return Exercise(
      id: id,
      name: doc['exerciseName'] ?? 'Unknown Exercise',
      sets: setsList,
    );
  }
}

class Workout {
  final String id;
  final String name;
  final List<Exercise> exercises;

  Workout({required this.id, required this.name, this.exercises = const []});
}

class ExpandableColumn extends StatefulWidget {
  final Workout workout;
  final VoidCallback onDelete;

  const ExpandableColumn({
    Key? key,
    required this.workout,
    required this.onDelete,
  }) : super(key: key);

  @override
  _ExpandableColumnState createState() => _ExpandableColumnState();
}

class _ExpandableColumnState extends State<ExpandableColumn> {
  bool expanded = false;
  List<ExerciseWidget> exercisesWidgets = [];

  @override
  void initState() {
    super.initState();
    exercisesWidgets = widget.workout.exercises
        .map((exercise) => ExerciseWidget(
              key: ValueKey(exercise.id),
              workoutId: widget.workout.id,
              exercise: exercise,
              onDelete: () {
                setState(() {
                  widget.workout.exercises.remove(exercise);
                  exercisesWidgets.removeWhere(
                      (widget) => widget.key == ValueKey(exercise.name));
                });
              },
            ))
        .toList();
  }

  void _addExercise() {
    setState(() {
      exercisesWidgets.add(ExerciseWidget(
        key: UniqueKey(),
        workoutId: widget.workout.id,
        onDelete: () {},
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey[850], // Card background color
          borderRadius: BorderRadius.circular(10), // Card corner radius
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.workout.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete,
                      color: Colors.red), // Delete icon
                  onPressed: widget.onDelete, // Call onDelete callback
                ),
              ],
            ),
            if (expanded) ...[
              const SizedBox(height: 10),
              ...exercisesWidgets,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange, // Button background color
                  onPrimary: Colors.white, // Button text color
                ),
                onPressed: _addExercise,
                child: const Text('Add Exercise'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ExerciseWidget extends StatefulWidget {
  final String workoutId;
  final Exercise? exercise;
  final VoidCallback onDelete;

  const ExerciseWidget({
    Key? key,
    required this.workoutId,
    required this.onDelete,
    this.exercise,
  }) : super(key: key);

  @override
  _ExerciseWidgetState createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  final TextEditingController exerciseNameController = TextEditingController();
  List<ExerciseSet> exerciseSets = [];
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.exercise != null) {
      // If an existing exercise is passed, use its data
      exerciseNameController.text = widget.exercise!.name;
      exerciseSets = widget.exercise!.sets;
    } else {
      // Otherwise, initialize with one set for a new exercise
      exerciseSets.add(ExerciseSet(sets: '', reps: '', weight: ''));
    }
  }

  void _addExerciseSet() {
    setState(() {
      exerciseSets.add(ExerciseSet(sets: '', reps: '', weight: ''));
    });
  }

  Future<void> _saveExerciseData() async {
    if (_isSaving) return; // Prevent saving while already in progress
    if (exerciseNameController.text.isNotEmpty &&
        exerciseSets.every((set) => set.isValid())) {
      setState(() {
        _isSaving = true; // Set saving state to true
      });

      try {
        // Check if we are updating an existing exercise or creating a new one
        if (widget.exercise != null && widget.exercise!.id.isNotEmpty) {
          // Exercise already exists, so we update it
          await FirebaseFirestore.instance
              .collection('workouts')
              .doc(widget.workoutId)
              .collection('exercises')
              .doc(widget.exercise!.id) // Use the existing exercise ID
              .update({
            'exerciseName': exerciseNameController.text,
            'sets': exerciseSets.map((set) => set.toMap()).toList(),
          });
        } else {
          // New exercise, so we create it
          await FirebaseFirestore.instance
              .collection('workouts')
              .doc(widget.workoutId)
              .collection('exercises')
              .add({
            'exerciseName': exerciseNameController.text,
            'sets': exerciseSets.map((set) => set.toMap()).toList(),
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Exercise saved successfully')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error saving exercise')));
      } finally {
        setState(() {
          _isSaving = false; // Reseting save state
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')));
    }
  }

  void _deleteExercise() {
    widget.onDelete(); // Notify the parent widget to delete this exercise
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: exerciseNameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Exercise Name',
                  labelStyle: TextStyle(color: Colors.deepOrange),
                  hintText: 'Enter exercise name',
                  hintStyle: TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrangeAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fillColor: Colors.grey[850],
                  filled: true,
                ),
              ),
            ),
            // IconButton(
            //   icon: Icon(Icons.delete, color: Colors.red),
            //   onPressed: _deleteExercise, // Ensure this is hooked up properly
            // ),
          ],
        ),
        const SizedBox(height: 20),
        ...exerciseSets.map((set) => set.buildSet(
            context, exerciseSets.indexOf(set), () => setState(() {}))),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: _addExerciseSet,
              icon: Icon(Icons.add, color: Colors.white),
              label: Text('Add Set'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
                onPrimary: Colors.white,
              ),
            ),
            ElevatedButton.icon(
              onPressed: _saveExerciseData,
              icon: Icon(Icons.save, color: Colors.white),
              label: Text('Save Exercise'),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class ExerciseSet {
  String sets;
  String reps;
  String weight;

  ExerciseSet({required this.sets, required this.reps, required this.weight});

  bool isValid() {
    return sets.isNotEmpty && reps.isNotEmpty && weight.isNotEmpty;
  }

  Map<String, dynamic> toMap() {
    return {
      'sets': sets,
      'reps': reps,
      'weight': weight,
    };
  }

  Widget buildSet(BuildContext context, int index, VoidCallback onChange) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: sets,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Sets $index',
                labelStyle: TextStyle(color: Colors.deepOrange),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrangeAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.grey[850],
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              ),
              onChanged: (value) {
                sets = value;
                onChange();
              },
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(width: 10),
          SizedBox(height: 10),
          Expanded(
            child: TextFormField(
              initialValue: reps,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Reps $index',
                labelStyle: TextStyle(color: Colors.deepOrange),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrangeAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.grey[850],
                filled: true,
              ),
              onChanged: (value) {
                reps = value;
                onChange();
              },
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              initialValue: weight,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Weight $index (kg)',
                labelStyle: TextStyle(color: Colors.deepOrange),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrangeAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.grey[850],
                filled: true,
              ),
              onChanged: (value) {
                weight = value;
                onChange();
              },
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
