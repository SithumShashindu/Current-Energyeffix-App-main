import 'package:energyeffix_app/Components/MyDrawer.dart';
import 'package:energyeffix_app/About.dart';
import 'package:energyeffix_app/Goal.dart';
import 'package:energyeffix_app/Help.dart';
import 'package:energyeffix_app/Profile.dart';
import 'package:energyeffix_app/SettingsPage.dart';
import 'package:energyeffix_app/src/api_connection.dart';
import 'package:energyeffix_app/src/current_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:energyeffix_app/src/RegisterPage.dart';
import 'package:get/get.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

import 'package:energyeffix_app/src/LoadingPage.dart';
import 'package:energyeffix_app/src/RegisterPage.dart';
import 'package:energyeffix_app/src/Register_SignIn.dart';
import 'package:energyeffix_app/src/SignIn.dart';
import 'package:energyeffix_app/Home.dart';
import 'package:energyeffix_app/LeaderBoard.dart';

import 'package:flutter/material.dart';
import 'GetStarted.dart';
import 'ManualEntry.dart';
import 'custom_app_bar.dart'; // Import the custom app bar
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'CustomGoal.dart';
import 'About.dart';
import 'Analytics.dart';
import 'Bill.dart';
import 'Devices.dart';

void main() {
  runApp(EnergyEffixApp());
}

class EnergyEffixApp extends StatelessWidget {
  final CurrentUser _currentUser = Get.put(CurrentUser());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EnergyEffix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingPage(),
        '/register_signin': (context) => RegisterSignInPage(),
        '/sign_in': (context) => SignInPage(),
        '/home': (context) => Home(),

        '/register': (context) =>
            RegisterPage(), // Define the route for Register.dart

        //'/goal_test': (context) => GoalTest(),

        '/analytics': (context) => MyHomePage(),
        '/bill': (context) => Bill(
              month: 'March',
              unitsUsed: 100,
              usageAmount: 800,
              totalAmount: 1000,
            ),
        '/goal': (context) => Goal(),

        '/customgoal': (context) => CustomGoal(),

        '/leaderboard': (context) => LeaderboardPage(),
        '/device': (context) => Devices(),

        '/getStarted': (context) =>
            GetStartedScreen(), // Route for GetStartedScreen

        '/manualentry': (context) => ManualEntry(),

        '/mydrawer': (context) => MyDrawer(
              userName: _currentUser.user.usersUId,
              userId: _currentUser.user.usersFName,
              points: 2000,
            ),

        '/about': (context) => About(),
        '/settings': (context) => SettingsPage(),
        '/Help': (context) => Help(),

        '/profile': (context) => Profile(),

        // '/notification': (context) => Notification,

//     navigatorObservers: [RouteObserverProvider()],
//     home: MyNavBar(),
//   ));
// }
      },

//: [RouteObserverProvider(child: MaterialApp()).routeObserver],

      onGenerateRoute: (settings) {
        if (settings.name == '/devices') {
          return MaterialPageRoute(
            builder: (context) => DevicesScreen(),
          );
        }
      },

      onUnknownRoute: (settings) {
        // Handle unknown routes here, maybe navigate to a not found page.
        return MaterialPageRoute(
          builder: (context) => NotFoundScreen(),
        );
      },
    );
  }
}

class DevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Devices'),
      ),
      body: Center(
        child: Text('Devices Screen'),
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1D1E33),
        title: Text('Not Found'),
      ),
      body: Center(
        child: Text('Page Not Found'),
      ),
    );
  }
}
