import 'package:energyeffix_app/src/LoadingPage.dart';
import 'package:energyeffix_app/src/SignIn.dart';
import 'package:energyeffix_app/src/current_user.dart';
import 'package:energyeffix_app/src/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  final CurrentUser _currentUser = Get.put(CurrentUser());

  signOutUser() async {
    var resultResponse = await Get.dialog(AlertDialog(
      backgroundColor: Colors.grey,
      title: const Text(
        "Logout",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue, // Change title text color
        ),
      ),
      content: const Text(
        "Are you sure?\n you want to logout from app?",
        style: TextStyle(color: Colors.green), // Change content text color
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "No",
              style: TextStyle(
                color: Colors.red, // Change button text color
                decoration: TextDecoration.none, // Remove underline
              ),
            )),
        TextButton(
            onPressed: () {
              Get.back(result: "LoggedOut");
            },
            child: const Text(
              "Yes",
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.none, // Remove underline
              ),
            ))
      ],
    ));

    if (resultResponse == "LoggedOut") {
      RememberUserPrefs.removeUserInfo().then((value) {
        Get.off(SignInPage());
      });
    }
  }

  Widget userInfoItemProfile(IconData iconData, String userData) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue, // Change container background color
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 30,
            color: Colors.white, // Change icon color
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            userData,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white, // Change text color
              decoration: TextDecoration.none, // Remove underline
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff1D1E33), // Set background color to blue
      child: ListView(
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/man.png",
                  width: 240,
                ),
                const SizedBox(height: 20),
                if (_currentUser.user != null) ...[
                  Text(
                    "Username: ${_currentUser.user.usersUId}",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(
                            255, 255, 255, 255)), // Change text color
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),
          userInfoItemProfile(
              Icons.person,
              _currentUser.user.usersFName +
                      " " +
                      _currentUser.user.usersLName ??
                  ""),
          const SizedBox(height: 20),
          userInfoItemProfile(Icons.email, _currentUser.user?.usersEmail ?? ""),
          const SizedBox(height: 20),
          Center(
            child: Material(
              color: Color.fromARGB(255, 255, 0, 0),
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: () {
                  SignInPage();
                },
                borderRadius: BorderRadius.circular(32),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  child: const Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      decoration: TextDecoration.none, // Remove underline
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
