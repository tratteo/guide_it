import "package:flutter/material.dart";
import "package:guide_it/src/models/guide_animation_options.dart";

class GuideIndicator {
  const GuideIndicator({
    this.child = const Icon(Icons.keyboard_arrow_down_rounded, size: 32),
    this.size = 32,
    this.animationOptions = const GuideAnimationOptions(),
    this.adaptRotation = true,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  /// Animation options for the indicator.
  final GuideAnimationOptions animationOptions;

  /// Whether to rotate the indicator widge so that the top is always toward the child widget.
  final bool adaptRotation;

  /// The padding of the indicator.
  final EdgeInsets padding;

  /// The size of the indicator.
  ///
  /// This is used to provide smooth animations to the indicator and to correctly position the widgets.
  ///
  /// **This should reflect the actual size of the indicator widget**.
  final double size;

  final Widget child;
}
