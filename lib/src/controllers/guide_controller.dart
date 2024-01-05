import "dart:async";
import "dart:ui";

class ShowGuideParams {
  ShowGuideParams({
    required this.id,
    this.force = false,
    this.onComplete,
  });

  /// The identifier of the guide to be shown.
  ///
  /// This should be used to uniquely identify the guide.
  /// Whenever the guide is shown, it is possible to use the [onComplete] callback to serialize to a local storage that the guide has been processed by the user. This allows for one time only guides.
  final String? id;

  /// Whether to skip the [canShow] method and forcely show the guide.
  final bool force;

  /// Called when the guide has been shown
  final VoidCallback? onComplete;
}

class GuideController {
  final StreamController<ShowGuideParams> _showStream = StreamController.broadcast();

  Stream<ShowGuideParams> get show => _showStream.stream;

  void showTutorial({required ShowGuideParams params}) => _showStream.sink.add(params);

  void dispose() => _showStream.close();
}
