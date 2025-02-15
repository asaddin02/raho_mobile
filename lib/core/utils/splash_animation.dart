  import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:go_router/go_router.dart';

typedef OnFinishCallback = void Function(GoRouterState state);

class AnimatedSplashScreen extends StatefulWidget {
  final String imagePath;
  final Duration duration;
  final OnFinishCallback onFinish;
  final Size size;

  const AnimatedSplashScreen({
    super.key,
    required this.imagePath,
    this.duration = const Duration(seconds: 2),
    required this.onFinish,
    this.size = const Size(150, 150),
  });

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _loadImage();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final state = GoRouterState.of(context);
        widget.onFinish(state);
      }
    });
  }

  Future<void> _loadImage() async {
    final ImageProvider provider = AssetImage(widget.imagePath);
    final ImageStream stream = provider.resolve(ImageConfiguration());

    final Completer<ui.Image> completer = Completer<ui.Image>();
    final ImageStreamListener listener = ImageStreamListener(
      (ImageInfo frame, bool synchronousCall) {
        completer.complete(frame.image);
      },
    );

    stream.addListener(listener);
    _image = await completer.future;

    setState(() {});
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _image == null
            ? const CircularProgressIndicator()
            : AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: SplashPainter(
                      image: _image!,
                      progress: _animation.value,
                    ),
                    size: widget.size,
                  );
                },
              ),
      ),
    );
  }
}

class SplashPainter extends CustomPainter {
  final ui.Image image;
  final double progress;

  SplashPainter({
    required this.image,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    final dx = (size.width - image.width.toDouble()) / 2;
    final dy = (size.height - image.height.toDouble()) / 2;

    canvas.translate(dx, dy);

    final clipRect = Rect.fromLTRB(
      0,
      0,
      image.width.toDouble() * progress,
      image.height.toDouble(),
    );

    canvas.clipRect(clipRect);
    canvas.drawImage(image, Offset.zero, paint);
  }

  @override
  bool shouldRepaint(covariant SplashPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
