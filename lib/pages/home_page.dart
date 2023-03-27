import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:simple_weaher_app/controller-provider.dart';
import 'package:simple_weaher_app/controller/apis.dart';
import 'package:simple_weaher_app/modules/weather.dart';
import 'package:simple_weaher_app/pages/search_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  // String city = 'cairo';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController cityController = TextEditingController();
  String? _currentAddress;
  Position? _currentPosition;

  @override
  Widget build(BuildContext context) {
    var pro = context.watch<Controller>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Weather'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
              print(_currentPosition);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: _getCurrentPosition,
            icon: const Icon(
              Icons.location_on_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: pro.weather == null
          ? RefreshIndicator(
              onRefresh: () => onRefresh(),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 350.0),
                  child: const Text(
                    textAlign: TextAlign.center,
                    'There are no Weather 😢 start \n searching Now 🔍 ',
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
              ),
            )
          : RefreshIndicator(
              onRefresh: () => onRefresh(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      // height: size.height*.66,
                      width: size.width * 0.95,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50.0),
                            bottomRight: Radius.circular(50.0),
                          ),
                          gradient: LinearGradient(
                              colors: [
                                Colors.purpleAccent,
                                Colors.lightBlue,
                              ],
                              stops: [
                                0.1,
                                0.8
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                pro.weather!.location.name,
                                style: const TextStyle(
                                    fontSize: 30.0, color: Colors.white),
                              ),
                              const Icon(Icons.location_on_outlined),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    TimeOfDay(
                                            hour: int.parse(pro
                                                .weather!.location.localtime
                                                .split(' ')[1]
                                                .split(':')[0]),
                                            minute: int.parse(pro
                                                .weather!.location.localtime
                                                .split(' ')[1]
                                                .split(':')[1]))
                                        .format(context),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15.0),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height / 40.0,
                          ),
                          Text(
                            pro.weather!.location.localtime.split(' ')[0],
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          SizedBox(
                            height: size.height / 40.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // const SizedBox(width: 50.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${pro.weather!.current.tempC.ceil()}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.3),
                                  ),
                                  Row(
                                    children: const [
                                      Text('o',
                                          style: TextStyle(
                                            color: Colors.white,
                                          )),
                                      Text(
                                        'c',
                                        style: TextStyle(
                                          fontSize: 50.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Image.network(
                                'https:${pro.weather!.current.condition.icon}',
                                scale: 0.4,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Text(
                            pro.weather!.current.condition.text,
                            style:
                                const TextStyle(color: Colors.white, fontSize: 35.0),
                          ),
                          SizedBox(
                            height: size.height / 40.0,
                          ),
                          const Text(
                            'feels like',
                            style:
                                TextStyle(color: Colors.white, fontSize: 35.0),
                          ),
                          Text(
                            '${pro.weather!.current.feelslikeC.floor()} ℃',
                            style:
                                const TextStyle(color: Colors.white, fontSize: 35.0),
                          ),
                          SizedBox(
                            height: size.height / 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/wind.png',
                                      width: size.width / 5,
                                    ),
                                    SizedBox(
                                      height: size.height / 60.0,
                                    ),
                                    Text(
                                      '${pro.weather!.current.windKph} Km/h',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: size.height / 60.0,
                                    ),
                                    const Text(
                                      'Wind',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                        "assets/images/wind diriction.png",
                                        width: size.width / 5),
                                    SizedBox(
                                      height: size.height / 60.0,
                                    ),
                                    Text(
                                      '${pro.weather!.current.windDir} ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: size.height / 60.0,
                                    ),
                                    const Text(
                                      "Wind Direction",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/cloud.png',
                                        width: size.width / 5),
                                    SizedBox(
                                      height: size.height / 60.0,
                                    ),
                                    Text(
                                      '${pro.weather!.current.humidity} Km/h',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: size.height / 60.0,
                                    ),
                                    const Text(
                                      'Humidity',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 50.0,
                      ),
                      margin: const EdgeInsets.only(
                          right: 8.0, left: 8.0, top: 30.0),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            topLeft: Radius.circular(50.0),
                          ),
                          gradient: LinearGradient(
                              colors: [
                                Colors.purpleAccent,
                                Colors.lightBlue,
                              ],
                              stops: [
                                0.1,
                                0.8
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Gust',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 15.0),
                              ),
                              SizedBox(
                                height: size.height / 70,
                              ),
                              Text(
                                '${pro.weather!.current.gustKph} Kp/h',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              SizedBox(
                                height: size.height / 60,
                              ),
                              const Text(
                                'Pressure',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                              SizedBox(
                                height: size.height / 70,
                              ),
                              Text(
                                '${pro.weather!.current.pressureMb} hpa',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'UV',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 15.0),
                              ),
                              SizedBox(
                                height: size.height / 70,
                              ),
                              Text(
                                '${pro.weather!.current.uv}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              SizedBox(
                                height: size.height / 60,
                              ),
                              const Text(
                                'precipitation',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                              SizedBox(
                                height: size.height / 70,
                              ),
                              Text(
                                '${pro.weather!.current.precipMm} mm',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'wind degree',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 15.0),
                              ),
                              SizedBox(
                                height: size.height / 70,
                              ),
                              Text(
                                '${pro.weather!.current.windDegree}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              SizedBox(
                                height: size.height / 60,
                              ),
                              const Text(
                                'Last update',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                              SizedBox(
                                height: size.height / 70,
                              ),
                              Text(
                                '${pro.weather!.current.lastUpdated.split(' ')[0]}\n \t\t\t${pro.weather!.current.lastUpdated.split(' ')[1]}',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      elevation: 0.0,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 50.0),
          child: TextFormField(
            controller: cityController,
            onSaved: (newValue) {},
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(5.0)),
              // labelText:'enter the city',
              hintText: 'enter the city',
              label: const Text('search'),
              suffixIcon: IconButton(
                onPressed: () async {},
                icon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onRefresh() async {
    await Provider.of<Controller>(context, listen: false)
        .getWeather(context.read<Controller>().city);
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
    print(_currentPosition);
    await Provider.of<Controller>(context, listen: false).getWeather(
        '${_currentPosition!.latitude},${_currentPosition!.longitude}');
  }
}
