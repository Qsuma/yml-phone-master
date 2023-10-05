import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class ShortcutController extends StatefulWidget {
  const ShortcutController({super.key,  required this.widget, required this.focusNode});

final FocusNode focusNode;
final Widget widget;

  @override
  State<ShortcutController> createState() => _ShortcutControllerState();
}

class _ShortcutControllerState extends State<ShortcutController> {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(shortcuts:  <LogicalKeySet, Intent>{
                  LogicalKeySet(LogicalKeyboardKey.select):
                      const ActivateIntent(),
                  LogicalKeySet(LogicalKeyboardKey.enter):
                      const ActivateIntent(),
                },
                
                 child: widget.widget);
      
  }
}
