import 'package:flutter/material.dart';

import 'pages/slidable_page/slidable_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SlidablePage(),
    );
  }
}
