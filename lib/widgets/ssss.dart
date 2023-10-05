/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool switchValue = false;
  final FocusScopeNode node = FocusScopeNode();
  final textFocus = FocusNode();
  final textWrapper = FocusNode();
  final switchFocus = FocusNode();
  final btnNode = FocusNode();

  @override
  void initState() {
    textFocus.addListener(_listener);
    btnNode.addListener(_listener);
    textWrapper.addListener(_listener);
    switchFocus.addListener(_listener);
    super.initState();
  }

  _listener() {
    if (textFocus.hasFocus ||
        textWrapper.hasFocus ||
        switchFocus.hasFocus ||
        btnNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    textFocus.removeListener(_listener);
    btnNode.removeListener(_listener);
    textWrapper.removeListener(_listener);
    switchFocus.removeListener(_listener);
    node.dispose();
    textFocus.dispose();
    switchFocus.dispose();
    btnNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FocusScope(
          autofocus: true,
          onFocusChange: (val) {
            if (val) textFocus.requestFocus();
          },
          onKey: (FocusNode node, RawKeyEvent event) {
            if (event is RawKeyUpEvent &&
                event.data is RawKeyEventDataAndroid) {
              RawKeyUpEvent rawKeyDownEvent = event;
              RawKeyEventDataAndroid rawKeyEventDataAndroid =
                  rawKeyDownEvent.data as RawKeyEventDataAndroid;

              if (rawKeyEventDataAndroid.keyCode == KEY_CENTER) {
                if (textFocus.hasFocus) {
                  textFocus.unfocus();
                  Future.delayed(Duration.zero).then((value) {
                    textFocus.requestFocus();
                  });
                } else if (textWrapper.hasFocus) {
                  textFocus.requestFocus();
                }
              }

              if (rawKeyEventDataAndroid.keyCode == KEY_DOWN) {
                if (textWrapper.hasFocus) {
                  switchFocus.requestFocus();
                } else if (switchFocus.hasFocus) {
                  btnNode.requestFocus();
                } else {
                  textFocus.requestFocus();
                }
              }

              if (rawKeyEventDataAndroid.keyCode == KEY_UP) {
                if (btnNode.hasFocus) {
                  switchFocus.requestFocus();
                } else if (switchFocus.hasFocus) {
                  textFocus.requestFocus();
                } else {
                  btnNode.requestFocus();
                }
              }
            }
            return KeyEventResult.handled;
          },
          child: Column(
            children: [
              RawKeyboardListener(
                focusNode: textWrapper,
                child: TextField(
                  focusNode: textFocus,
                  autofocus: true,
                ),
              ),
              Shortcuts(
                shortcuts: <LogicalKeySet, Intent>{
                  LogicalKeySet(LogicalKeyboardKey.select):
                      const ActivateIntent(),
                  LogicalKeySet(LogicalKeyboardKey.enter):
                      const ActivateIntent(),
                },
                child: Switch(
                  value: switchValue,
                  focusNode: switchFocus,
                  onChanged: (value) {
                    setState(() {
                      switchValue = value;
                    });
                  },
                ),
              ),
              Shortcuts(
                shortcuts: <LogicalKeySet, Intent>{
                  LogicalKeySet(LogicalKeyboardKey.select):
                      const ActivateIntent(),
                  LogicalKeySet(LogicalKeyboardKey.enter):
                      const ActivateIntent(),
                },
                child: TextButton(
                  onPressed: () => print('Button pressed'),
                  focusNode: btnNode,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: const Text('Test'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const int KEY_UP = 19;
const int KEY_DOWN = 20;
const int KEY_LEFT = 21;
const int KEY_RIGHT = 22;
const int KEY_CENTER = 23;
const int KEY_BACK = 4;*/