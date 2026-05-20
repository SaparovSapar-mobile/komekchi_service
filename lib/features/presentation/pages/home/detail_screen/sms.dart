import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/main.dart';

import '../../../../../core/utils/theme/app_colors.dart';

class Sms extends StatefulWidget {
  const Sms({super.key});

  @override
  State<Sms> createState() => _SmsState();
}

class _SmsState extends State<Sms> {
  final int _codeLength = 4;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  // Timer
  int _secondsLeft = 5;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_codeLength, (_) => TextEditingController());
    _focusNodes = List.generate(_codeLength, (_) => FocusNode());
    _startTimer();
    // Auto-focus first field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  void _startTimer() {
    _secondsLeft = 60;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft == 0) {
        t.cancel();
        setState(() => _canResend = true);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _timerText {
    final m = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < _codeLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    // If pasting full code
    if (value.length == _codeLength) {
      for (int i = 0; i < _codeLength; i++) {
        _controllers[i].text = value[i];
      }
      _focusNodes[_codeLength - 1].requestFocus();
    }
    setState(() {});
  }

  void _onKeyEvent(RawKeyEvent event, int index) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
    }
  }

  bool get _isComplete => _controllers.every((c) => c.text.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeBorder = const Color(0xFF3D5AFE);
    final inputBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    const blue = AppColor.primary;


    final bg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    // final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final textColor =  AppColor.titleText(context);
    final borderColor = isDark ? const Color(0xFF333333) : AppColor.borderColor;


    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: textColor,
                          size: 20,
                        ),
                        onPressed: () => context.pop(),
                      ),
                    ),
                    Text(
                      'SMS',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Dark mode toggle (optional — matches other screens)
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          isDark
                              ? Icons.wb_sunny_rounded
                              : Icons.nightlight_round,
                          color: blue,
                          size: 22,
                        ),
                        onPressed: () {
                          themeNotifier.value =
                              themeNotifier.value == ThemeMode.light
                              ? ThemeMode.dark
                              : ThemeMode.light;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // SMS icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E1E2E)
                      : const Color(0xFFEEF0FF),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: blue,
                  size: 30,
                ),
              ),

              const SizedBox(height: 27),

              Text(
                'Telefon belgiňize gelen kody giriziň',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 32),

              // OTP boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_codeLength, (index) {
                  final hasValue = _controllers[index].text.isNotEmpty;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (event) => _onKeyEvent(event, index),
                      child: SizedBox(
                        width: 56,
                        height: 60,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(
                            color: textColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: inputBg,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: hasValue ? activeBorder : borderColor,
                                width: hasValue ? 1.5 : 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: activeBorder,
                                width: 1.5,
                              ),
                            ),
                          ),
                          onChanged: (value) => _onChanged(value, index),
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              // Timer + resend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _canResend ? '00:00' : _timerText,
                    style: TextStyle(
                      color: Color(0xFF264FED),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _canResend ? _startTimer : null,
                    child: Text(
                      'Kody täzeden ugratmak',
                      style: TextStyle(
                        color: _canResend ? textColor : const Color(0xFF90979F),
                        fontSize: 15,
                        fontWeight: _canResend
                            ? FontWeight.w500
                            : FontWeight.w400,
                        decoration: _canResend
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 44),

              // Confirm button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isComplete
                      ? () => context.go("/main")
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF264FED),
                    disabledBackgroundColor: Color(0xFF264FED).withOpacity(0.5),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Tassyklamak',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
