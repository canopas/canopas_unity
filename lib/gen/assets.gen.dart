/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_logo.svg
  String get appLogo => 'assets/images/app_logo.svg';

  /// File path: assets/images/calendar_filled.svg
  String get calendarFilled => 'assets/images/calendar_filled.svg';

  /// File path: assets/images/empty_state.png
  AssetGenImage get emptyState =>
      const AssetGenImage('assets/images/empty_state.png');

  /// File path: assets/images/google_logo.png
  AssetGenImage get googleLogo =>
      const AssetGenImage('assets/images/google_logo.png');

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

  /// File path: assets/images/users_filled.svg
  String get usersFilled => 'assets/images/users_filled.svg';

  /// List of all assets
  List<dynamic> get values => [
        appLogo,
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
        usersFilled
      ];
}

class Assets {
  Assets._();

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
