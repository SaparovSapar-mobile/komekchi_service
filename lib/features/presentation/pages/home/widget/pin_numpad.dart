import 'package:flutter/material.dart';

import 'package:komekchi_service/core/utils/theme/app_colors.dart';

/// Shared 0-9 + backspace numpad used by both the PIN-setup screen
/// (settings) and the app-start PIN-unlock gate.
class PinNumpad extends StatelessWidget {
  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;

  const PinNumpad({super.key, required this.onDigit, required this.onBackspace});

  static const _keys = [
    ['1', ''],
    ['2', 'ABC'],
    ['3', 'DEF'],
    ['4', 'GHI'],
    ['5', 'JKL'],
    ['6', 'MNO'],
    ['7', 'PQRS'],
    ['8', 'TUV'],
    ['9', 'WXYZ'],
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final keyBg = isDark ? AppColor.bgBlogDark : Colors.white;
    final padBg = isDark ? AppColor.bgPageDark : const Color(0xFFECECEC);
    final textColor = AppColor.titleText(context);

    return Container(
      width: double.infinity,
      color: padBg,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var row = 0; row < 3; row++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: List.generate(3, (col) {
                  final key = _keys[row * 3 + col];
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: _PinNumKey(
                        digit: key[0],
                        letters: key[1],
                        bg: keyBg,
                        textColor: textColor,
                        onTap: () => onDigit(key[0]),
                      ),
                    ),
                  );
                }),
              ),
            ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: _PinNumKey(
                    digit: '0',
                    letters: '',
                    bg: keyBg,
                    textColor: textColor,
                    onTap: () => onDigit('0'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: onBackspace,
                    child: SizedBox(
                      height: 56,
                      child: Icon(
                        Icons.backspace_outlined,
                        color: textColor.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PinNumKey extends StatelessWidget {
  final String digit;
  final String letters;
  final Color bg;
  final Color textColor;
  final VoidCallback onTap;

  const _PinNumKey({
    required this.digit,
    required this.letters,
    required this.bg,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              digit,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            if (letters.isNotEmpty)
              Text(
                letters,
                style: TextStyle(
                  fontSize: 9,
                  letterSpacing: 1,
                  color: textColor.withValues(alpha: 0.5), 
                ),
              ),
          ],
        ),
      ),
    );
  }
}
