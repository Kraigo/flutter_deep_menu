import 'package:flutter/material.dart';
import 'package:deep_menu/deep_menu.dart';

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
        body: CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                // mainAxisSpacing: 10.0,
                // crossAxisSpacing: 10.0,
                // childAspectRatio: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return DeepMenu(
                    child: MessageCard(title: "Message $index"),
                    bodyMenu: _buildMenu(context),
                    headMenu: _buildHeadMenu(context),
                  );
                },
                childCount: 4,
              ),
            ),

            SliverToBoxAdapter(child: Divider(),),

            SliverList(
                delegate: SliverChildListDelegate(List.generate(
              3,
              (index) => DeepMenu(
                child: MessageCard(title: "Body menu only"),
                bodyMenu: _buildMenu(context),
              ),
            ).toList())),

            SliverToBoxAdapter(child: Divider(),),

            SliverList(
                delegate: SliverChildListDelegate(List.generate(
              3,
              (index) => DeepMenu(
                child: MessageCard(title: "Head menu only"),
                headMenu: _buildHeadMenu(context),
              ),
            ).toList())),

            SliverToBoxAdapter(child: Divider(),),

            SliverList(
                delegate: SliverChildListDelegate(List.generate(
              3,
              (index) => DeepMenu(
                child: MessageCard(title: "Body and Head menues"),
                bodyMenu: _buildMenu(context),
                headMenu: _buildHeadMenu(context),
              ),
            ).toList()))
          ],
        ));
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

  Widget _buildHeadMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      height: 50,
      child: Material(
        color: Colors.transparent,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.save)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.zoom_in)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.zoom_out)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.flight))
          ],
        ),
      ),
    );
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
          padding: const EdgeInsets.all(14),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title)
              ],
            ),
          )),
    );
  }
}
