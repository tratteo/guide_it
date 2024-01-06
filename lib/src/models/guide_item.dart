import "package:flutter/material.dart";
import "package:guide_it/src/models/guide_display_options.dart";

class GuideItem {
  GuideItem({
    required this.targetWidgetKey,
    required this.child,
    this.displayOptions,
  });

  /// Override the default display options for this item
  final GuideDisplayOptions Function(GuideDisplayOptions defaultOptions)?
      displayOptions;

  /// The guide item to show, generally a text or an action
  final Widget child;

  /// The key of the widget to highlight
  final GlobalKey? targetWidgetKey;
}
