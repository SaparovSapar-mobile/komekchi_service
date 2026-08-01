import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/features/presentation/pages/home/settings/bottom_sheet.dart';

import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/gen/app_localizations.dart';

class ForgotPass extends StatefulWidget {
  final bool showLogin;
  const ForgotPass({super.key, this.showLogin = true});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass>
    with SingleTickerProviderStateMixin {
  late bool _showLogin;

  bool _obscureLoginPassword = true;
  final TextEditingController _loginPhoneController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  final TextEditingController _confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showLogin = widget.showLogin;
  }

  @override
  void dispose() {
    _loginPhoneController.dispose();
    _loginPasswordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = AppColor.cardBg(context);
    final cardBg = AppColor.cardBg(context);
    final textColor = AppColor.titleText(context);
    final borderColor = AppColor.border(context);
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: textColor,
                      size: 20,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      t.authLoginTitle,
                      key: ValueKey(_showLogin),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: !isDark
                        ? Image.asset(
                            "assets/images/logo/bedtime1.png",
                            width: 36,
                            height: 36,
                          )
                        : Image.asset(
                            "assets/images/logo/bedtime_dark.png",
                            width: 36,
                            height: 36,
                          ),
                    onPressed: () => toggleAppTheme(),
                  ),
                ],
              ),
            ),
            // DividerWidget(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Animated content switch
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      transitionBuilder: (child, animation) {
                        final offset = _showLogin
                            ? const Offset(-1, 0)
                            : const Offset(1, 0);
                        return SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: offset,
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeInOut,
                                ),
                              ),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: _buildLoginForm(
                        isDark,
                        cardBg,
                        textColor,
                        borderColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm(
    bool isDark,
    Color cardBg,
    Color textColor,
    Color borderColor,
  ) {
    final inputBg = AppColor.pageBg(context);
    final hintColor = isDark ? Colors.white38 : Colors.black38;
    const blue = AppColor.primary;
    final t = AppLocalizations.of(context)!;

    return Column(
      key: const ValueKey('login'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            "assets/images/logo/phone.png",
            height: 30,
            width: 30,
          ),
        ),
        const SizedBox(height: 32),

        // Phone
        Text(
          t.phoneLabel,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _codeBox('+993', textColor, inputBg, borderColor),
            const SizedBox(width: 10),
            Expanded(
              child: _inputField(
                controller: _loginPhoneController,
                inputBg: inputBg,
                borderColor: borderColor,
                textColor: textColor,
                hintColor: hintColor,
                keyboardType: TextInputType.phone,
                suffix: IconButton(
                  icon: Icon(Icons.cancel, color: hintColor, size: 18),
                  onPressed: () => _loginPhoneController.clear(),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Password
        Text(
          t.passwordLabel,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        _inputField(
          controller: _loginPasswordController,
          inputBg: inputBg,
          borderColor: borderColor,
          textColor: textColor,
          hintColor: hintColor,
          obscure: _obscureLoginPassword,
          suffix: IconButton(
            icon: Icon(
              _obscureLoginPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: hintColor,
              size: 20,
            ),
            onPressed: () =>
                setState(() => _obscureLoginPassword = !_obscureLoginPassword),
          ),
        ),

        SizedBox(height: 10),
        Text(
          t.repeatPasswordLabel,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        _inputField(
          controller: _confirmController,
          inputBg: inputBg,
          borderColor: borderColor,
          textColor: textColor,
          hintColor: hintColor,
          obscure: _obscureLoginPassword,
          suffix: IconButton(
            icon: Icon(
              _obscureLoginPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: hintColor,
              size: 20,
            ),
            onPressed: () =>
                setState(() => _obscureLoginPassword = !_obscureLoginPassword),
          ),
        ),
        const SizedBox(height: 36),

        // Login button
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () => context.push("/sms"),
            style: ElevatedButton.styleFrom(
              backgroundColor: blue,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              t.confirmShort,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  // ─── REGISTER FORM ─────────────────────────────────────────────────────────

  Widget _codeBox(
    String code,
    Color textColor,
    Color inputBg,
    Color borderColor,
  ) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: inputBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Center(
        child: Text(
          code,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required Color inputBg,
    required Color borderColor,
    required Color textColor,
    required Color hintColor,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffix,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: inputBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              keyboardType: keyboardType,
              style: TextStyle(color: textColor, fontSize: 15),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                hintStyle: TextStyle(color: hintColor),
              ),
            ),
          ),
          if (suffix != null) suffix,
        ],
      ),
    );
  }
}
