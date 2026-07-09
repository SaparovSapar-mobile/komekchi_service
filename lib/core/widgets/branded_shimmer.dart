import 'package:flutter/material.dart';

/// Скользящая подсветка поверх [child], без внешних пакетов — крутим
/// линейный градиент через ShaderMask по бесконечному циклу.
class BrandedShimmer extends StatefulWidget {
  final Widget child;
  const BrandedShimmer({super.key, required this.child});

  @override
  State<BrandedShimmer> createState() => _BrandedShimmerState();
}

class _BrandedShimmerState extends State<BrandedShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final slide = _controller.value * 2 - 1; // -1..1
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment(-1 + slide, 0),
            end: Alignment(0 + slide, 0),
            colors: const [
              Color(0xFFE4EAFB),
              Color(0xFFF7F9FF),
              Color(0xFFE4EAFB),
            ],
            stops: const [0.0, 0.5, 1.0],
          ).createShader(bounds),
          child: child,
        );
      },
    );
  }
}

/// Плейсхолдер-карточка с полупрозрачным лого на фоне — используется
/// внутри [BrandedShimmer] пока баннеры/акции/услуги грузятся на Home.
class BrandedShimmerCard extends StatelessWidget {
  final double width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry margin;

  const BrandedShimmerCard({
    super.key,
    required this.width,
    this.height,
    this.borderRadius = 12,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFFEDF1FB),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      alignment: Alignment.center,
      child: Opacity(
        opacity: 0.5,
        child: Image.asset(
          'assets/images/komekci_hyzmat.png',
          width: width * 0.45,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
