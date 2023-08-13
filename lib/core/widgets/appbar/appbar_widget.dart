import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:clean_architecture_posts_app/core/widgets/appbar/background_wave_clipper.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      flexibleSpace: ClipPath(
        clipper: BackgroundWaveClipper(),
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryColor,
                 primaryColor,
                // primaryColor,
                secondaryColor
              ],
            ),
          ),
          child: Center(
              child: Text(
            title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          )),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
