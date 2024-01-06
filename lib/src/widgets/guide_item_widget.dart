import "dart:async";
import "dart:ui";

import "package:flutter/material.dart";
import "package:guide_it/src/common/extensions.dart";
import "package:guide_it/src/common/highlight_painter.dart";
import "package:guide_it/src/models/guide_animation_options.dart";
import "package:guide_it/src/models/guide_display_options.dart";
import "package:guide_it/src/models/guide_item.dart";
import "package:guide_it/src/widgets/guide_indicator_widget.dart";

class GuideItemWidget extends StatefulWidget {
  const GuideItemWidget({
    super.key,
    required this.defaultDisplayOptions,
    required this.item,
    this.onTap,
  });
  final GuideDisplayOptions defaultDisplayOptions;
  final GuideItem item;
  final VoidCallback? onTap;

  @override
  State<GuideItemWidget> createState() => _GuideItemWidgetState();
}

class _GuideItemWidgetState extends State<GuideItemWidget>
    with TickerProviderStateMixin {
  double _indicatorSize = 0;
  Offset _itemPos = Offset.zero;
  Size _itemSize = Size.zero;
  AxisDirection _direction = AxisDirection.up;

  double _animatable = 0;
  double _opacity = 0;

  late final GuideDisplayOptions displayOptions =
      widget.item.displayOptions?.call(widget.defaultDisplayOptions) ??
          widget.defaultDisplayOptions;
  late final AnimationController _animController = AnimationController(
    duration: displayOptions.animationOptions.duration,
    vsync: this,
  );

  Timer? _repaintTimer;

  void _updateAnimation() {
    setState(() {
      switch (displayOptions.animationOptions.type) {
        case AnimationType.scale:
          _animatable = displayOptions.animationOptions.curve
                      .transform(_animController.value) *
                  (1 - displayOptions.animationOptions.initialScale) +
              displayOptions.animationOptions.initialScale;
          break;
        case AnimationType.translation:
          _animatable = displayOptions.animationOptions.curve
                  .transform(1 - _animController.value) *
              displayOptions.animationOptions.transitionOffset;
          break;
      }
      if (displayOptions.animationOptions.fade) {
        _opacity = displayOptions.animationOptions.curve
            .transform(_animController.value);
      }
    });
  }

  @override
  void initState() {
    _itemPos = widget.item.targetWidgetKey.getPosition();
    _itemSize = widget.item.targetWidgetKey.getSize();

    _indicatorSize = displayOptions.defaultIndicator.size;

    switch (displayOptions.animationOptions.type) {
      case AnimationType.scale:
        _animatable = displayOptions.animationOptions.animate
            ? displayOptions.animationOptions.initialScale
            : 1;
        break;
      case AnimationType.translation:
        _animatable = displayOptions.animationOptions.animate
            ? displayOptions.animationOptions.transitionOffset
            : 0;
        break;
    }
    _opacity = displayOptions.animationOptions.fade ? 0 : 1;
    if (displayOptions.animationOptions.animate) {
      _animController.addListener(_updateAnimation);
    }

    _animController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _repaintTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  void _fetchState() {
    setState(() {
      _direction = _itemPos.dy > MediaQuery.of(context).size.height / 2
          ? AxisDirection.down
          : AxisDirection.up;
      _itemPos = widget.item.targetWidgetKey.getPosition();
      _itemSize = widget.item.targetWidgetKey.getSize();
    });
  }

  double _axisOffset(double val) => _direction == AxisDirection.up ? val : -val;

  Widget _buildElement() {
    switch (displayOptions.animationOptions.type) {
      case AnimationType.scale:
        return Transform.scale(
          scale: _animatable,
          child: Opacity(
            opacity: _opacity,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: widget.item.child,
            ),
          ),
        );
      case AnimationType.translation:
        return Transform.translate(
          offset: _getOffset(),
          child: Opacity(
            opacity: _opacity,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: widget.item.child,
            ),
          ),
        );
    }
  }

  Offset _getOffset() {
    var mode = displayOptions.animationOptions.translationMode;
    switch (mode) {
      case TranslationMode.vertical:
        return Offset(
          0,
          _direction == AxisDirection.up ? _animatable : -_animatable,
        );
      case TranslationMode.right:
        return Offset(-_animatable, 0);
      case TranslationMode.left:
        return Offset(_animatable, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    _fetchState();
    return Scaffold(
      backgroundColor:
          displayOptions.highlightColor ?? Colors.white.withOpacity(0.2),
      body: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          children: [
            CustomPaint(
              size: MediaQuery.of(context).size,
              painter: HighlightPainter(
                dx: _itemPos.dx + (_itemSize.width / 2),
                dy: _itemPos.dy + (_itemSize.height / 2),
                width: _itemSize.width,
                height: _itemSize.height,
                color: displayOptions.backgroundColor ??
                    Colors.black.withOpacity(0.75),
                borderRadius: displayOptions.highlightRadius,
              ),
            ),
            if (widget.item.targetWidgetKey != null) ...[
              Positioned(
                width: mediaSize.width,
                top: _direction == AxisDirection.up
                    ? _itemPos.dy +
                        _itemSize.height +
                        _axisOffset(
                          displayOptions.defaultIndicator.padding.top,
                        ) +
                        _axisOffset(displayOptions.widgetPadding.top) +
                        _indicatorSize
                    : null,
                bottom: _direction == AxisDirection.down
                    ? mediaSize.height -
                        _itemPos.dy -
                        _axisOffset(
                          displayOptions.defaultIndicator.padding.bottom,
                        ) -
                        _axisOffset(displayOptions.widgetPadding.bottom) +
                        _indicatorSize
                    : null,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: mediaSize.width,
                    maxHeight: mediaSize.height,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: displayOptions.widgetPadding.left,
                      right: displayOptions.widgetPadding.right,
                    ),
                    child: _buildElement(),
                  ),
                ),
              ),
              Positioned(
                top: _direction == AxisDirection.up
                    ? _itemPos.dy +
                        _itemSize.height +
                        _axisOffset(displayOptions.defaultIndicator.padding.top)
                    : null,
                bottom: _direction == AxisDirection.down
                    ? mediaSize.height -
                        _itemPos.dy -
                        _axisOffset(
                          displayOptions.defaultIndicator.padding.bottom,
                        )
                    : null,
                left: clampDouble(
                  _itemPos.dx + (_itemSize.width / 2) - (_indicatorSize / 2),
                  0,
                  mediaSize.width,
                ),
                child: GuideIndicatorWidget(
                  indicator: displayOptions.defaultIndicator,
                  direction: _direction,
                ),
              ),
            ] else
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: widget.item.child,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
