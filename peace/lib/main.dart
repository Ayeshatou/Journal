import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(const MindfulnessApp());

class MindfulnessApp extends StatelessWidget {
  const MindfulnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mindfulness & Stress Reduction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindfulness & Stress Reduction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Mindfulness Exercise'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MindfulnessScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Daily Affirmation'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AffirmationScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text('Mood Tracker'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MoodTrackerScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MindfulnessScreen extends StatefulWidget {
  const MindfulnessScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MindfulnessScreenState createState() => _MindfulnessScreenState();
}

class _MindfulnessScreenState extends State<MindfulnessScreen> {
  int _counter = 5;
  Timer? _timer;

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _counter = 5; // Reset the counter
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer!.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindfulness Breathing Exercise'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Breathe in... Breathe out',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              '$_counter seconds left',
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startTimer,
              child: const Text('Start Breathing Exercise'),
            ),
          ],
        ),
      ),
    );
  }
}

class AffirmationScreen extends StatelessWidget {
  const AffirmationScreen({super.key});

  static const List<String> affirmations = [
    "I am strong.",
    "I am capable of handling anything that comes my way.",
    "I choose peace.",
    "I believe in myself.",
    "I am worthy of love and happiness.",
  ];

  String getRandomAffirmation() {
    final List<String> shuffled = List.from(affirmations);
    shuffled.shuffle();
    return shuffled.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Affirmation'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getRandomAffirmation(),
                style: const TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MoodTrackerScreenState createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  String _currentMood = 'Neutral';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'How are you feeling today?',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          DropdownButton<String>(
            value: _currentMood,
            onChanged: (String? newValue) {
              setState(() {
                _currentMood = newValue!;
              });
            },
            items: const <String>['Happy', 'Sad', 'Angry', 'Neutral', 'Anxious']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final snackBar = SnackBar(content: Text('Mood saved: $_currentMood'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text('Save Mood'),
          ),
        ],
      ),
    );
  }
}
