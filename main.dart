import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MyApp());

class Earthquake {
  late String date;
  late String details;
  late String location;
  late double magnitude;
  late String link;

  Earthquake({
    required this.date,
    required this.details,
    required this.location,
    required this.magnitude,
    required this.link,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Earthquake App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home:  HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Earthquake> earthquakes = [
    Earthquake(
      date: '2023-06-10',
      details: 'Magnitude 3.3 ',
      location: 'Karachi',
      magnitude: 5.2,
      link: 'https://earthquake.usgs.gov/earthquakes/map/',
    ),
    Earthquake(
      date: '2023-06-09',
      details: 'Magnitude 6.4 ',
      location: 'Paradise',
      magnitude: 4.7,
      link: 'https://earthquake.usgs.gov/earthquakes/map/',
    ),
    Earthquake(
      date: '2023-06-08',
      details: 'Magnitude 4.6',
      location: 'Texas',
      magnitude: 3.9,
      link: 'https://earthquake.usgs.gov/earthquakes/map/',
    ),
  ];

   HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earthquake App'),
      ),
      body: ListView.builder(
        itemCount: earthquakes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(earthquakes[index].location),
            subtitle: Text(earthquakes[index].date),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(earthquake: earthquakes[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final Earthquake earthquake;

  const DetailsPage({Key? key, required this.earthquake}) : super(key: key);

  _launchURL() async {
    if (await canLaunch(earthquake.link)) {
      await launch(earthquake.link);
    } else {
      throw 'Could not launch ${earthquake.link}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earthquake Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${earthquake.date}'),
            const SizedBox(height: 8.0),
            Text('Details: ${earthquake.details}'),
            const SizedBox(height: 8.0),
            Text('Location: ${earthquake.location}'),
            const SizedBox(height: 8.0),
            Text('Magnitude: ${earthquake.magnitude.toStringAsFixed(1)}'),
            const SizedBox(height: 8.0),
            GestureDetector(
              onTap: _launchURL,
              child: Text(
                'Link: ${earthquake.link}',
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
