import 'package:dio/dio.dart' as dio;
import 'package:energyeffix_app/Devices.dart';
import 'package:energyeffix_app/ManualEntry.dart';
import 'package:energyeffix_app/home.dart';
import 'package:energyeffix_app/src/current_user.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:energyeffix_app/Components/CustomAppBar.dart';
import 'package:energyeffix_app/Components/CustomDrawer.dart';
import 'package:get/get.dart';
import 'CustomGoal.dart';
import 'LeaderBoard.dart';
import 'goal.dart';
import 'package:lottie/lottie.dart';

class GreetingWidget extends StatelessWidget {
  final CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  Widget build(BuildContext context) {
    String greeting = _getGreeting();
    String userName =
        _currentUser.user.usersFName; // Replace with the user's name
    //String assetName = _getLottieAssetName(); // Get Lottie animation asset based on time

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      color: Color.fromARGB(47, 100, 178, 255),
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi $userName",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Good $greeting",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Lottie.asset(
          //   _getLottieAssetName(),
          //   width: 60,
          //   height: 60,
          //   fit: BoxFit.cover,
          // ),
        ],
      ),
    );
  }

  String _getGreeting() {
    var now = DateTime.now();
    var hour = now.hour;

    if (hour < 12) {
      return "Morning";
    } else if (hour < 18) {
      return "Afternoon";
    } else {
      return "Evening";
    }
  }

  // String _getLottieAssetName() {
  //   var now = DateTime.now();
  //   var hour = now.hour;

  //   if (hour < 12) {
  //     return 'assets/images/Greet1.json';
  //   } else if (hour < 18) {
  //     return 'assets/images/Greet1.json';
  //   } else {
  //     return 'assets/images/Greet1.json';
  //   }
  // }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());

  int month = DateTime.now().month;
  int year = DateTime.now().year;
  int units = 0;

  Future<void> fetchData() async {
    final apiUrl =
        "https://2c82-34-145-35-67.ngrok-free.app/predict/"; // Replace with your API URL
    final dio.Dio dioClient = dio.Dio();

    try {
      dio.Response response = await dioClient.post(apiUrl, data: {
        "input_value":
            ((DateTime.now().month * 30 - ((DateTime.now().month - 1) * 30)))
      });
      final responseData = response.data;
      setState(() {
        units = responseData;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: Color(0xFF1D1E33),
          appBar: CustomAppBar(
              appBar: AppBar(
                toolbarHeight: 120,
              ),
              title: "Home"),
          drawer: CustomDrawer(),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GreetingWidget(), // Adding the GreetingWidget here
                  Container(
                    //color: const Color.fromARGB(28, 33, 149, 243),
                    child: Column(
                      children: [
                        buildButtonRow(context, [
                          buildButton(
                            context,
                            'Add Device',
                            Devices(),
                          ),
                          buildButton(
                            context,
                            'Manual Input',
                            ManualEntry(),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(49, 54, 152, 244),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Prediction for your month',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.energy_savings_leaf_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              '$month $year',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          '$units',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Energy Usage for Month',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  //CarouselSlider
                  Container(
                    height: 200,
                    color: Colors.transparent,
                    child: CarouselSlider(
                      items: [
                        Image.asset('assets/images/1.jpg'),
                        Image.asset('assets/images/2.jpg'),
                        Image.asset('assets/images/3.jpg'),
                        Image.asset('assets/images/4.jpg'),
                        Image.asset('assets/images/5.jpg'),
                      ],
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                    ),
                  ),

                  // 4 Buttons

                  // Horizontally scrollable row of daily challenge cards
                  Container(
                    height: 250, // Adjust height
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        buildDailyChallengeCard(
                            context, 'Daily Challenge 1', 100),
                        buildDailyChallengeCard(
                            context, 'Daily Challenge 2', 200),
                        buildDailyChallengeCard(
                            context, 'Daily Challenge 3', 500),
                        buildDailyChallengeCard(
                            context, 'Daily Challenge HEHE', 1000),
                        buildDailyChallengeCard(
                            context, 'Daily Challenge yoyo', 7800),
                        buildDailyChallengeCard(
                            context, 'Daily Challenge 6', 1600),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomGoal()),
              );
            },
            icon: Icon(Icons.add, color: Colors.white),
            label: Text('Create a Customized Goal',
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget buildButtonRow(BuildContext context, List<Widget> buttons) {
    return Wrap(
      spacing: MediaQuery.of(context).size.width * 0.1,
      runSpacing: 1,
      children: buttons,
    );
  }

  Widget buildButton(BuildContext context, String text, Widget page) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 10.0),
          minimumSize: Size(MediaQuery.of(context).size.width * 0.5, 0),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildDailyChallengeCard(
      BuildContext context,
      //String imagePath,
      String title,
      int points) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: MediaQuery.of(context).size.width * 0.6, // Adjust card width
      decoration: BoxDecoration(
        color: Color.fromARGB(76, 31, 31, 32),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image of the goal
          // Image.asset(
          //   imagePath,
          //   height: 100,
          //   width: 100, // Adjust image height
          // ),
          SizedBox(height: 10),
          // Title of the goal
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          // Points received
          Text(
            'Points: $points',
            style: TextStyle(color: const Color.fromARGB(255, 199, 199, 199)),
          ),
          SizedBox(height: 10),
          // View more button
          ElevatedButton(
            onPressed: () {
              // Implement functionality to view more details
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
            ),
            child: Text('View More'),
          ),
        ],
      ),
    );
  }
}

class MyRewardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Rewards'),
      ),
      body: Center(
        child: Text('My Rewards Page'),
      ),
    );
  }
}

class EnergySavingTipsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Energy Saving Tips'),
      ),
      body: Center(
        child: Text('Energy Saving Tips Page'),
      ),
    );
  }
}

class ViewMyBadgesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View My Badges'),
      ),
      body: Center(
        child: Text('View My Badges Page'),
      ),
    );
  }
}
