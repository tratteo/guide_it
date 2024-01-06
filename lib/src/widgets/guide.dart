import "dart:async";

import "package:flutter/material.dart";
import "package:guide_it/src/controllers/guide_controller.dart";
import "package:guide_it/src/models/guide_display_options.dart";
import "package:guide_it/src/models/guide_item.dart";
import "package:guide_it/src/widgets/guide_item_widget.dart";

class Guide extends StatefulWidget {
  const Guide({
    super.key,
    required this.guid,
    required this.child,
    required this.items,
    required this.canShow,
    this.displayOptions = const GuideDisplayOptions(),
    this.controller,
    this.onComplete,
    this.autoShow = true,
    this.showAlways = false,
  });
  final GuideDisplayOptions displayOptions;
  final void Function(String guid)? onComplete;
  final bool Function(String guid)? canShow;

  /// Unique guid used to know when the guide has been shown. Changing this will result in the tutorial to be shown again
  final String guid;

  /// Auto show the tutorial on init state
  final bool autoShow;

  /// Ignore show conditions and show every time
  final bool showAlways;

  /// Optional controller to decide when to manually show the guide
  final GuideController? controller;
  final List<GuideItem> items;
  final Widget child;

  @override
  State<Guide> createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  StreamSubscription? _showSub;
  late GuideController _controller;
  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? GuideController();
    _showSub = _controller.show.listen(show);
    if (!widget.autoShow) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_shouldShow()) {
        show();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _showSub?.cancel();
  }

  bool _shouldShow() {
    if (widget.showAlways) return true;
    return widget.canShow?.call(widget.guid) ?? true;
  }

  @override
  Widget build(BuildContext context) => widget.child;

  Future<void> show([ShowGuideParams? action]) async {
    if (action != null && !action.force && !_shouldShow()) {
      action.onComplete?.call();
      return;
    }
    OverlayState overlayState = Overlay.of(context);
    List<(GuideItem, OverlayEntry)> overlays = [];
    int currentActive = 0;
    for (final item in widget.items) {
      overlays.add(
        (
          item,
          OverlayEntry(
            opaque: false,
            builder: (context) {
              return GuideItemWidget(
                defaultDisplayOptions: widget.displayOptions,
                item: item,
                onTap: () {
                  overlays[currentActive].$2.remove();
                  for (currentActive = currentActive + 1;
                      currentActive < overlays.length;
                      currentActive++) {
                    var current = overlays[currentActive];
                    if (currentActive != overlays.length &&
                        current.$1.targetWidgetKey != null &&
                        current.$1.targetWidgetKey!.currentWidget != null) {
                      overlayState.insert(current.$2);
                      break;
                    }
                  }
                  if (currentActive >= overlays.length) {
                    action?.onComplete?.call();
                  }
                },
              );
            },
          ),
        ),
      );
    }
    widget.onComplete?.call(widget.guid);
    if (overlays.isEmpty) {
      action?.onComplete?.call();
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      currentActive = overlays.indexWhere(
        (element) =>
            element.$1.targetWidgetKey != null &&
            element.$1.targetWidgetKey!.currentWidget != null,
      );
      if (currentActive >= 0) {
        overlayState.insert(overlays[currentActive].$2);
      }
    });
  }
}
