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
                maxCrossAxisExtent: 200.0
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DeepMenu(
                      child: MessageCard(title: "Deep menu $index"),
                      bodyMenu: _buildMenu(context)
                    ),
                  );
                },
                childCount: 2,
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(),
            ),
            SliverList(
                delegate: SliverChildListDelegate(List.generate(
              2,
              (index) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: DeepMenu(
                  child: MessageCard(title: "Body menu $index"),
                  bodyMenu: _buildMenu(context),
                ),
              ),
            ).toList())),
            const SliverToBoxAdapter(
              child: Divider(),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DeepMenu(
                      child: MessageCard(title: "Body and Head $index"),
                      bodyMenu: _buildMenu(context),
                      headMenu: _buildHeadMenu(context),
                    ),
                  );
                },
                childCount: 2,
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(),
            ),
            SliverList(
                delegate: SliverChildListDelegate(List.generate(
              2,
              (index) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: DeepMenu(
                  child: MessageCard(title: "Head menu $index"),
                  headMenu: _buildHeadMenu(context),
                ),
              ),
            ).toList())),
            const SliverToBoxAdapter(
              child: Divider(),
            ),
            SliverList(
                delegate: SliverChildListDelegate(List.generate(
              2,
              (index) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: DeepMenu(
                  child: const MessageCard(title: "Body and Head menues"),
                  bodyMenu: _buildMenu(context),
                  headMenu: _buildHeadMenu(context),
                ),
              ),
            ).toList())),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: DeepMenu(
                    child: const MessageCard(title: "Big element with scroll"),
                    bodyMenu: _buildMenu(context),
                    headMenu: _buildHeadMenu(context),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildMenu(BuildContext context) {
    return DeepMenuList(items: [
      DeepMenuItem(
          label: const Text("Like"),
          icon: const Icon(Icons.favorite_border),
          onTap: () {
            Navigator.pop(context);
            // ignore: avoid_print
            print('LIKE');
          }),
      DeepMenuItem(
          label: const Text("Save"),
          icon: const Icon(Icons.save),
          onTap: () {
            Navigator.pop(context);
            // ignore: avoid_print
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
            // ignore: avoid_print
            print('SAVE');
          })
    ]);
  }

  Widget _buildHeadMenu(BuildContext context) {
    // ignore: prefer_function_declarations_over_variables
    void Function() goBack = () {
      Navigator.pop(context);
    };

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      height: 50,
      child: Material(
        color: Colors.transparent,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          children: [
            IconButton(onPressed: goBack, icon: const Icon(Icons.save)),
            IconButton(onPressed: goBack, icon: const Icon(Icons.edit)),
            IconButton(onPressed: goBack, icon: const Icon(Icons.refresh)),
            IconButton(onPressed: goBack, icon: const Icon(Icons.share)),
            IconButton(onPressed: goBack, icon: const Icon(Icons.person)),
            IconButton(onPressed: goBack, icon: const Icon(Icons.delete)),
            IconButton(onPressed: goBack, icon: const Icon(Icons.zoom_in)),
            IconButton(onPressed: goBack, icon: const Icon(Icons.zoom_out)),
            IconButton(onPressed: goBack, icon: const Icon(Icons.flight))
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
      margin: const EdgeInsets.all(0),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Center(child: Text(title))),
    );
  }
}
