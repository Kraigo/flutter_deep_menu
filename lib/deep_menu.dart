import 'dart:ui';

import 'package:flutter/material.dart';

class DeepMenu extends StatefulWidget {
  Widget child;
  Widget menu;
  Widget? headMenu;
  DeepMenu({
    required this.child,
    required this.menu,
    this.headMenu,
    Key? key,
  }) : super(key: key);

  @override
  _DeepMenuState createState() => _DeepMenuState();
}

class _DeepMenuState extends State<DeepMenu> {
  bool isTapped = false;

  @override
  void initState() {
    super.initState();
  }

  RenderBox get _renderBox {
    return context.findRenderObject() as RenderBox;
  }

  _openMenu() async {
    await Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 100),
          pageBuilder: (context, animation, secondaryAnimation) {
            animation = Tween(begin: 0.0, end: 1.0).animate(animation);
            return FadeTransition(
                opacity: animation,
                child: DeepMenuDetails(
                  child: widget.menu,
                  headMenu: widget.headMenu,
                  content: widget.child,
                  renderBox: _renderBox,
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
          setState(() {
            isTapped = false;
          });
          _openMenu();
        },
        onTapDown: (_) {
          setState(() {
            isTapped = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            isTapped = false;
          });
        },
        child: AnimatedScale(
          scale: isTapped ? 0.98 : 1,
          duration: Duration(milliseconds: 100),
          child: widget.child,
        ));
  }
}

class DeepMenuDetails extends StatefulWidget {
  final Widget content;
  final Widget child;
  final Color color;
  final Widget? headMenu;
  // final Offset offset;
  final RenderBox renderBox;

  const DeepMenuDetails({
    required this.child,
    required this.content,
    // required this.offset,
    required this.renderBox,
    this.headMenu,
    this.color = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  State<DeepMenuDetails> createState() => _DeepMenuDetailsState();
}

class _DeepMenuDetailsState extends State<DeepMenuDetails> {
  Size get contentSize {
    return widget.renderBox.size;
  }

  Offset get contentOffset {
    return widget.renderBox.localToGlobal(Offset.zero);
  }

  bool started = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        started = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(fit: StackFit.expand, children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: (widget.color).withOpacity(0.2),
              ),
            )),
        _buildMenu(context),
        Positioned(
          top: contentOffset.dy,
          left: 0,
          child: AbsorbPointer(
              absorbing: true,
              child: SizedBox(
                width: contentSize.width,
                height: contentSize.height,
                child: widget.content,
              )),
        ),
        _buildHeadMenu(context),
        // child,
      ]),
    );
  }

  Positioned _buildMenu(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final maxMenuHeight = screenSize.height * 0.45;
    final size = contentSize;
    final offset = Offset(contentOffset.dx, contentOffset.dy + size.height);

    if (contentOffset.dy > maxMenuHeight) {
      print('Should we shifted');
    }

    return Positioned(
      top: offset.dy,
      left: screenSize.width * 0.05,
      child: SizedBox(
        width: screenSize.width * 0.5,
        child: 
        AnimatedScale(scale: started ? 1 : 0.3, duration: Duration(milliseconds: 100), child: widget.child, alignment: Alignment.topCenter,),
      ),
    );
  }

  Positioned _buildHeadMenu(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final maxMenuHeight = screenSize.height * 0.45;
    final size = contentSize;
    final offset = Offset(contentOffset.dx, contentOffset.dy + size.height);

    if (contentOffset.dy > maxMenuHeight) {
      print('Should we shifted');
    }

    return Positioned(
      top: contentOffset.dy,
      left: screenSize.width * 0.05,
      child: SizedBox(
        width: screenSize.width * 0.5,
        child: widget.headMenu,
      ),
    );
  }
}
