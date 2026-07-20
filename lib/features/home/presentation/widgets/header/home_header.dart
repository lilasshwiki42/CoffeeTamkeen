import 'package:flutter/material.dart';
import 'package:lilas_tamkeen_project/core/color/app_colors.dart';
import 'package:lilas_tamkeen_project/features/home/presentation/widgets/header/point_badge.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 24,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Best Coffee For You',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          PointsBadge(points: 256),
        ],
      ),
    );
  }
}
