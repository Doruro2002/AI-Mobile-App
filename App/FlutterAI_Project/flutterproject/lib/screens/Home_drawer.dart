import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;
  final AnimationController iconAnimationController;

  const HomeDrawer({
    Key? key,
    required this.screenIndex,
    required this.callBackIndex,
    required this.iconAnimationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("John Doe"),
            accountEmail: Text("john.doe@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/userImage.png'),
            ),
            decoration: BoxDecoration(color: Color(0xFF0F1F45)),
          ),
          buildDrawerItem(
            context,
            DrawerIndex.HOME,
            "Home",
            Icons.home,
          ),
          buildDrawerItem(
            context,
            DrawerIndex.ANN,
            "ANN",
            Icons.star, // Remplacez par une icône appropriée
          ),
          buildDrawerItem(
            context,
            DrawerIndex.CNN,
            "CNN",
            Icons.grid_view,
          ),
          buildDrawerItem(
            context,
            DrawerIndex.About,
            "About Us",
            Icons.info,
          ),
          const Divider(),
          buildDrawerItem(
            context,
            DrawerIndex.Logout,
            "Logout",
            Icons.logout,
          ),
        ],
      ),
    );
  }

  Widget buildDrawerItem(
    BuildContext context,
    DrawerIndex index,
    String title,
    IconData icon,
  ) {
    return ListTile(
      selected: screenIndex == index,
      leading: Icon(icon, color: Color(0xFF0F1F45)),
      title: Text(title),
      onTap: () => callBackIndex(index),
    );
  }
}

enum DrawerIndex {
  HOME,
  ANN,
  CNN,
  About,
  Logout,
}
