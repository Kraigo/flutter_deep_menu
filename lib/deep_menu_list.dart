import 'package:deep_menu/deep_menu.dart';
import 'package:flutter/material.dart';

import 'deep_menu_item.dart';

class DeepMenuList extends StatelessWidget {
  List<DeepMenuItem> items;

  DeepMenuList({required this.items, Key? key}) : super(key: key);

  Decoration divider(BuildContext context) {
    final theme = Theme.of(context);
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(color: theme.dividerColor, width: 1.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            ...items
                .sublist(0, items.length - 1)
                .map((e) => Container(
                      decoration: divider(context),
                      child: e,
                    ))
                .toList(),
            items.last
          ],
        ));
  }
}
