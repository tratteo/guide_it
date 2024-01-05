import "package:flutter/material.dart";
import "package:guide_it/src/models/guide_animation_options.dart";
import "package:guide_it/src/models/guide_indicator.dart";

class GuideDisplayOptions {
  const GuideDisplayOptions({
    this.highlightColor,
    this.backgroundColor,
    this.animationOptions = const GuideAnimationOptions(),
    this.highlightRadius = const Radius.circular(12),
    this.defaultIndicator = const GuideIndicator(),
    this.showIndicator = true,
    this.widgetPadding = const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 32),
  });

  /// Animation options
  final GuideAnimationOptions animationOptions;

  /// Whether to show the indicator
  final bool showIndicator;

  /// Radius of the highlighted section
  final Radius highlightRadius;

  /// The padding of the descriptive element
  final EdgeInsets widgetPadding;

  /// The default settings for the indicator
  final GuideIndicator defaultIndicator;

  /// Color for the highlighted section
  final Color? highlightColor;

  /// Color for the background
  final Color? backgroundColor;

  GuideDisplayOptions copyWith({
    Radius? borderRadius,
    Color? highlightColor,
    bool? showIndicator,
    Color? backgroundColor,
    Duration? animDuration,
    GuideAnimationOptions? animationOptions,
    GuideIndicator? defaultIndicator,
    EdgeInsets? textPadding,
  }) {
    return GuideDisplayOptions(
      highlightRadius: borderRadius ?? highlightRadius,
      highlightColor: highlightColor ?? this.highlightColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      showIndicator: showIndicator ?? this.showIndicator,
      animationOptions: animationOptions ?? this.animationOptions,
      defaultIndicator: defaultIndicator ?? this.defaultIndicator,
      widgetPadding: textPadding ?? widgetPadding,
    );
  }
}
