import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Title of the AppBar
  final IconData? icon; // Icon for the AppBar
  final Color backgroundColor; // Background color for the AppBar

  // ignore: use_super_parameters
  const CustomAppBar({
    Key? key,
    required this.title,
    this.icon,
    this.backgroundColor = Colors.black12, // Default background color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: true,
      automaticallyImplyLeading: false, // Prevents the default back button
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white), // Customizable icon
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Roboto",
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }

  // Necessary to implement the PreferredSizeWidget interface
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}