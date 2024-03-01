import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/screens/more_info.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WeatherFactory _wf = WeatherFactory(apiKey);
  final TextEditingController _searchController = TextEditingController();
  String cityName = 'Kathmandu';

  Weather? _weather;

  @override
  void initState() {
    super.initState();
    // fetch data and store to _weather
    _updateWeather();
  }

  void _updateWeather() {
    _wf.currentWeatherByCityName(cityName).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.blueAccent),
      );
    }
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
            _searchBar(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
            _locationHeader(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
            _weatherIcon(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
            _currentTemp(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            _dateTimeInfo(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
            _extraInfo(),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.80,
      child: TextField(
        controller: _searchController,
        // search input
        onEditingComplete: () {
          setState(() {
            cityName = _searchController.text;
            _updateWeather();
          });
        },
        // hide keyboard if tapped outside the search bar
        onTapOutside: (value) {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
              borderRadius: BorderRadius.circular(100),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.blueAccent, width: 1.3),
              borderRadius: BorderRadius.circular(100),
            ),
            label: const Text(
              'What city?',
            ),
            labelStyle: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 13)),
      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE,").format(now),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            Text(
              "  ${DateFormat("d/M/y").format(now)}",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.17,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png')),
          ),
        ),
        Text(
          _weather?.weatherDescription?.toUpperCase() ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      '${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C',
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _extraInfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.20,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Max : ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}°C",
                style: textWithShadow(),
              ),
              Text(
                "Min : ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}°C",
                style: textWithShadow(),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Wind : ${_weather?.windSpeed}m/s",
                style: textWithShadow(),
              ),
              Text(
                "Humidity : ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: textWithShadow(),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black54),
            onPressed: () => Navigator.pushNamed(context, '/more'),
            child: Text('More'),
          ),
        ],
      ),
    );
  }

  TextStyle textWithShadow() {
    return const TextStyle(shadows: <Shadow>[
      Shadow(color: Colors.black54, offset: Offset(3, 3), blurRadius: 3)
    ], fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14);
  }
}
