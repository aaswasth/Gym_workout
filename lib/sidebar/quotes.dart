import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(home: Scaffold(body: Center(child: QuoteWidget()))));
}

class QuoteWidget extends StatefulWidget {
  const QuoteWidget({Key? key}) : super(key: key);

  @override
  _QuoteWidgetState createState() => _QuoteWidgetState();
}

class _QuoteWidgetState extends State<QuoteWidget> {
  late String _quote = 'Loading...';
  late DateTime _lastFetchTime;

  @override
  void initState() {
    super.initState();
    _lastFetchTime = DateTime.now();
    _loadQuote();
  }

  Future<void> _loadQuote() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final DateTime lastFetchTime =
        DateTime.fromMillisecondsSinceEpoch(prefs.getInt('lastFetchTime') ?? 0);
    if (DateTime.now().difference(lastFetchTime).inHours >= 24) {
      final String quote = await _fetchQuote();
      setState(() {
        _quote = quote;
        _lastFetchTime = DateTime.now();
      });
      prefs.setInt('lastFetchTime', _lastFetchTime.millisecondsSinceEpoch);
    } else {
      setState(() {
        _quote = prefs.getString('quote') ?? 'No quotes found.';
      });
    }
  }

  Future<String> _fetchQuote() async {
    final quotes = await rootBundle.loadString('assets/quotes.txt');
    final quotesList =
        quotes.split('\n').where((line) => line.trim().isNotEmpty).toList();
    final randomIndex = Random().nextInt(quotesList.length);
    final String quote = quotesList[randomIndex];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('quote', quote);
    return quote;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 105, 102, 102).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _quote,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
