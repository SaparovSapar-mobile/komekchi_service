import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NagilelikBottom extends StatelessWidget {

  const NagilelikBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: Container(
            width: 73,
            height: 6,
            decoration: BoxDecoration(
              color: Color(0xFFD1D1D1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              const SizedBox(height: 20),
              // Title
              const Text(
                'Sazlamalar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Buttons row
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  context.push('/nagilelik');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F0FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(
                          "assets/images/logo/flag.png",
                          width: 26,
                          height: 26,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Nagilelik bildirmek',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 36),
            ],
          ),
        ),
      ],
    );
  }
}
