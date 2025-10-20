import 'package:flutter/material.dart';
import 'package:vistacall/utils/constants.dart';

class DoctorGridItem extends StatefulWidget {
  final String title;
  final String imagePath;
  final int index;
  final VoidCallback? onTap;

  const DoctorGridItem({
    super.key,
    required this.title,
    required this.imagePath,
    this.index = 0,
    this.onTap,
  });

  @override
  State<DoctorGridItem> createState() => _DoctorGridItemState();
}

class _DoctorGridItemState extends State<DoctorGridItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  // Beautiful gradient colors for each category
  final List<List<Color>> _gradients = [
    [Color(0xFFFF6B9D), Color(0xFFFFA07A)], // Pink-Coral
    [Color(0xFF6B8EFF), Color(0xFF9DB4FF)], // Blue-Lavender
    [Color(0xFF7B68EE), Color(0xFFB19CD9)], // Purple-Lilac
    [Color(0xFFFF8C42), Color(0xFFFFB366)], // Orange-Peach
    [Color(0xFF4ECDC4), Color(0xFF7FE7DB)], // Teal-Mint
    [Color(0xFFFFD166), Color(0xFFFFE499)], // Yellow-Gold
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Color> _getGradient() {
    return _gradients[widget.index % _gradients.length];
  }

  @override
  Widget build(BuildContext context) {
    final gradient = _getGradient();

    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: gradient[0].withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    blurRadius: 8,
                    offset: const Offset(-2, -2),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Subtle shine effect
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.4),
                            Colors.white.withOpacity(0.0),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Image.asset(
                          widget.imagePath,
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.medical_services_rounded,
                              size: 36,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C2C2C),
                  height: 1.2,
                  letterSpacing: -0.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


