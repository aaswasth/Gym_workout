import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: const CalculatorRPE(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}

class OneRepMaxRecord {
  final double oneRepMax;
  final DateTime date;

  OneRepMaxRecord({required this.oneRepMax, required this.date});

  Map<String, dynamic> toJson() => {
        'oneRepMax': oneRepMax,
        'date': date.toIso8601String(),
      };

  static OneRepMaxRecord fromJson(Map<String, dynamic> json) => OneRepMaxRecord(
        oneRepMax: json['oneRepMax'],
        date: DateTime.parse(json['date']),
      );
}

class CalculatorRPE extends StatefulWidget {
  const CalculatorRPE({Key? key}) : super(key: key);

  @override
  _CalculatorRPEState createState() => _CalculatorRPEState();
}

class _CalculatorRPEState extends State<CalculatorRPE> {
  double weight = 0.0;
  int reps = 0;
  double oneRepMax = 0.0;
  bool calculated = false;
  List<OneRepMaxRecord> records = [];

  @override
  void initState() {
    super.initState();
    loadOneRepMaxRecords();
  }

  void calculateOneRepMax() {
    if (weight > 0 && reps > 0) {
      final newOneRepMax = weight / (1.0278 - 0.0278 * reps);
      setState(() {
        oneRepMax = newOneRepMax;
        calculated = true;
      });
      saveOneRepMaxRecord(newOneRepMax);
    }
  }

  Future<void> saveOneRepMaxRecord(double oneRepMax) async {
    final newRecord =
        OneRepMaxRecord(oneRepMax: oneRepMax, date: DateTime.now());
    final prefs = await SharedPreferences.getInstance();
    List<String> recordsStringList =
        prefs.getStringList('oneRepMaxRecords') ?? [];
    recordsStringList.add(json.encode(newRecord.toJson()));
    await prefs.setStringList('oneRepMaxRecords', recordsStringList);
    loadOneRepMaxRecords();
  }

  Future<void> loadOneRepMaxRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final recordsStringList = prefs.getStringList('oneRepMaxRecords') ?? [];
    final loadedRecords = recordsStringList
        .map((recordString) =>
            OneRepMaxRecord.fromJson(json.decode(recordString)))
        .toList();
    setState(() {
      records = loadedRecords;
    });
  }

  Future<void> deleteOneRepMaxRecord(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> recordsStringList =
        prefs.getStringList('oneRepMaxRecords') ?? [];
    if (index >= 0 && index < recordsStringList.length) {
      recordsStringList.removeAt(index);
      await prefs.setStringList('oneRepMaxRecords', recordsStringList);
      loadOneRepMaxRecords();
    }
  }

  List<RPRecord> calculateRPE(double oneRepMax) {
    final List<RPRecord> rpeRecords = [];
    final Map<int, int> estimatedRepsForPercentage = {
      100: 1,
      95: 2,
      90: 4,
      85: 6,
      80: 8,
      75: 10,
      70: 12,
      65: 16,
      60: 20,
      55: 24,
      50: 30,
    };
    for (final entry in estimatedRepsForPercentage.entries) {
      final int percentage = entry.key;
      final int rep = entry.value;
      final double weightLifted = oneRepMax * (percentage / 100);
      rpeRecords.add(RPRecord(
        percentage: percentage,
        weightLifted: weightLifted,
        reps: rep,
      ));
    }
    return rpeRecords;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('1 Rep Max Calculator',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Weight (lbs)',
                  labelStyle: const TextStyle(
                      color: Colors.white), // Adjust label text color
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    // Border color when TextField is enabled
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    // Border color when TextField is focused
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  suffixIcon: const Icon(Icons.fitness_center,
                      color: Colors.white), // Icon color
                  fillColor: Colors.grey[800], // Fill color for the TextField
                  filled: true, // Enable fill color
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                    color: Colors.white), // Adjust input text color
                onChanged: (value) {
                  setState(() {
                    weight = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Reps',
                  labelStyle: const TextStyle(
                      color: Colors.white), // Adjust label text color
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    // Border color when TextField is enabled
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    // Border color when TextField is focused
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  suffixIcon: const Icon(Icons.repeat,
                      color: Colors.white), // Icon color
                  fillColor: Colors.grey[800], // Fill color for the TextField
                  filled: true, // Enable fill color
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                    color: Colors.white), // Adjust input text color
                onChanged: (value) {
                  setState(() {
                    reps = int.tryParse(value) ?? 0;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculateOneRepMax,
                child: const Text('Calculate'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Background color
                  onPrimary: Colors.white, // Foreground (text) color
                ),
              ),
              if (calculated) ...[
                const SizedBox(height: 20),
                Text(
                  'Your 1 Rep max is: ${oneRepMax.toStringAsFixed(1)} lbs',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Rate of Perceived Exertion (RPE) at Different Intensities:',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Table(
                  border: TableBorder.all(color: Colors.white),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(2),
                  },
                  children: [
                    const TableRow(children: [
                      TableCell(
                        child: Center(
                          child: Text(
                            'Percentage',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Weight Lifted (lbs)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'Reps',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ]),
                    ...calculateRPE(oneRepMax).map((rpeRecord) {
                      return TableRow(children: [
                        TableCell(
                          child: Center(
                            child: Text(
                              '${rpeRecord.percentage}%',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              '${rpeRecord.weightLifted.toStringAsFixed(1)}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              '${rpeRecord.reps}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Past 1 Rep Max Entries:',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                DataTable(
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        '1 Rep Max',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Action',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                  rows: records.map((record) {
                    final index = records.indexOf(record);
                    return DataRow(cells: [
                      DataCell(
                        Text(
                          DateFormat.yMMMd().format(record.date),
                          style: const TextStyle(
                              fontSize: 12.5, color: Colors.white),
                        ),
                      ),
                      DataCell(
                        Text(
                          record.oneRepMax.toStringAsFixed(1),
                          style: const TextStyle(
                              fontSize: 12.5, color: Colors.white),
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteOneRepMaxRecord(index),
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class RPRecord {
  final int percentage;
  final int reps;
  final double weightLifted;

  RPRecord({
    required this.percentage,
    required this.reps,
    required this.weightLifted,
  });
}
