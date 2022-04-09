import 'dart:ui';

import 'package:flutter/material.dart';

class DeepMenuDetails extends StatefulWidget {
  final Widget content;
  final Widget? bodyMenu;
  final Color color;
  final Widget? headMenu;
  final RenderBox renderBox;
  late final Animation<double> animation;

  DeepMenuDetails({
    required this.bodyMenu,
    required this.content,
    required this.renderBox,
    required animation,
    this.headMenu,
    this.color = Colors.black,
    Key? key,
  }) : super(key: key) {
    this.animation = Tween<double>(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.easeOut))
        .animate(animation);
  }

  @override
  State<DeepMenuDetails> createState() => _DeepMenuDetailsState();
}

class _DeepMenuDetailsState extends State<DeepMenuDetails> {
  late ScrollController scrollController;

  Size get contentSize {
    return widget.renderBox.size;
  }

  Offset get contentOffset {
    return widget.renderBox.localToGlobal(Offset.zero);
  }

  double get _paddingTop {
    final topPadding = MediaQuery.of(context).padding.top;
    return contentOffset.dy > topPadding ? contentOffset.dy : topPadding;
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: 0);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  void _onBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: _onBack,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(child: 
              _buildBackdrop(context)),
              SingleChildScrollView(
                  padding: EdgeInsets.only(top: _paddingTop),
                  controller: scrollController,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.headMenu != null) _buildHeadMenu(),
                        _buildContent(),
                        if (widget.bodyMenu != null) _buildBodyMenu()
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }

  Widget _buildBackdrop(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        color: (widget.color).withOpacity(0.2),
      ),
    );
  }

  Widget _buildContent() {
    return AbsorbPointer(
        absorbing: true,
        child: SizedBox(
          width: contentSize.width,
          height: contentSize.height,
          child: Hero(
            child: widget.content,
            tag: widget.content.hashCode,
          ),
        ));
  }

  Widget _buildBodyMenu() {
    return ScaleTransition(
      scale: widget.animation,
      child: widget.bodyMenu,
      alignment: Alignment.topCenter,
    );
  }

  Widget _buildHeadMenu() {
    return ScaleTransition(
      scale: widget.animation,
      child: widget.headMenu,
      alignment: Alignment.bottomCenter,
    );
  }
}
