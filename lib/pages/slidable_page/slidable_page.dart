import 'package:flutter/material.dart';

import '../../widgets/slidable_widget.dart';

class SlidablePage extends StatefulWidget {
  const SlidablePage({
    Key? key,
  }) : super(key: key);

  @override
  State<SlidablePage> createState() => _SlidablePageState();
}

class _SlidablePageState extends State<SlidablePage>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: -1,
      upperBound: 1,
      value: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Slidable'),
      ),
      body: Column(
        children: [
          const Text('Single drag'),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (_, index) {
                return SlidableWidget(
                  //controller: animationController,
                  onSlide: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.orange,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 16,
                    ),
                    child: const Text('drag left or right'),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          const Text('Multi drag'),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (_, index) {
                return SlidableWidget(
                  controller: animationController,
                  onSlide: () {},
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.orange,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 16,
                    ),
                    child: const Text('multi drag left or right'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
