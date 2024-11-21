import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import '/core/theme/app_color.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        );
      },
      placeholder: (context, url) => Shimmer(
        gradient: const LinearGradient(
          colors: [
            AppColors.greyColor,
            AppColors.whiteColor,
          ],
        ),
        child: Container(
          color: AppColors.greyColor,
        ),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        color: AppColors.dangerColor,
        size: 10.h,
      ),
    );
  }
}
