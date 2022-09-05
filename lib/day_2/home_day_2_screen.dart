import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medium/day_2/city_model.dart';
import 'package:flutter_medium/day_2/weather_model.dart';

class HomeDay2Screen extends StatefulWidget {
  const HomeDay2Screen({Key? key}) : super(key: key);

  @override
  State<HomeDay2Screen> createState() => _HomeDay2ScreenState();
}

class _HomeDay2ScreenState extends State<HomeDay2Screen> {
  List<CityModel?>? cities = [];
  List<WeatherModel?>? weathers = [];

  CityModel? selectedCity;

  bool isLoading = true;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    // Get Lokasi
    final List<CityModel?>? resultGetCities = await _getCities();

    // Assign Lokasi
    if (resultGetCities != null) {
      cities = resultGetCities;
    }

    // Set Loading false
    isLoading = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cuaca Hari Ini"),
      ),
      body: (isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: DropdownButton<CityModel?>(
                      focusColor: Colors.white,
                      value: selectedCity,
                      //elevation: 5,
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: cities?.map<DropdownMenuItem<CityModel>>(
                          (CityModel? value) {
                        return DropdownMenuItem<CityModel>(
                          value: value,
                          child: Text(
                            value?.kota ?? '',
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      hint: const Text(
                        "Please choose a your city",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (CityModel? value) {
                        // Set SelectedCity
                        setState(() {
                          selectedCity = value;
                        });

                        // Get Weather
                        _onGetWeather();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ...(weathers ?? [])
                      .map(
                        (e) => Text(
                          e?.tempC ?? '',
                          style: const TextStyle(color: Colors.black),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
    );
  }

  void _onGetWeather() async {
    // Show Loading Dialog
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    final List<WeatherModel?>? result = await _getWeather();

    // Close Loading Dialog
    Navigator.pop(context);

    if (result != null) {
      setState(() {
        weathers = result;
      });
    }
  }

  Future<List<CityModel?>?> _getCities() async {
    Dio dio = Dio();

    try {
      final response = await dio
          .get("https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json");

      log(response.data.toString());

      final List results = (response.data is List) ? response.data : [];

      return results.map((e) => CityModel.fromJson(e)).toList();
    } catch (error) {
      throw error;
    }
  }

  Future<List<WeatherModel?>?> _getWeather() async {
    Dio dio = Dio();

    try {
      final response = await dio.get(
          "https://ibnux.github.io/BMKG-importer/cuaca/${selectedCity?.id ?? ''}.json");

      log(response.data.toString());

      final List results = (response.data is List) ? response.data : [];

      return results.map((e) => WeatherModel.fromJson(e)).toList();
    } catch (error) {
      throw error;
    }
  }
}
