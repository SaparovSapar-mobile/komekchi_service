import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/pin_storage.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/pin_numpad.dart';
import 'package:komekchi_service/l10n/gen/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/utils/theme/app_colors.dart';
import '../../home_screen.dart';

enum _PinStage { enter, confirm }

/// Sets or changes the app-lock PIN: enter 4 digits, then re-enter to
/// confirm. On match, saves the PIN and marks the lock as enabled, then
/// pops with `true`. Backing out (or a mismatch loop) leaves nothing saved.
class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({super.key});

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  static const int _pinLength = 4;

  _PinStage _stage = _PinStage.enter;
  String _pin = '';
  String _firstEntry = '';
  String? _error;

  void _onDigit(String digit) {
    if (_pin.length >= _pinLength) return;
    setState(() {
      _error = null;
      _pin += digit;
    });
    if (_pin.length == _pinLength) {
      Future.delayed(const Duration(milliseconds: 150), _onComplete);
    }
  }

  void _onBackspace() {
    if (_pin.isEmpty) return;
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  Future<void> _onComplete() async {
    if (!mounted) return;

    if (_stage == _PinStage.enter) {
      setState(() {
        _firstEntry = _pin;
        _pin = '';
        _stage = _PinStage.confirm;
      });
      return;
    }

    if (_pin != _firstEntry) {
      setState(() {
        _error = AppLocalizations.of(context)!.pinMismatch;
        _pin = '';
        _firstEntry = '';
        _stage = _PinStage.enter;
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(pinCodeStorageKey, _pin);
    await prefs.setBool(pinEnabledStorageKey, true);
    if (mounted) context.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColor.pageBg(context);
    final cardBg = AppColor.cardBg(context);
    final textColor = AppColor.titleText(context);
    final borderColor = AppColor.border(context);
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColor.primary,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            AppBarWidget(textColor, isDark),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: textColor,
                    ),
                  ),
                  Text('Yza', style: TextStyle(fontSize: 16, color: textColor)),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColor.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.lock,
                      color: AppColor.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t.pinCode,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _stage == _PinStage.enter
                        ? t.pinCreateSubtitle
                        : t.pinConfirmSubtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColor.descriptionText(context),
                    ),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _error!,
                      style: const TextStyle(fontSize: 13, color: Colors.red),
                    ),
                  ],
                  const SizedBox(height: 20),

                  Row(
                    children: List.generate(_pinLength, (i) {
                      final filled = i < _pin.length;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: 48,
                          height: 48,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: filled ? AppColor.primary : borderColor,
                            ),
                          ),
                          child: filled
                              ? Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: AppColor.primary,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : null,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            const Spacer(),

            PinNumpad(onDigit: _onDigit, onBackspace: _onBackspace),
          ],
        ),
      ),
    );
  }
}
