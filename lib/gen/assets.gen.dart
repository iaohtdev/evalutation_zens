/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/icon_add_cart.svg
  String get iconAddCart => 'assets/icons/icon_add_cart.svg';

  /// File path: assets/icons/icon_cart.svg
  String get iconCart => 'assets/icons/icon_cart.svg';

  /// List of all assets
  List<String> get values => [iconAddCart, iconCart];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/banner.png
  AssetGenImage get banner => const AssetGenImage('assets/images/banner.png');

  /// File path: assets/images/banner_hover.png
  AssetGenImage get bannerHover =>
      const AssetGenImage('assets/images/banner_hover.png');

  /// File path: assets/images/img_prod_1.png
  AssetGenImage get imgProd1 =>
      const AssetGenImage('assets/images/img_prod_1.png');

  /// File path: assets/images/img_prod_2.png
  AssetGenImage get imgProd2 =>
      const AssetGenImage('assets/images/img_prod_2.png');

  /// File path: assets/images/img_prod_3.png
  AssetGenImage get imgProd3 =>
      const AssetGenImage('assets/images/img_prod_3.png');

  /// File path: assets/images/text_banner.png
  AssetGenImage get textBanner =>
      const AssetGenImage('assets/images/text_banner.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [banner, bannerHover, imgProd1, imgProd2, imgProd3, textBanner];
}

class $AssetsJsonGen {
  const $AssetsJsonGen();

  /// File path: assets/json/drink_json.json
  String get drinkJson => 'assets/json/drink_json.json';

  /// File path: assets/json/option_json.json
  String get optionJson => 'assets/json/option_json.json';

  /// File path: assets/json/size_json.json
  String get sizeJson => 'assets/json/size_json.json';

  /// File path: assets/json/topping_json.json
  String get toppingJson => 'assets/json/topping_json.json';

  /// List of all assets
  List<String> get values => [drinkJson, optionJson, sizeJson, toppingJson];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonGen json = $AssetsJsonGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
