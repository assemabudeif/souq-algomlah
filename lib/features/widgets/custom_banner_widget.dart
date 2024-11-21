import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '/core/global/widgets/custom_network_image.dart';
import '/core/theme/app_color.dart';

class CustomBannerWidget extends StatelessWidget {
  const CustomBannerWidget({
    super.key,
    required this.images,
    this.height,
    this.autoPlay = true,
    this.enableInfiniteScroll = true,
    this.fit,
    this.padding,
    this.isNetworkImage = false,
  });
  final List<String> images;
  final double? height;
  final BoxFit? fit;
  final bool autoPlay;
  final bool enableInfiniteScroll;
  final EdgeInsetsDirectional? padding;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        ...images.map(
          (image) => Container(
            width: 100.w,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.whiteColor,
            ),
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            child: isNetworkImage
                ? CustomNetworkImage(
                    imageUrl: image,
                    fit: fit ?? BoxFit.fitWidth,
                  )
                : Image.asset(
                    image,
                    fit: fit ?? BoxFit.fitWidth,
                    width: 100.w,
                  ),
          ),
        ),
      ],
      options: CarouselOptions(
        height: height ?? 13.5.h,
        aspectRatio: MediaQuery.of(context).size.aspectRatio,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: enableInfiniteScroll,
        reverse: false,
        autoPlay: autoPlay,
        autoPlayInterval: const Duration(seconds: 10),
        autoPlayAnimationDuration: const Duration(seconds: 2),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
