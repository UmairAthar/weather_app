import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  String country = '';
  String location = '';
  String temp = '';
  String tempf = '';
  String humidity = '';
  String wind = '';
  String key = "ead455335b3649849e4112335232108";

  Future getWeather() async {
    // use try catch block for any exception
    try {
      var response = await Dio().get(
          'https://api.weatherapi.com/v1/current.json?key=ead455335b3649849e4112335232108&q=$location&aqi=yes');
      Map<String, dynamic> data = jsonDecode(response.toString());
      // jsonDecode convert data into string for  further use by using MAP property

      setState(() {
        // country and city  name that print in App Bar
        country = data['location']['country'].toString();
        location = data['location']['name'].toString();
        // to be so sure it should be as string type
        temp = data['current']['temp_c'].toStringAsFixed(0);
        // temperature in far
        tempf = data['current']['temp_f'].toString();
        humidity = data['current']['humidity'].toString();
        wind = data['current']['wind_kph'].toString();
      });
    } on Exception catch (e) {
      print(e.toString().toUpperCase());
    }
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF2C0258), Color(0xFF00021B)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              children: [
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 3.5.h,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                   location != ""? FittedBox(
                    fit: BoxFit.fill,
                     child: Text(
                        '$location, $country',
                        style: GoogleFonts.playfairDisplay(
                            color: Colors.white, fontSize: 20.sp),
                      ),
                   ):const SizedBox(),
                    const Spacer(),
                    Icon(
                      Icons.menu,
                      color: Colors.purple,
                      size: 3.5.h,
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  height: 5.2.h,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(color: Colors.grey, width: 0.5)),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: GoogleFonts.montserrat(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                      contentPadding:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 15),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: InkWell(
                          onTap: () {
                             setState(() {
                                location = controller.text;
                              });
                              getWeather();
                          },
                          child: Image.asset(
                            "assets/icons/search2.png",
                            width: 5.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Image.asset(
                  'assets/icons/day.png',
                  height: 15.h,
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        temp.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 32.sp),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '°C',
                        style: TextStyle(
                          fontSize: 25.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/thermometer.png',
                      height: 4.h,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    const Spacer(),
                    Text(
                      '$tempf F',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/humidity.png',
                      height: 4.h,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    const Spacer(),
                    Text(
                      "$humidity %",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/wind.png',
                      height: 4.h,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    Spacer(),
                    Text(
                      "$wind Kph",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
