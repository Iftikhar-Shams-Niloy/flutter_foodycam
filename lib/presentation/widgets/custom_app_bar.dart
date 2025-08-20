import 'package:flutter/material.dart';
import '../../core/constants.dart';

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
        padding: const EdgeInsets.all(5),
        child: Image.asset('assets/foodycam_logo.png', fit: BoxFit.contain),
      ),
      title: const Text(
        "FoodyCam",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: customPurple,
        ),
      ),
      backgroundColor: Colors.indigo.shade100,
      scrolledUnderElevation: 20,
      centerTitle: true,
      elevation: 20,
    );
  }
}
