import 'package:flutter/material.dart';
import 'package:simple_weaher_app/modules/weather.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key, required this.weather}) : super(key: key);
final Weather weather;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: const [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.search,
          //     color: Colors.white,
          //   ),
          // ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              weather.location.name,
              style: const TextStyle(fontSize: 25.0),
            ),
            Image.network('https:${weather.current.condition.icon}'),
          ],
        ),
      ),
    );
  }
}
