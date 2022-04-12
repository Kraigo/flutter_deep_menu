<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->
## Features

Opens menu after a long press. Supports the top and bottom menus.

## Demo
![](https://github.com//Kraigo/flutter_deep_menu/blob/master/example/assets/simulator_demo.gif?raw=true)

## Usage

```dart
DeepMenu(
    child: Column(
        children: [
            Card(
                child: Padding(
            padding: EdgeInsets.all(10),
            child: Text("Message!"),
            )),
        ],
    ),
    bodyMenu: Column(
        children: [
            ElevatedButton(onPressed: () {
                Navigator.of(context).pop();
            }, child: Text("Save"))
        ],
    ),
    headMenu: Column(
        children: [
            ElevatedButton(onPressed: () {
                Navigator.of(context).pop();
            }, child: Text("Remove"))
        ],
    ),
)
```
