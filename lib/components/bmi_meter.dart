import 'package:flutter/material.dart';

class BmiCategoriesChart extends StatelessWidget {
  const BmiCategoriesChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BmiCategory(
          title: 'Very Severely Underweight',
          range: '≤ 15.9',
          color: Colors.blue,
          textColor: Colors.white,
          rangeColor: Colors.white,
        ),
        BmiCategory(
          title: 'Severely Underweight',
          range: '16.0 - 16.9',
          color: Colors.blue,
          textColor: Colors.white,
          rangeColor: Colors.white,
        ),
        BmiCategory(
          title: 'Underweight',
          range: '17.0 - 18.4',
          color: Colors.blue,
          textColor: Colors.white,
          rangeColor: Colors.white,
        ),
        BmiCategory(
          title: 'Normal',
          range: '18.5 - 24.9',
          color: Colors.green,
          textColor: Colors.white,
          rangeColor: Colors.white,
        ),
        BmiCategory(
          title: 'Overweight',
          range: '25.0 - 29.9',
          color: Colors.red,
          textColor: Colors.white,
          rangeColor: Colors.white,
        ),
        BmiCategory(
          title: 'Obese Class I',
          range: '30.0 - 34.9',
          color: Colors.red,
          textColor: Colors.white,
          rangeColor: Colors.white,
        ),
        BmiCategory(
          title: 'Obese Class II',
          range: '35.0 - 39.9',
          color: Colors.red,
          textColor: Colors.white,
          rangeColor: Colors.white,
        ),
        BmiCategory(
          title: 'Obese Class III',
          range: '≥ 40.0',
          color: Colors.red,
          textColor: Colors.white,
          rangeColor: Colors.white,
        ),
      ],
    );
  }
}

class BmiCategory extends StatelessWidget {
  final String title;
  final String range;
  final Color color;
  final Color textColor;
  final Color rangeColor;

  const BmiCategory({
    Key? key,
    required this.title,
    required this.range,
    required this.color,
    this.textColor = Colors.black,
    this.rangeColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.arrow_right, color: color),
          SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
          Spacer(),
          Text(range, style: TextStyle(color: rangeColor)),
        ],
      ),
    );
  }
}
