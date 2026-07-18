import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/api_service.dart';
import '../../../../core/utils/theme/app_colors.dart';

class SmsScreen extends StatefulWidget {
  const SmsScreen({super.key});

  @override
  State<SmsScreen> createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  // Telefon arkaly bellige durulsa 4 sanly kod, email arkaly bolsa 6 sanly.
  int _codeLength = 4;
  String _otpChannel = 'phone';
  bool _isReady = false;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  // Timer
  int _secondsLeft = 5;
  Timer? _timer;
  bool _canResend = false;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final channel = prefs.getString('otp_channel') ?? 'phone';

    setState(() {
      _otpChannel = channel;
      _codeLength = channel == 'email' ? 6 : 4;
      _controllers = List.generate(_codeLength, (_) => TextEditingController());
      _focusNodes = List.generate(_codeLength, (_) => FocusNode());
      _isReady = true;
    });

    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_focusNodes.isNotEmpty) _focusNodes[0].requestFocus();
    });
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsLeft = 60;
      _canResend = false;
    });
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
    if (_isReady) {
      for (final c in _controllers) {
        c.dispose();
      }
      for (final f in _focusNodes) {
        f.dispose();
      }
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

  Future<void> _onConfirm() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final code = _controllers.map((c) => c.text).join();

      if (_otpChannel == 'email') {
        final email = prefs.getString('email');
        if (email == null) throw Exception('Email tapylmady');
        await ApiService().verifyEmail(email: email, code: code);
      } else {
        final phone = prefs.getString('phone');
        if (phone == null) throw Exception('Telefon belgisi tapylmady');
        await ApiService().confirmPhoneOtp(phone: phone, code: code);
      }

      if (mounted) context.go('/check');
    } catch (e) {
      setState(() => _error = 'Ýalňyşlyk: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final cardBg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final textColor = AppColor.titleText(context);
    final borderColor = isDark ? const Color(0xFF333333) : AppColor.borderColor;

    if (!_isReady) {
      return Scaffold(
        backgroundColor: bg,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
        ),
      ),
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
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
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // SMS icon
              Container(
                width: 59,
                height: 59,
                decoration: BoxDecoration(
                  color: isDark ? AppColor.bgPageDark : AppColor.bgPageLight,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    "assets/images/logo/sms.png",
                    height: 20,
                    width: 20,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              Text(
                _otpChannel == 'email'
                    ? 'E-poçtaňyza gelen kody giriziň'
                    : 'Telefon belgiňize gelen kody giriziň',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 32),

              // OTP boxes — box width adapts to _codeLength (4 for phone,
              // 6 for email) so it never overflows on narrower screens.
              LayoutBuilder(
                builder: (context, constraints) {
                  final perItem = (constraints.maxWidth + 14) / _codeLength;
                  final boxWidth = (perItem - 10).clamp(28.0, 48.0);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_codeLength, (index) {
                      final hasValue = _controllers[index].text.isNotEmpty;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: RawKeyboardListener(
                          focusNode: FocusNode(),
                          onKey: (event) => _onKeyEvent(event, index),
                          child: SizedBox(
                            width: boxWidth,
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
                                fillColor: cardBg,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: hasValue
                                        ? AppColor.primary
                                        : borderColor,
                                    width: hasValue ? 1.5 : 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColor.primary,
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
                  );
                },
              ),

              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ],

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

              const SizedBox(height: 48),

              // Confirm button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isComplete && !_isLoading ? _onConfirm : null,
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Tassyklamak',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF264FED),
                    disabledBackgroundColor: Color(0xFF264FED).withOpacity(0.5),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
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
