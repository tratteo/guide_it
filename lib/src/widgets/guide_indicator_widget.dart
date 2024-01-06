import "dart:math";

import "package:flutter/material.dart";
import "package:guide_it/src/models/guide_animation_options.dart";
import "package:guide_it/src/models/guide_indicator.dart";

class GuideIndicatorWidget extends StatefulWidget {
  const GuideIndicatorWidget({
    super.key,
    required this.indicator,
    required this.direction,
  });
  final AxisDirection direction;
  final GuideIndicator indicator;

  @override
  State<GuideIndicatorWidget> createState() => _GuideIndicatorWidgetState();
}

class _GuideIndicatorWidgetState extends State<GuideIndicatorWidget>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: widget.indicator.animationOptions.duration,
    vsync: this,
  );

  late double _animatable = 1;
  late double _opacity = 1;

  void _updateAnimation() {
    setState(() {
      switch (widget.indicator.animationOptions.type) {
        case AnimationType.scale:
          _animatable = widget.indicator.animationOptions.curve
                      .transform(_animationController.value) *
                  (1 - widget.indicator.animationOptions.initialScale) +
              widget.indicator.animationOptions.initialScale;
          break;
        case AnimationType.translation:
          _animatable = widget.indicator.animationOptions.curve
                  .transform(1 - _animationController.value) *
              widget.indicator.animationOptions.transitionOffset;
          break;
      }
      if (widget.indicator.animationOptions.fade) {
        _opacity = widget.indicator.animationOptions.curve
            .transform(_animationController.value);
      }
    });
  }

  @override
  void initState() {
    switch (widget.indicator.animationOptions.type) {
      case AnimationType.scale:
        _animatable = widget.indicator.animationOptions.animate
            ? widget.indicator.animationOptions.initialScale
            : 1;
        break;
      case AnimationType.translation:
        _animatable = widget.indicator.animationOptions.animate
            ? widget.indicator.animationOptions.transitionOffset
            : 0;
        break;
    }
    _opacity = widget.indicator.animationOptions.fade ? 0 : 1;
    if (widget.indicator.animationOptions.animate) {
      _animationController.addListener(_updateAnimation);
    }
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildCore() {
    return Opacity(
      opacity: _opacity,
      child: Transform.rotate(
        angle: widget.indicator.adaptRotation
            ? widget.direction == AxisDirection.up
                ? pi
                : 0
            : 0,
        child: SizedBox(
          width: widget.indicator.size,
          child: Center(child: widget.indicator.child),
        ),
      ),
    );
  }

  Offset _getOffset() {
    switch (widget.indicator.animationOptions.translationMode) {
      case TranslationMode.vertical:
        return Offset(
          0,
          widget.direction == AxisDirection.up ? _animatable : -_animatable,
        );
      case TranslationMode.right:
        return Offset(-_animatable, 0);
      case TranslationMode.left:
        return Offset(_animatable, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.indicator.animationOptions.type == AnimationType.translation) {
      return Transform.translate(
        offset: _getOffset(),
        child: _buildCore(),
      );
    }
    if (widget.indicator.animationOptions.type == AnimationType.scale) {
      return Transform.scale(
        scale: _animatable,
        child: _buildCore(),
      );
    }

    return _buildCore();
  }
}
