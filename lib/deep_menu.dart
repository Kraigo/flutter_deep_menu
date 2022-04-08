import 'package:flutter/material.dart';

import 'deep_menu_details.dart';

class DeepMenu extends StatefulWidget {
  final Widget child;
  final Widget bodyMenu;
  final Widget? headMenu;

  const DeepMenu({
    required this.child,
    required this.bodyMenu,
    this.headMenu,
    Key? key,
  }) : super(key: key);

  @override
  _DeepMenuState createState() => _DeepMenuState();
}

class _DeepMenuState extends State<DeepMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    animation = Tween(
      begin: 1.0,
      end: 0.98
    )
    .chain(CurveTween(curve: Curves.elasticOut))
    .animate(controller);
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
    await Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 150),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
                opacity: animation,
                child: DeepMenuDetails(
                  bodyMenu: widget.bodyMenu,
                  headMenu: widget.headMenu,
                  content: widget.child,
                  renderBox: _renderBox,
                  animation: Tween<double>(begin: 0.0, end: 1.0)
                    .chain(CurveTween(curve: Curves.easeOut))
                    .animate(animation),
                ));
          },
          fullscreenDialog: true,
          opaque: false,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          controller.reverse();
          _openMenu();
        },
        onTapDown: (_) {
          controller.forward();
        },
        onTapUp: (_) {
          controller.reverse();
        },
        child: ScaleTransition(
          scale: animation,
          child: widget.child,
        ));
  }
}
