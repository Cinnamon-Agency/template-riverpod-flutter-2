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

  /// File path: assets/icons/earth_plane.svg
  String get earthPlane => 'assets/icons/earth_plane.svg';

  /// List of all assets
  List<String> get values => [earthPlane];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/beach.svg
  String get beach => 'assets/images/beach.svg';

  /// File path: assets/images/cinnamon.jpeg
  AssetGenImage get cinnamon =>
      const AssetGenImage('assets/images/cinnamon.jpeg');

  /// File path: assets/images/fun_moments.svg
  String get funMoments => 'assets/images/fun_moments.svg';

  /// File path: assets/images/journey.svg
  String get journey => 'assets/images/journey.svg';

  /// File path: assets/images/social_sharing.svg
  String get socialSharing => 'assets/images/social_sharing.svg';

  /// File path: assets/images/team_collaboration.svg
  String get teamCollaboration => 'assets/images/team_collaboration.svg';

  /// File path: assets/images/travelling.svg
  String get travelling => 'assets/images/travelling.svg';

  /// List of all assets
  List<dynamic> get values => [
        beach,
        cinnamon,
        funMoments,
        journey,
        socialSharing,
        teamCollaboration,
        travelling
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
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
