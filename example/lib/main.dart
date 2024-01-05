import "package:example/theme.dart";
import "package:flutter/material.dart";
import "package:guide_it/guide_it.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GuideIt example",
      theme: activeTheme,
      home: const MyHomePage(title: "GuideIt example"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _textKey = GlobalKey();
  final GlobalKey _iconKey = GlobalKey();
  final GlobalKey _secondIconKey = GlobalKey();
  final GlobalKey _fabKey = GlobalKey();

  final GuideController _controller = GuideController();
  static const String _guideId = "test";
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<GuideItem> _guideItems() {
    return [
      GuideItem(
        targetWidgetKey: _textKey,
        child: const Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          children: [
            Icon(Icons.help_rounded),
            Text("Welcome to the GuideIt example"),
          ],
        ),
      ),
      GuideItem(
        targetWidgetKey: _iconKey,
        child: const Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          children: [
            Icon(Icons.place_rounded),
            Text("This is the first icon, tap anywhere to continue"),
          ],
        ),
      ),
      GuideItem(
        targetWidgetKey: _secondIconKey,
        child: const Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          children: [
            Icon(Icons.ac_unit_rounded),
            Text("This is the second icon"),
          ],
        ),
      ),
      GuideItem(
        targetWidgetKey: _fabKey,
        displayOptions: (options) => options.copyWith(
          borderRadius: const Radius.circular(12),
          defaultIndicator: GuideIndicator(
            child: Icon(
              Icons.replay_rounded,
              size: 32,
              color: Theme.of(context).colorScheme.secondary,
            ),
            adaptRotation: false,
            animationOptions: const GuideAnimationOptions(
              curve: Curves.easeInBack,
              duration: Duration(milliseconds: 350),
            ),
            size: 32,
          ),
        ),
        child: const Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          children: [
            Text("And this is the Floating Action Button, press it to replay the guide"),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Guide(
      guid: _guideId,
      canShow: (guid) => true,
      controller: _controller,
      displayOptions: GuideDisplayOptions(
        highlightColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
        backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.85),
        animationOptions: const GuideAnimationOptions(
          animate: true,
          fade: true,
          initialScale: 0.9,
          transitionOffset: 50,
          type: AnimationType.translation,
          translationMode: TranslationMode.vertical,
          duration: Duration(milliseconds: 500),
        ),
      ),
      items: _guideItems(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 64),
              Padding(
                key: _textKey,
                padding: const EdgeInsets.all(8),
                child: const Text("Welcome to GuideIt"),
              ),
              const Divider(height: 32),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 32,
                children: [
                  Icon(
                    key: _iconKey,
                    Icons.place_rounded,
                    size: 48,
                  ),
                  Icon(
                    key: _secondIconKey,
                    Icons.ac_unit_rounded,
                    size: 48,
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          key: _fabKey,
          onPressed: () {
            _controller.showTutorial(params: ShowGuideParams(id: _guideId, force: true));
          },
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
