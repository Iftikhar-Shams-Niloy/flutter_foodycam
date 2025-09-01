import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          'assets/foodycam_logo_round.png',
          fit: BoxFit.contain,
        ),
      ),
      title: const Text(
        "FoodyCam",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      scrolledUnderElevation: 20,
      centerTitle: true,
      elevation: 20,
    );
  }
}
