import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web_lms/core/export_all.dart';
import 'package:web_lms/core/resource/color_resource.dart';

class RenderImage {
  static Widget getImageStorage({
    Uint8List? path64,
    BoxFit? boxFit,
    double? width,
    double? height,
    BorderRadius? borderRadius,
  }) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: Image.memory(path64!),
    );
  }

  ///TODO: show image .svg
  static Widget getImageSVG(
    String url, {
    double? height,
    double? width,
    double? padL,
    double? padR,
    double? padB,
    double? padT,
    Color? color,
    BoxFit? boxFit,
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? shadowCustom,
    bool isShadow = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(
          left: padL ?? 0, right: padR ?? 0, bottom: padB ?? 0, top: padT ?? 0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(0),
            border: border,
            boxShadow: isShadow
                ? shadowCustom ??
                    [
                      BoxShadow(
                          color: ColorResource.black.withOpacity(
                            0.2,
                          ),
                          blurRadius: 5)
                    ]
                : null),
        child: SvgPicture.asset(
          url,
          fit: boxFit ?? BoxFit.fill,
          color: color,
        ),
      ),
    );
  }

  static Widget imageNetwork(
    String url, {
    double? width,
    double? height,
    double? widthBorder,
    BoxFit? boxFit,
    double? radiusAll,
    Color? colorBorder,
    double? radiusTopRight,
    double? radiusTopLeft,
    double? radiusBotRight,
    double? radiusBotLeft,
    List<BoxShadow>? shadowCustom,
    bool isShadow = false,
  }) {
    radiusAll = radiusAll ?? 0;
    radiusTopRight = radiusTopRight ?? radiusAll;
    radiusTopLeft = radiusTopLeft ?? radiusAll;
    radiusBotRight = radiusBotRight ?? radiusAll;
    radiusBotLeft = radiusBotLeft ?? radiusAll;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          border: Border.all(
            width: widthBorder ?? 0,
            color: colorBorder ?? Colors.transparent,
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(radiusTopRight),
            topLeft: Radius.circular(radiusTopLeft),
            bottomLeft: Radius.circular(radiusBotLeft),
            bottomRight: Radius.circular(radiusBotRight),
          ),
          image: DecorationImage(image: NetworkImage(url)),
          color: colorBorder,
          boxShadow: isShadow
              ? shadowCustom ??
                  [
                    BoxShadow(
                        color: ColorResource.black.withOpacity(
                          0.2,
                        ),
                        blurRadius: 5)
                  ]
              : null),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(radiusTopRight),
          topLeft: Radius.circular(radiusTopLeft),
          bottomLeft: Radius.circular(radiusBotLeft),
          bottomRight: Radius.circular(radiusBotRight),
        ),
        child: Image.network(
          url,
          headers: const {
            "Authorization": "Bearer ${KeyResource.ACCESS_TOKEN}"
          },
          width: width,
          height: height,
          fit: boxFit,
          errorBuilder: (
            BuildContext context,
            Object? exception,
            StackTrace? stackTrace,
          ) {
            print(exception);
            print(KeyResource.ACCESS_TOKEN);
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(
                  Icons.collections_rounded,
                  color: Colors.grey,
                  size: 50,
                ),
              ),
            );
          },
          loadingBuilder: (BuildContext ctx, Widget? child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child!;
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(ColorResource.colorPrimary),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  static Widget imageAssets(
    String url, {
    double? width,
    double? height,
    double? widthBorder,
    BoxFit? boxFit,
    double? radiusAll,
    double? radiusTopRight,
    double? radiusTopLeft,
    double? radiusBotRight,
    double? radiusBotLeft,
    Color? colorBorder,
    Color? color,
    List<BoxShadow>? shadowCustom,
    bool isShadow = false,
  }) {
    radiusAll = radiusAll ?? 0;
    radiusTopRight = radiusTopRight ?? radiusAll;
    radiusTopLeft = radiusTopLeft ?? radiusAll;
    radiusBotRight = radiusBotRight ?? radiusAll;
    radiusBotLeft = radiusBotLeft ?? radiusAll;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          width: widthBorder ?? 0,
          color: colorBorder ?? Colors.transparent,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(radiusTopRight),
          topLeft: Radius.circular(radiusTopLeft),
          bottomLeft: Radius.circular(radiusBotLeft),
          bottomRight: Radius.circular(radiusBotRight),
        ),
        color: colorBorder,
        boxShadow: isShadow
            ? shadowCustom ??
                [
                  BoxShadow(
                      color: ColorResource.black.withOpacity(
                        0.2,
                      ),
                      blurRadius: 5)
                ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(radiusTopRight),
          topLeft: Radius.circular(radiusTopLeft),
          bottomLeft: Radius.circular(radiusBotLeft),
          bottomRight: Radius.circular(radiusBotRight),
        ),
        child: Image.asset(
          url,
          width: width,
          height: height,
          fit: boxFit,
          color: color,
        ),
      ),
    );
  }
}
