import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class ImageWidget extends StatelessWidget {
  final String url;
  final String packageName;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;

  const ImageWidget({
    super.key,
    required this.url,
    required this.packageName,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (url == '') return buildPlaceHolderWidget();

    if (url.startsWith("http")) {
      if (url.split('.').last == 'svg') return buildNetworkSvgImage();
      return buildNetworkImage();
    } else if (url.startsWith("assets")) {
      if (url.split('.').last == 'svg') return buildAssetSvgImage();
      return buildImageAsset();
    }

    return buildImageFile();
  }


  Widget buildNetworkImage() {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) => buildPlaceHolderWidget(),
      errorBuilder: (context, url, error) {
        debugPrint('CachedNetworkImage: $error');
        return buildErrorWidget();
      },
    );
  }

  buildErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: Colors.redAccent,
    );
  }

  buildPlaceHolderWidget() {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: .5,
            sigmaY: .5,
          ),
          child: Container(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget buildAssetSvgImage() {
    return SvgPicture.asset(
      url,
      width: width,
      height: height,
      color: color,
      fit: BoxFit.contain,
      package: packageName,
    );
  }

  Widget buildNetworkSvgImage() {
    return SvgPicture.network(
      url,
      width: width,
      height: height,
      color: color,
      fit: BoxFit.contain,
    );
  }

  Widget buildImageAsset() {
    return Image.asset(
      url,
      fit: fit,
      height: height,
      width: width,
      package: packageName,
    );
  }

  Widget buildImageFile() {
    return Image.file(
      File(url),
      fit: fit,
      height: height,
      width: width,
    );
  }
}
