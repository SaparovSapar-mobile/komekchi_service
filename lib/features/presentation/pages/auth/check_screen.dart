import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({super.key});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen>
    with TickerProviderStateMixin {
  late AnimationController _circleController;
  late AnimationController _checkController;
  late AnimationController _textController;
  late AnimationController _buttonController;

  late Animation<double> _circleScale;
  late Animation<double> _circleOpacity;
  late Animation<double> _checkProgress;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _buttonOpacity;
  late Animation<Offset> _buttonSlide;

  @override
  void initState() {
    super.initState();

    // Circle pop-in
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _circleScale = CurvedAnimation(
      parent: _circleController,
      curve: Curves.elasticOut,
    );
    _circleOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _circleController,
        curve: const Interval(0, 0.3, curve: Curves.easeIn),
      ),
    );

    // Checkmark draw
    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _checkProgress = CurvedAnimation(
      parent: _checkController,
      curve: Curves.easeInOut,
    );

    // Text fade+slide
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _textOpacity = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    // Button fade+slide
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _buttonOpacity = CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeIn,
    );
    _buttonSlide = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
        );

    _playSequence();
  }

  Future<void> _playSequence() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await _circleController.forward();
    await _checkController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    _textController.forward();
    await Future.delayed(const Duration(milliseconds: 150));
    _buttonController.forward();
  }

  @override
  void dispose() {
    _circleController.dispose();
    _checkController.dispose();
    _textController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF121212) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A2E);
    const blue = Color(0xFF264FED);
    const green = Color(0xFF4CAF50);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Stack(
          children: [
            // Centered icon + text
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated circle + checkmark
                  ScaleTransition(
                    scale: _circleScale,
                    child: FadeTransition(
                      opacity: _circleOpacity,
                      child: SizedBox(
                        width: 72,
                        height: 72,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Circle border
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: green, width: 2.5),
                              ),
                            ),
                            // Animated checkmark
                            AnimatedBuilder(
                              animation: _checkProgress,
                              builder: (_, __) => CustomPaint(
                                size: const Size(36, 36),
                                painter: _CheckmarkPainter(
                                  progress: _checkProgress.value,
                                  color: green,
                                  strokeWidth: 2.8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // "Tassyklandy!" text
                  SlideTransition(
                    position: _textSlide,
                    child: FadeTransition(
                      opacity: _textOpacity,
                      child: Text(
                        'Tassyklandy!',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom button
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: SlideTransition(
                position: _buttonSlide,
                child: FadeTransition(
                  opacity: _buttonOpacity,
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () => context.go('/main'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Dowam etmek',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Draws a checkmark progressively from 0.0 to 1.0
class _CheckmarkPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  const _CheckmarkPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Checkmark path: two segments
    // Start → mid → end
    final start = Offset(size.width * 0.18, size.height * 0.52);
    final mid = Offset(size.width * 0.42, size.height * 0.74);
    final end = Offset(size.width * 0.82, size.height * 0.28);

    final totalLength = (mid - start).distance + (end - mid).distance;
    final drawn = totalLength * progress;

    final path = Path();
    path.moveTo(start.dx, start.dy);

    final seg1 = (mid - start).distance;

    if (drawn <= seg1) {
      // Still on first segment
      final t = drawn / seg1;
      final p = Offset.lerp(start, mid, t)!;
      path.lineTo(p.dx, p.dy);
    } else {
      // First segment complete, draw into second
      path.lineTo(mid.dx, mid.dy);
      final remaining = drawn - seg1;
      final seg2 = (end - mid).distance;
      final t = (remaining / seg2).clamp(0.0, 1.0);
      final p = Offset.lerp(mid, end, t)!;
      path.lineTo(p.dx, p.dy);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CheckmarkPainter old) => old.progress != progress;
}
