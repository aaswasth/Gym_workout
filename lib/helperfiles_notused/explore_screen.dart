// ignore_for_file: use_build_context_synchronously
//this was the first demo page but i am not using this anymore, thanks for helping/ existing

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _exerciseController = TextEditingController();
  late final Stream<QuerySnapshot> _exercisesStream;
  List<bool> _expandedStateList = [];

  List<List<TextEditingController>> _setsControllersList = [[]];
  List<List<TextEditingController>> _repsControllersList = [[]];
  List<List<TextEditingController>> _weightControllersList = [[]];
  bool _workoutInProgress = false;
  DateTime? _workoutStartTime;

  @override
  void initState() {
    super.initState();
    _exercisesStream =
        FirebaseFirestore.instance.collection('exercises').snapshots();

    _exercisesStream.listen((snapshot) {
      setState(() {
        _expandedStateList = List<bool>.filled(snapshot.docs.length, false);
        _initializeControllers(snapshot.docs.length);
      });
    });
    _fetchData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchData();
  }

  void _initializeControllers(int length) {
    _setsControllersList = List.generate(
      length,
      (_) => [
        TextEditingController(),
      ],
    );
    _repsControllersList = List.generate(
      length,
      (_) => [
        TextEditingController(),
      ],
    );
    _weightControllersList = List.generate(
      length,
      (_) => [
        TextEditingController(),
      ],
    );
  }

  void _addRow(int exerciseIndex) {
    setState(() {
      _initializeRows(exerciseIndex);
    });
  }

  void _initializeRows(int index) {
    _setsControllersList[index].add(TextEditingController());
    _repsControllersList[index].add(TextEditingController());
    _weightControllersList[index].add(TextEditingController());
  }

  void _fetchData() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('exercises').get();
      final List<QueryDocumentSnapshot> exercises = snapshot.docs;
      setState(() {
        _expandedStateList = List<bool>.filled(exercises.length, false);
        _initializeControllers(exercises.length);
      });

      for (int i = 0; i < exercises.length; i++) {
        final exerciseDoc = exercises[i];
        final exerciseRef = exerciseDoc.reference;

        final rowDataSnapshot = await exerciseRef.collection('Numbers').get();
        final List<QueryDocumentSnapshot> rowData = rowDataSnapshot.docs;

        _initializeRows(i);

        for (int j = 0; j < rowData.length; j++) {
          final rowDoc = rowData[j];
          final rowDataMap = rowDoc.data() as Map<String, dynamic>;
          final TextEditingController setsController =
              _setsControllersList[i][j];
          final TextEditingController repsController =
              _repsControllersList[i][j];
          final TextEditingController weightController =
              _weightControllersList[i][j];

          setsController.text = rowDataMap['sets'] ?? '';
          repsController.text = rowDataMap['reps'] ?? '';
          weightController.text = rowDataMap['weight'] ?? '';
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _submitButton() async {
    try {
      if (!_workoutInProgress) {
        _workoutStartTime = DateTime.now();
        setState(() {
          _workoutInProgress = true;
        });
      }
      String exerciseName = _exerciseController.text;
      CollectionReference exercises =
          FirebaseFirestore.instance.collection('exercises');

      DocumentReference exerciseDocRef = await exercises.add({
        'exerciseName': exerciseName,
      });

      _exerciseController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Exercise data submitted successfully!'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit exercise data: $e'),
        ),
      );
    }
  }

  void _endWorkout() {
    setState(() {
      _workoutInProgress = false;
      _workoutStartTime = null;
    });
  }

  void _saveRowData(
      DocumentReference exerciseDocRef, int exerciseIndex, int rowIndex) async {
    try {
      String sets = _setsControllersList[exerciseIndex][rowIndex].text;
      String reps = _repsControllersList[exerciseIndex][rowIndex].text;
      String weight = _weightControllersList[exerciseIndex][rowIndex].text;

      if (sets.isNotEmpty && reps.isNotEmpty && weight.isNotEmpty) {
        Map<String, String> dataToSave = {
          'sets': sets,
          'reps': reps,
          'weight': weight,
        };

        String documentId = 'row_$rowIndex';

        // Create a reference to the document in Firestore
        DocumentReference documentRef =
            exerciseDocRef.collection('Numbers').doc(documentId);

        // Set the data to Firestore with merge option set to true
        await documentRef.set(dataToSave, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Results saved successfully!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all fields before saving.'),
          ),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save results: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue[600],
      //   title: const Text('Your workouts'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Start a workout',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _exerciseController,
              decoration: const InputDecoration(
                labelText: 'Exercise Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitButton,
                child: const Text('Submit'),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                key: const PageStorageKey('explore_screen'),
                stream: _exercisesStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final exercises = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, exerciseIndex) {
                      final data = exercises[exerciseIndex].data()
                          as Map<String, dynamic>;
                      final exerciseName = data['exerciseName'] as String;
                      final isExpanded =
                          _expandedStateList.length > exerciseIndex
                              ? _expandedStateList[exerciseIndex]
                              : false;

                      return Column(
                        children: [
                          ListTile(
                            title: Text(exerciseName),
                            onTap: () {
                              setState(() {
                                _expandedStateList[exerciseIndex] = !isExpanded;
                              });
                            },
                          ),
                          if (isExpanded) ...[
                            for (int rowIndex = 0;
                                rowIndex <
                                    _setsControllersList[exerciseIndex].length;
                                rowIndex++) ...[
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller:
                                          _setsControllersList[exerciseIndex]
                                              [rowIndex],
                                      decoration: const InputDecoration(
                                        labelText: 'Sets',
                                        border: OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller:
                                          _repsControllersList[exerciseIndex]
                                              [rowIndex],
                                      decoration: const InputDecoration(
                                        labelText: 'Reps',
                                        border: OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextFormField(
                                      controller:
                                          _weightControllersList[exerciseIndex]
                                              [rowIndex],
                                      decoration: const InputDecoration(
                                        labelText: 'Weight',
                                        border: OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    icon: const Icon(Icons.check),
                                    onPressed: () {
                                      DocumentReference exerciseDocRef =
                                          exercises[exerciseIndex].reference;
                                      _saveRowData(exerciseDocRef,
                                          exerciseIndex, rowIndex);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => _addRow(exerciseIndex),
                            ),
                          ],
                          Divider(),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
