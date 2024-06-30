import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/manager/color_manager.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? type;
  final String imageName;
  final double? height;
  final double? width;
  final BoxShape? shape;
  final double? borderRadius;
  final bool? hideBorder;
  final Widget? child;
  final BoxFit? boxFit;
  const CustomNetworkImage(
      {super.key,
      this.type,
      required this.imageName,
      this.height,
      this.width,
      this.shape,
      this.borderRadius,
      this.child,
      this.hideBorder,
      this.boxFit});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageName,
      fit: BoxFit.contain,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BoxShape.circle == shape
                  ? null
                  : BorderRadius.circular(borderRadius ?? 9),
              shape: shape ?? BoxShape.rectangle,
              border: Border.all(
                color: hideBorder ?? false
                    ? Colors.transparent
                    : appColors.brandDark,
              ),
              image: DecorationImage(
                  image: imageProvider, fit: boxFit ?? BoxFit.cover)),
          child: child,
        );
      },
      placeholder: (context, url) => Container(
          height: height, width: width, color: Colors.grey.withOpacity(0.2)),
      errorWidget: (context, url, error) => Stack(
        children: [
          Center(
              child: Icon(
            Icons.error_outline_outlined,
            size: 30,
            color: Colors.red.withOpacity(0.8),
          )),
          Center(
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: appColors.brandDark,
                ),
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BoxShape.circle == shape
                    ? null
                    : BorderRadius.circular(borderRadius ?? 9),
                shape: shape ?? BoxShape.rectangle,
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
