import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class MoreInfo extends StatelessWidget {
  const MoreInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch argument value
    final arguments =
        (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>) ??
            {};

    // Extract the weatherData from arguments
    final Weather? weatherData = arguments['weatherData'];

    // Create a list of widgets with weather information
    List<Widget> weatherInfoWidgets = [
      _buildInfo(
        'Sunrise',
        weatherData?.sunrise != null
            ? DateFormat('h:mm a').format(weatherData!.sunrise!)
            : 'N/A',
      ),
      _buildInfo(
        'Sunset',
        weatherData?.sunset != null
            ? DateFormat('h:mm a').format(weatherData!.sunset!)
            : 'N/A',
      ),
      _buildInfo('Latitude', weatherData?.latitude.toString() ?? 'N/A'),
      _buildInfo('Longitude', weatherData?.longitude.toString() ?? 'N/A'),
      _buildInfo('Country', weatherData?.country ?? 'N/A'),
      _buildInfo('Feels like', weatherData?.tempFeelsLike.toString() ?? 'N/A'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: ListView.builder(
        itemCount: weatherInfoWidgets.length,
        itemBuilder: (BuildContext context, int index) {
          return weatherInfoWidgets[index];
        },
      ),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

