import 'package:flutter/material.dart';

class MeasureWidget extends StatefulWidget {
  final Widget child;
  final void Function(RenderBox) onRender;

  const MeasureWidget({
    required this.child,
    required this.onRender,
    Key? key,
  }) : super(key: key);

  @override
  State<MeasureWidget> createState() => _MeasureWidgetState();
}

class _MeasureWidgetState extends State<MeasureWidget> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      widget.onRender(renderBox);
      setState(() {
        _initialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
        offstage: false,
        child: Container(
          child: _initialized ? null : widget.child,
        ));
  }
}
