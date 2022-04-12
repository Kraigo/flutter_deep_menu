import 'dart:ui';

import 'package:flutter/material.dart';

class DeepMenuDetails extends StatefulWidget {
  final Widget content;
  final Widget? bodyMenu;
  final Color color;
  final Widget? headMenu;
  final Size? headMenuSize;
  final RenderBox renderBox;
  late final Animation<double> animation;

  final double spacing;
  final Key uniqKey;

  DeepMenuDetails({
    required this.bodyMenu,
    required this.content,
    required this.renderBox,
    required animation,
    required this.uniqKey,
    this.headMenu,
    this.headMenuSize,
    this.color = Colors.black,
    this.spacing = 10.0,
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
  final _offstageKey = GlobalKey();

  Size get contentSize {
    return widget.renderBox.size;
  }

  Offset get contentOffset {
    return widget.renderBox.localToGlobal(Offset.zero);
  }

  double get _headMenuSize {
    return widget.headMenuSize != null
      ? widget.headMenuSize!.height + widget.spacing : 0;
  }

  double get _paddingTop {
    final topPadding = MediaQuery.of(context).padding.top;
    return contentOffset.dy > topPadding ? contentOffset.dy - _headMenuSize : topPadding + 20;
  }

  double get _paddingBottom {
    return MediaQuery.of(context).padding.bottom + 20;
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
              Positioned.fill(child: _buildBackdrop(context)),
              SingleChildScrollView(
                  padding:
                      EdgeInsets.only(top: _paddingTop, bottom: _paddingBottom),
                  controller: scrollController,
                  child: _buildScrollBody()),
            ],
          ),
        ));
  }

  Widget _buildScrollBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.headMenu != null)
          Container(
            key: _offstageKey,
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: widget.spacing),
            child: _buildHeadMenu(),
          ),
        Center(
          child: _buildContent(),
        ),
        if (widget.bodyMenu != null)
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: widget.spacing),
            child: _buildBodyMenu(),
          ),
      ],
    );
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
            tag: widget.uniqKey,
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
