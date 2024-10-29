import 'package:energyeffix_app/src/current_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  final CurrentUser _currentUser = Get.put(CurrentUser());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color:
            Color.fromARGB(255, 51, 29, 47), // Set background color of Drawer
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromARGB(
                  255, 35, 51, 29), // Set background color of SliverAppBar
              expandedHeight: 180.0,
              collapsedHeight: 120.0,
              flexibleSpace: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff0071aa),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/profile');
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'assets/images/man.png',
                        ),
                        radius: 40,
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentUser.user.usersUId,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              _currentUser.user.usersFName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                            SizedBox(
                                width: 10), // Add some space between the texts
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _customListTile(
                      iconData: Icons.home,
                      title: 'Home',
                      routeName: '/home',
                      context: context),
                  _customListTile(
                      iconData: Icons.analytics,
                      title: 'Analytics',
                      routeName: '/analytics',
                      context: context),
                  _customListTile(
                      iconData: Icons.gamepad_outlined,
                      title: 'Goal',
                      routeName: '/goal',
                      context: context),
                  _customListTile(
                      iconData: Icons.edit,
                      title: 'Create Customized Goal',
                      routeName: '/customgoal',
                      context: context),
                  _customListTile(
                      iconData: Icons.calculate,
                      title: 'My Bill',
                      routeName: '/bill',
                      context: context),
                  _customListTile(
                      iconData: Icons.device_hub,
                      title: 'My Devices',
                      routeName: '/device',
                      context: context),
                  _customListTile(
                      iconData: Icons.read_more,
                      title: 'Add Reading Manually',
                      routeName: '/manualentry',
                      context: context),
                  _customListTile(
                      iconData: Icons.add_task_sharp,
                      title: 'Champboard',
                      routeName: '/leaderboard',
                      context: context),
                  _customListTile(
                      iconData: Icons.settings,
                      title: 'Settings',
                      routeName: '/settings',
                      context: context),
                  _customListTile(
                      iconData: Icons.help,
                      title: 'Help',
                      routeName: '/Help',
                      context: context),
                  _customListTile(
                      iconData: Icons.question_answer,
                      title: 'About Us',
                      routeName: '/about',
                      context: context),
                  _customListTile(
                      iconData: Icons.logout,
                      title: 'Log Out',
                      routeName: '/register_signin',
                      context: context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customListTile(
      {required String title,
      required String routeName,
      required BuildContext context,
      required IconData iconData}) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 29, 30, 51),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border(
          top: BorderSide(
            color: Color(0xFF0EC6EC),
            width: 1,
          ),
          bottom: BorderSide(
            color: Color(0xFF0EC6EC),
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(
          iconData,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(routeName);
        },
      ),
    );
  }
}
