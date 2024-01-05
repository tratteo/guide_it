import "package:flutter/material.dart";

enum AnimationType { scale, translation }

enum TranslationMode { left, right, vertical }

class GuideAnimationOptions {
  const GuideAnimationOptions({
    this.animate = true,
    this.fade = false,
    this.curve = Curves.easeInCubic,
    this.type = AnimationType.translation,
    this.translationMode = TranslationMode.vertical,
    this.initialScale = 0.75,
    this.transitionOffset = 20,
    this.duration = const Duration(milliseconds: 250),
  });

  /// Direction in case the type is [translation]
  final TranslationMode translationMode;

  /// The initial scale in case the type is [scale]
  final double initialScale;

  /// The amount to transition in case the type is [translation]
  final double transitionOffset;

  /// Whether to enable the animation
  final bool animate;

  /// Whether to enable opacity animation
  final bool fade;

  /// The curve of the animation
  final Curve curve;

  /// The type of the animation
  final AnimationType type;

  /// The duration of the animation
  final Duration duration;
}
