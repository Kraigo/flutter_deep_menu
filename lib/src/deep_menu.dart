import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'deep_menu_details.dart';
import 'helpers/helpers.dart';

class DeepMenu extends StatefulWidget {
  final Widget child;
  final Widget? bodyMenu;
  final Widget? headMenu;
  final bool vibration;

  const DeepMenu({
    required this.child,
    this.bodyMenu,
    this.headMenu,
    this.vibration = true,
    Key? key,
  }) : super(key: key);

  @override
  _DeepMenuState createState() => _DeepMenuState();
}

class _DeepMenuState extends State<DeepMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Key uniqKey;

  Size? headMenuSize;
  bool _prepare = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    animation = Tween(begin: 1.0, end: 0.97)
        .chain(CurveTween(curve: Curves.easeIn))
        .animate(controller);
    uniqKey = UniqueKey();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  RenderBox get _renderBox {
    return context.findRenderObject() as RenderBox;
  }

  _openMenu() async {
    if (widget.vibration) {
      HapticFeedback.lightImpact();
    }
    await Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 180),
          reverseTransitionDuration: const Duration(milliseconds: 140),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
                opacity: animation,
                child: DeepMenuDetails(
                  uniqKey: uniqKey,
                  bodyMenu: widget.bodyMenu,
                  headMenu: widget.headMenu,
                  headMenuSize: headMenuSize,
                  content: widget.child,
                  renderBox: _renderBox,
                  animation: animation,
                ));
          },
          fullscreenDialog: true,
          opaque: false,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
            onLongPress: () {
              controller.reverse();
              _openMenu();
            },
            onTapDown: (_) {
              controller.forward();
              setState(() {
                _prepare = true;
              });
            },
            onTapUp: (_) {
              controller.reverse();
            },
            child: ScaleTransition(
                scale: animation,
                child: Hero(
                  child: widget.child,
                  tag: uniqKey,
                ))),
        if (_prepare && widget.headMenu != null)
          MeasureWidget(
            child: widget.headMenu!,
            onRender: (renderBox) {
              setState(() {
                headMenuSize = renderBox.size;
              });
            }),
      ],
    );
  }
}
