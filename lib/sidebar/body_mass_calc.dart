import 'package:capstone_project/components/bmi_meter.dart';
import 'package:flutter/material.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

class BmiCalc extends StatefulWidget {
  const BmiCalc({Key? key}) : super(key: key);

  @override
  State<BmiCalc> createState() => _BmiCalcState();
}

class _BmiCalcState extends State<BmiCalc> {
  TextEditingController weightCmController = TextEditingController();
  TextEditingController weightKgController = TextEditingController();
  String bmiResult = '';

  double? get bmiValue {
    if (bmiResult.isNotEmpty) {
      final splitResult = bmiResult.split(": ");
      if (splitResult.length == 2) {
        return double.tryParse(splitResult[1]);
      }
    }
    return null;
  }

  void calculateBMI() {
    double weightCm = double.tryParse(weightCmController.text) ?? 0.0;
    double weightKg = double.tryParse(weightKgController.text) ?? 0.0;

    if (weightCm > 0 && weightKg > 0) {
      double bmi = weightKg / ((weightCm / 100) * (weightCm / 100));
      setState(() {
        bmiResult = "Your BMI is: ${bmi.toStringAsFixed(2)}";
      });
    } else {
      setState(() {
        bmiResult = "Invalid input. Please enter valid values.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.white, fontSize: 35),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: weightCmController,
                style: TextStyle(
                    color: Colors.white), // Set the input text color to white
                decoration: InputDecoration(
                  labelText: 'Height in cm',
                  icon: Icon(Icons.trending_up, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 20),
              TextField(
                controller: weightKgController,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  labelText: 'Weight in kg',
                  icon: Icon(Icons.line_weight, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  onPrimary: Colors.white,
                ),
                child: Text("Calculate"),
                onPressed: calculateBMI,
              ),
              SizedBox(height: 15),
              Text(
                bmiResult,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20), // spacing
              if (bmiValue != null)
                PrettyGauge(
                  gaugeSize: 160,
                  needleColor: Colors.white,
                  segments: [
                    GaugeSegment('Low', 2.5, Colors.blue),
                    GaugeSegment('Medium', 7.0, Colors.green),
                    GaugeSegment('High', 14.5, Colors.red),
                  ],
                  minValue: 16.0,
                  maxValue: 40.0,
                  currentValue: bmiValue!.toDouble(), // Convert BMI to int
                  displayWidget: const Text(
                    'BMI',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              // Text(
              //   'Your BMI is: ${bmiValue?.toStringAsFixed(2)}', // Use bmiValue instead of bmi
              //   style: TextStyle(fontSize: 12),
              // ),

              BmiCategoriesChart(),
            ],
          ),
        ),
      ),
    );
  }
}
