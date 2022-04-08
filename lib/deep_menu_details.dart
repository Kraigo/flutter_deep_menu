import 'dart:ui';

import 'package:flutter/material.dart';

class DeepMenuDetails extends StatefulWidget {
  final Widget content;
  final Widget bodyMenu;
  final Color color;
  final Widget? headMenu;
  final RenderBox renderBox;
  final Animation<double> animation;

  const DeepMenuDetails({
    required this.bodyMenu,
    required this.content,
    required this.renderBox,
    required this.animation,
    this.headMenu,
    this.color = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  State<DeepMenuDetails> createState() => _DeepMenuDetailsState();
}

class _DeepMenuDetailsState extends State<DeepMenuDetails> {
  late OverlayEntry? entry;
  late OverlayEntry? entry2;

  Size get contentSize {
    return widget.renderBox.size;
  }

  Offset get contentOffset {
    return widget.renderBox.localToGlobal(Offset.zero);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showOverlay();
    });
  }

  showOverlay() {
    final overlay = Overlay.of(context);
    entry = OverlayEntry(builder: (context) {
      return _buildBodyMenu(context);
    });

    overlay!.insert(entry!);
    entry2 = OverlayEntry(builder: (context) {
      return _buildHeadMenu(context);
    });

    overlay.insert(entry2!);
  }

  @override
  void dispose() {
    entry?.remove();
    entry2?.remove();
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackdrop(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildBackdrop() {
    return GestureDetector(
      onTap: () {
        // controller.reverse();
        Navigator.pop(context);
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: (widget.color).withOpacity(0.2),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Positioned(
      top: contentOffset.dy,
      left: 0,
      child: AbsorbPointer(
          absorbing: true,
          child: SizedBox(
            width: contentSize.width,
            height: contentSize.height,
            child: widget.content,
          )),
    );
  }

  Widget _buildBodyMenu(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final offset =
        Offset(contentOffset.dx, contentOffset.dy + contentSize.height);

    return Positioned(
        top: offset.dy,
        left: screenSize.width * 0.05,
        child: ScaleTransition(
          scale: widget.animation,
          child: widget.bodyMenu,
          alignment: Alignment.topCenter,
        ));
  }

  Widget _buildHeadMenu(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Positioned(
        bottom: screenSize.height - contentOffset.dy,
        left: screenSize.width * 0.05,
        child: ScaleTransition(
          scale: widget.animation,
          child: widget.headMenu,
          alignment: Alignment.bottomCenter,
        ));
  }
}
