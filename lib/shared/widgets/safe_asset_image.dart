import 'package:flutter/material.dart';

/// Image.asset that shows [fallback] instead of crashing if the asset is missing.
class SafeAssetImage extends StatelessWidget {
  const SafeAssetImage({
    super.key,
    required this.path,
    required this.fallback,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final String path;
  final Widget fallback;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}
