import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_weaher_app/controller-provider.dart';
import 'package:simple_weaher_app/modules/weather.dart';
import 'package:simple_weaher_app/pages/home_page.dart';
import 'package:toast/toast.dart';

import '../controller/apis.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isLoaded = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Search a City'),
      ),
      body: isLoaded == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: cityController,
                /*onSaved: (newValue)  {
          },*/
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(5.0)),
                  hintText: 'enter the city',
                  label: const Text('search'),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      setState(() {
                        isLoaded = true;
                      });
                      var pro = context.read<Controller>();
                      cityController.text == ''
                          ? null
                          : pro.updateCity(cityController.text);
                      try {
                        await pro.getWeather(context.read<Controller>().city);
                      } catch (error) {
                        print(error);
                      }
                      Navigator.pop(context);
                      setState(() {
                        isLoaded = false;
                      });
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
    );
  }
}
