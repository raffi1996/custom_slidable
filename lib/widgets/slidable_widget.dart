import 'package:flutter/material.dart';

enum DraggedPosition {
  left,
  right,
  center,
}

class SlidableWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onSlide;

  final AnimationController? controller;

  const SlidableWidget({
    Key? key,
    required this.child,
    this.onSlide,
    this.controller,
  }) : super(key: key);

  @override
  State<SlidableWidget> createState() => _SlidableWidgetState();
}

class _SlidableWidgetState extends State<SlidableWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  bool isSelectedLeft = false;
  bool isSelectedRight = false;

  DraggedPosition draggedPosition = DraggedPosition.center;
  DraggedPosition prevPosition = DraggedPosition.center;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: -1,
        upperBound: 1,
        value: 0,
      );
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: onDragEnd,
      onHorizontalDragStart: onDragStater,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelectedLeft = !isSelectedLeft;
                    });
                  },
                  child: Container(
                    width: 20,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: isSelectedLeft ? Colors.blue : Colors.grey,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    margin: const EdgeInsets.only(
                      right: 16,
                      left: 16,
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color:
                            isSelectedLeft ? Colors.blue : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelectedRight = !isSelectedRight;
                    });
                  },
                  child: Container(
                    width: 20,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: isSelectedRight ? Colors.blue : Colors.grey,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    margin: const EdgeInsets.only(
                      right: 16,
                      left: 16,
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color:
                            isSelectedRight ? Colors.blue : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => SlideTransition(
              position: AlwaysStoppedAnimation(
                Offset(_controller.value, 0),
              ),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }

  void onDragStater(DragStartDetails details) {
    prevPosition = draggedPosition;
  }

  void onDragEnd(DragEndDetails details) {
    final dragRight = details.velocity.pixelsPerSecond.dx > 500;
    final dragLeft = details.velocity.pixelsPerSecond.dx < -500;

    if (dragLeft) {
      draggedPosition = DraggedPosition.left;
      if (draggedPosition == DraggedPosition.left) {
        if (_controller.value != 0 && prevPosition != DraggedPosition.left) {
          _controller.animateTo(
            0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.ease,
          );
          draggedPosition == DraggedPosition.center;
          return;
        }
      }
      setState(() {
        _controller.animateTo(
          -0.1,
          duration: const Duration(milliseconds: 100),
          curve: Curves.ease,
        );
      });

      return;
    }

    if (dragRight) {
      draggedPosition = DraggedPosition.right;
      if (draggedPosition == DraggedPosition.right) {
        if (_controller.value != 0 && prevPosition != DraggedPosition.right) {
          _controller.animateTo(
            0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.ease,
          );
          draggedPosition == DraggedPosition.center;
          return;
        }
      }
      setState(() {
        _controller.animateTo(
          0.1,
          duration: const Duration(milliseconds: 100),
          curve: Curves.ease,
        );
      });
      return;
    }
  }
}
