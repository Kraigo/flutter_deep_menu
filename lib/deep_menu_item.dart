import 'package:flutter/material.dart';

class DeepMenuItem extends StatelessWidget {
  Widget label;
  Widget? icon;
  void Function() onTap;

  DeepMenuItem({
    required this.label,
    required this.onTap,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: kMinInteractiveDimension,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [label, if (icon != null) icon!],
            ),
          ),
        ),
      ),
    );
  }
}
