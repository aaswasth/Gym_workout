import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WaterIntakeWidget extends StatefulWidget {
  @override
  _WaterIntakeWidgetState createState() => _WaterIntakeWidgetState();
}

class _WaterIntakeWidgetState extends State<WaterIntakeWidget>
    with SingleTickerProviderStateMixin {
  double _waterIntake = 0.0;
  final double _maxWaterIntake = 3.5; // Max intake of 2 liters
  late AnimationController _progressAnimationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 0.0)
        .animate(_progressAnimationController)
      ..addListener(() {
        setState(() {});
      });
    _fetchWaterIntake();
  }

  Future<void> _fetchWaterIntake() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String userId = user.email ?? "";
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('water_intake')
            .doc(userId)
            .get();
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          final lastUpdateTimestamp = (data['timestamp'] as Timestamp).toDate();
          final currentTimestamp = DateTime.now();

          // Check if more than 24 hours have passed since the last update
          if (currentTimestamp.difference(lastUpdateTimestamp).inHours >= 24) {
            _waterIntake = 0.0;
            saveWaterIntake(_waterIntake);
          } else {
            _waterIntake = data['water_intake'] as double;
          }

          setState(() {
            _progressAnimation = Tween<double>(
              begin: _progressAnimation.value,
              end: _waterIntake / _maxWaterIntake,
            ).animate(_progressAnimationController);
            _progressAnimationController.forward(from: 0.0);
          });
        }
      } catch (error) {
        print('Error fetching water intake data: $error');
      }
    }
  }

  Future<void> saveWaterIntake(double waterIntake) async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final String userId = user!.email ?? "";
      await firestore.collection('water_intake').doc(userId).set({
        'water_intake': waterIntake,
        'timestamp': DateTime.now(),
      });
      print('Water intake data saved successfully.');
    } catch (error) {
      print('Error saving water intake data: $error');
    }
  }

  Widget _buildWaterIntakeButton(String label, double amount, IconData icon) {
    return SizedBox(
      width: 120,
      height: 40,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.black),
        label: Text(label),
        onPressed: () => _updateWaterIntake(amount),
        style: ElevatedButton.styleFrom(
          primary: Colors.redAccent, // Button color
          onPrimary: Colors.black, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _updateWaterIntake(double liters) {
    setState(() {
      _waterIntake += liters;
      if (_waterIntake > _maxWaterIntake) {
        _waterIntake = _maxWaterIntake;
      }
      _progressAnimation = Tween<double>(
        begin: _progressAnimation.value,
        end: _waterIntake / _maxWaterIntake,
      ).animate(_progressAnimationController);
      _progressAnimationController.forward(from: 0.0);

      saveWaterIntake(_waterIntake);
    });
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    super.dispose();
  }

  Widget _buildWaterIntakeContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildWaterIntakeButton('Add 250ml', 0.25, Icons.water),
              _buildWaterIntakeButton('Add 500ml', 0.50, Icons.water),
              SizedBox(
                width: 80,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    _showCustomDialog();
                  },
                  child: Center(
                    child: Icon(Icons.add),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          CustomProgressBar(
            value: _waterIntake / _maxWaterIntake,
            color: Colors.lightBlue, // Color of the progress bar
          ),
          SizedBox(height: 8.0),
          Text(
            'Water Intake: ${_waterIntake.toStringAsFixed(2)}L / $_maxWaterIntake L',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomDialog() {
    TextEditingController _customAmountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text(
            "Enter Custom Amount",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          content: TextField(
            controller: _customAmountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: "Amount (Milliliters)",
              labelStyle: TextStyle(color: Colors.white60),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                // Border color when TextField is enabled
                borderSide: BorderSide(color: Colors.white38),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                // Border color when TextField is focused
                borderSide: BorderSide(color: Colors.white70),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Done',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                ),
              ),
              onPressed: () {
                // Check if the input is a valid number
                final customAmountInMilliliters =
                    double.tryParse(_customAmountController.text);
                if (customAmountInMilliliters != null &&
                    customAmountInMilliliters > 0) {
                  double customAmountInLiters =
                      customAmountInMilliliters / 1000; // Convert to liters
                  _updateWaterIntake(customAmountInLiters);
                  _customAmountController.clear();
                  Navigator.of(context).pop();
                } else {
                  // Show an error message if the input is invalid
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Please enter a valid amount in milliliters.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWaterIntakeContainer();
  }
}

class CustomProgressBar extends StatelessWidget {
  final double value;
  final Color color;

  const CustomProgressBar({
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              height: 20, // Adjust height as needed
              decoration: BoxDecoration(
                color: Colors.grey[300], // Background color of the progress bar
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
                width: constraints.maxWidth *
                    value, // Use LayoutBuilder constraints
                height: 20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.5), color],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
