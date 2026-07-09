import 'package:flutter/material.dart';

import '../utils/theme/app_colors.dart';

/// Иконка с декоративными "облаками" на фоне — общий визуальный элемент
/// для [NetworkErrorView] и [EmptyStateView].
class DecoratedStateIcon extends StatelessWidget {
  final IconData icon;
  final IconData? badgeIcon;
  final Color? badgeColor;

  const DecoratedStateIcon({
    super.key,
    required this.icon,
    this.badgeIcon,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 90,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            top: 10,
            child: Icon(
              Icons.cloud,
              size: 34,
              color: AppColor.primary.withValues(alpha: 0.12),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Icon(
              Icons.cloud,
              size: 26,
              color: AppColor.primary.withValues(alpha: 0.12),
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColor.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30, color: AppColor.primary),
          ),
          if (badgeIcon != null)
            Positioned(
              right: 22,
              bottom: 16,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: badgeColor ?? AppColor.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(badgeIcon, size: 10, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
