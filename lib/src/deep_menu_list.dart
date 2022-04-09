import 'package:flutter/material.dart';

import 'deep_menu_item.dart';

class DeepMenuList extends StatelessWidget {
  final List<DeepMenuItem> items;

  const DeepMenuList({required this.items, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            ...items
                .sublist(0, items.length - 1)
                .map((e) => Container(
                      decoration: _dividerDecoration(context),
                      child: e,
                    ))
                .toList(),
            items.last
          ],
        ));
  }

  Decoration _dividerDecoration(BuildContext context) {
    final theme = Theme.of(context);
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(color: theme.dividerColor, width: 1.0),
      ),
    );
  }
}
