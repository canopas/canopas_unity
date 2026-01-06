// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_logo.svg
  String get appLogo => 'assets/images/app_logo.svg';

  /// File path: assets/images/apple_logo.svg
  String get appleLogo => 'assets/images/apple_logo.svg';

  /// File path: assets/images/calendar_filled.svg
  String get calendarFilled => 'assets/images/calendar_filled.svg';

  /// File path: assets/images/empty_state.png
  AssetGenImage get emptyState =>
      const AssetGenImage('assets/images/empty_state.png');

  /// File path: assets/images/google_logo.svg
  String get googleLogo => 'assets/images/google_logo.svg';

  /// File path: assets/images/home_filled.svg
  String get homeFilled => 'assets/images/home_filled.svg';

  /// File path: assets/images/ic_calendar.svg
  String get icCalendar => 'assets/images/ic_calendar.svg';

  /// File path: assets/images/ic_home.svg
  String get icHome => 'assets/images/ic_home.svg';

  /// File path: assets/images/ic_menu.svg
  String get icMenu => 'assets/images/ic_menu.svg';

  /// File path: assets/images/ic_users.svg
  String get icUsers => 'assets/images/ic_users.svg';

  /// File path: assets/images/office_growth.png
  AssetGenImage get officeGrowth =>
      const AssetGenImage('assets/images/office_growth.png');

  /// File path: assets/images/pencil-square.svg
  String get pencilSquare => 'assets/images/pencil-square.svg';

  /// File path: assets/images/round_logo.svg
  String get roundLogo => 'assets/images/round_logo.svg';

  /// File path: assets/images/users_filled.svg
  String get usersFilled => 'assets/images/users_filled.svg';

  /// List of all assets
  List<dynamic> get values => [
    appLogo,
    appleLogo,
    calendarFilled,
    emptyState,
    googleLogo,
    homeFilled,
    icCalendar,
    icHome,
    icMenu,
    icUsers,
    officeGrowth,
    pencilSquare,
    roundLogo,
    usersFilled,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
