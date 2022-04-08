import 'package:deep_menu/deep_menu.dart';
import 'package:deep_menu/deep_menu_list.dart';
import 'package:flutter/material.dart';

import 'deep_menu_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
            children: List.generate(
          100,
          (index) => DeepMenu(
              child: MessageCard(title: "Message $index"),
              bodyMenu: _buildMenu(context),
              headMenu: Material(
                child: 
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.person)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.person)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.person)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.person)),
                  ],),
                )
              )),
        ).toList()));
  }

  Widget _buildMenu(BuildContext context) {
    return DeepMenuList(items: [
      DeepMenuItem(
          label: const Text("Save"),
          icon: const Icon(Icons.save),
          onTap: () {
            Navigator.pop(context);
            print('SAVE');
          }),
      DeepMenuItem(
          label: const Text(
            "Delete",
            style: TextStyle(color: Colors.red),
          ),
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onTap: () {
            Navigator.pop(context);
            print('SAVE');
          })
    ]);
  }
}

class MessageCard extends StatelessWidget {
  final String title;
  const MessageCard({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: EdgeInsets.all(14),
          child: SizedBox(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text('Description'),
              ],
            ),
          )),
    );
  }
}
