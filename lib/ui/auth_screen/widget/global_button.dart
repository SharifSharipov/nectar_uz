import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../utils/app_colors.dart';

class GlobalButton extends StatelessWidget {
  const GlobalButton({Key? key, required this.title, required this.onTap, required this.color})
      : super(key: key);

  final String title;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          color:  color,
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.c_ffffff,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Gilroy',
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ),
    );
  }
}
