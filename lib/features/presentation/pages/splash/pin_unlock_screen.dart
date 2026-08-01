import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/api_service.dart';
import 'package:komekchi_service/core/utils/pin_storage.dart';
import 'package:komekchi_service/core/utils/theme/app_colors.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/pin_numpad.dart';
import 'package:komekchi_service/l10n/gen/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App-start gate shown when the user is logged in and has PIN lock
/// enabled — blocks access to the rest of the app until the stored PIN
/// is entered correctly.
class PinUnlockScreen extends StatefulWidget {
  const PinUnlockScreen({super.key});

  @override
  State<PinUnlockScreen> createState() => _PinUnlockScreenState();
}

class _PinUnlockScreenState extends State<PinUnlockScreen> {
  static const int _pinLength = 4;

  String _pin = '';
  String? _error;
  bool _checking = false;

  void _onDigit(String digit) {
    if (_pin.length >= _pinLength || _checking) return;
    setState(() {
      _error = null;
      _pin += digit;
    });
    if (_pin.length == _pinLength) {
      Future.delayed(const Duration(milliseconds: 150), _verify);
    }
  }

  void _onBackspace() {
    if (_pin.isEmpty || _checking) return;
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  Future<void> _verify() async {
    setState(() => _checking = true);

    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(pinCodeStorageKey);

    if (!mounted) return;

    if (stored != null && stored == _pin) {
      context.go('/main');
      return;
    }

    setState(() {
      _checking = false;
      _pin = '';
      _error = AppLocalizations.of(context)!.pinWrong;
    });
  }

  Future<void> _forgotPin() async {
    await ApiService().logout();
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColor.primary,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColor.primary,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Image.asset("assets/images/logo/logo.png", width: 56, height: 67),
            const SizedBox(height: 20),
            Icon(
              Icons.lock_outline,
              color: Colors.white.withValues(alpha: 0.9),
              size: 28,
            ),
            const SizedBox(height: 12),
            Text(
              t.pinCode,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                t.pinUnlockSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.75),
                ),
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: const TextStyle(fontSize: 13, color: Colors.redAccent),
              ),
            ],
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pinLength, (i) {
                final filled = i < _pin.length;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: filled ? Colors.white : Colors.transparent,
                      border: const Border.fromBorderSide(
                        BorderSide(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _forgotPin,
              child: Text(
                t.forgotPinCode,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
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
