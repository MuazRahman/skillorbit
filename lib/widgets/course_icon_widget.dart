import 'package:flutter/material.dart';

/// Reusable widget that renders a course icon from a network URL,
/// local asset path, or falls back to a default icon.
///
/// Supports:
///  - Network image URLs (http:// or https://)
///  - Local asset paths (assets/images/xxx.png, etc.)
///  - Empty/null → shows a default school icon
class CourseIconWidget extends StatelessWidget {
  final String iconPath;
  final double size;
  final double iconSize;
  final Color? backgroundColor;
  final Color? defaultIconColor;
  final BorderRadius? borderRadius;

  const CourseIconWidget({
    super.key,
    required this.iconPath,
    this.size = 60,
    this.iconSize = 30,
    this.backgroundColor,
    this.defaultIconColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ??
        Theme.of(context).colorScheme.primary.withOpacity(0.1);
    final iconColor = defaultIconColor ??
        Theme.of(context).colorScheme.primary;
    final defaultIcon = Icon(
      Icons.school,
      color: iconColor,
      size: iconSize,
    );

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: _buildContent(context, defaultIcon),
    );
  }

  Widget _buildContent(BuildContext context, Widget defaultIcon) {
    if (iconPath.isEmpty) {
      return Center(child: defaultIcon);
    }

    // Network image
    if (iconPath.startsWith('http://') || iconPath.startsWith('https://')) {
      return Image.network(
        iconPath,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Center(child: defaultIcon),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: SizedBox(
              width: iconSize * 0.6,
              height: iconSize * 0.6,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      );
    }

    // Local asset — fallback to default icon on error
    return Padding(
      padding: EdgeInsets.all(size * 0.15),
      child: Image.asset(
        iconPath,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => defaultIcon,
      ),
    );
  }
}
