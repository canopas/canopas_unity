import 'package:flutter/material.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'dart:math' as math show sin, pi;

class DelayTween extends Tween<double> {
  DelayTween({super.begin, super.end, required this.delay});
  final double delay;

  @override
  double lerp(double t) =>
      super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}

class ThreeBounceLoading extends StatefulWidget {
  final Color? color;
  final double size;
  final Duration duration;

  const ThreeBounceLoading({
    super.key,
    this.color,
    this.size = 50.0,
    this.duration = const Duration(milliseconds: 1400),
  });

  @override
  State<ThreeBounceLoading> createState() => _ThreeBounceLoadingState();
}

class _ThreeBounceLoadingState extends State<ThreeBounceLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.fromSize(
        size: Size(widget.size * 2, widget.size),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (i) {
            return ScaleTransition(
              scale: DelayTween(
                begin: 0.0,
                end: 1.0,
                delay: i * .2,
              ).animate(_controller),
              child: SizedBox.fromSize(
                size: Size.square(widget.size * 0.5),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class AppCircularProgressIndicator extends StatelessWidget {
  final Color? color;
  final double size;

  const AppCircularProgressIndicator({super.key, this.size = 38, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: size / 9,
          color: color ?? context.colorScheme.primary,
        ),
      ),
    );
  }
}
