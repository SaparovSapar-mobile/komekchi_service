import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showNagilelikBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    // shape: const RoundedRectangleBorder(
    //   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    // ),
    builder: (context) => const _NagilelikBottomSheet(),
  );
}

class _NagilelikBottomSheet extends StatelessWidget {
  const _NagilelikBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Sazlamalar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),

          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              context.push('/nagilelik');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
