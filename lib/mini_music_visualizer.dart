library mini_music_visualizer;

import "package:flutter/material.dart";

class MiniMusicVisualizer extends StatelessWidget {
  const MiniMusicVisualizer({
    Key? key,
    this.color,
    this.width,
    this.height,
  }) : super(key: key);

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final List<int> duration = [900, 800, 700, 600, 500];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: VisualComponent(
            curve: Curves.bounceOut,
            duration: duration[index % 5],
            color: color ?? Theme.of(context).colorScheme.secondary,
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}

class VisualComponent extends StatefulWidget {
  const VisualComponent({
    Key? key,
    required this.duration,
    required this.color,
    required this.curve,
    this.width,
    this.height,
  }) : super(key: key);

  final int duration;
  final Color color;
  final Curve curve;
  final double? width;
  final double? height;

  @override
  _VisualComponentState createState() => _VisualComponentState();
}

class _VisualComponentState extends State<VisualComponent>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  late double width;
  late double height;

  @override
  void initState() {
    super.initState();
    width = widget.width ?? 4;
    height = widget.height ?? 15;
    animate();
  }

  void animate() {
    animationController = AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this);
    final curvedAnimation =
        CurvedAnimation(parent: animationController, curve: widget.curve);
    animation = Tween<double>(begin: 2, end: height)
        .animate(curvedAnimation)
      ..addListener(() {
        update();
      });
    animationController.repeat(reverse: true);
  }

  void update() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: animation.value,
          decoration: BoxDecoration(
            color: widget.color,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animation.removeListener(() {});
    animation.removeStatusListener((status) {});
    animationController.stop();
    animationController.reset();
    animationController.dispose();
    super.dispose();
  }
}
