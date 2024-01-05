import "package:flutter/material.dart";

extension GlobalKeyExtensions on GlobalKey? {
  Offset getPosition() {
    if (this == null || this!.currentContext == null) return Offset.zero;
    var rObj = this!.currentContext!.findRenderObject();
    if (rObj == null) return Offset.zero;
    RenderBox rBox = rObj as RenderBox;
    return rBox.localToGlobal(Offset.zero);
  }

  Size getSize() {
    if (this == null || this!.currentContext == null) return Size.zero;
    var rObj = this!.currentContext!.findRenderObject();
    if (rObj == null) return Size.zero;
    RenderBox rBox = rObj as RenderBox;
    return rBox.size;
  }
}
