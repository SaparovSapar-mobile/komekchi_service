part of '../auth_screen.dart.dart';

extension AuthLoginForm on _AuthScreenState {
  // ─── LOGIN FORM ─────────────────────────────────────────────────────────────

  Widget _buildLoginForm(
    bool isDark,
    Color cardBg,
    Color textColor,
    Color borderColor,
  ) {
    final inputBg = AppColor.pageBg(context);
    final hintColor = isDark ? Colors.white38 : Colors.black38;
    const blue = AppColor.primary;
    final isEmail = _methodTabController.index == 1;
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),

        Center(
          child: Image.asset(
            "assets/images/logo/phone.png",
            height: 30,
            width: 30,
          ),
        ),
        const SizedBox(height: 32),

        // Telefon / Email
        Text(
          isEmail ? t.tabEmail : t.phoneLabel,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        isEmail
            ? inputField(
                context: context,
                controller: _loginEmailController,
                inputBg: inputBg,
                text: t.emailHint,
                borderColor: borderColor,
                textColor: textColor,
                hintColor: hintColor,
                keyboardType: TextInputType.emailAddress,
              )
            : Row(
                children: [
                  codeBox('+993', textColor, inputBg, borderColor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: inputField(
                      context: context,
                      controller: _loginPhoneController,
                      inputBg: inputBg,
                      type: FieldType.phone,
                      borderColor: borderColor,
                      textColor: textColor,
                      hintColor: hintColor,
                      keyboardType: TextInputType.phone,
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
        inputField(
          context: context,
          controller: _loginPasswordController,
          inputBg: inputBg,
          borderColor: borderColor,
          textColor: textColor,
          type: FieldType.code,
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
                _refresh(() => _obscureLoginPassword = !_obscureLoginPassword),
          ),
        ),

        const SizedBox(height: 10),

        TextButton(
          onPressed: () => context.push('/forgot'),
          child: Text(
            t.forgotPasswordLink,
            style: TextStyle(
              color: isDark ? AppColor.titleDark : AppColor.primary,
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),

        const SizedBox(height: 36),

        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () async {
              try {
                final login = isEmail
                    ? _loginEmailController.text.trim()
                    : '+993${_loginPhoneController.text.trim()}';
                await ApiService().login(
                  login: login,
                  password: _loginPasswordController.text,
                );
                // Backend's user object doesn't always include the phone
                // number — when logging in via the phone tab we already
                // know it for certain, so save it as a safety net for
                // screens that prefill it (e.g. the order form).
                if (!isEmail) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('phone', login);
                }
                if (context.mounted) context.go("/main");
              } on DioException catch (e) {
                // Backend responds 400 with code EE-40101 for a bad
                // login/password combo (confirmed against the live API —
                // it does NOT use 401 for this case).
                final data = e.response?.data;
                final errorCode = data is Map ? data['code']?.toString() : null;
                final wrongPassword =
                    errorCode == 'EE-40101' || e.response?.statusCode == 401;
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      wrongPassword ? t.incorrectPassword : t.errorPrefix('$e'),
                    ),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(t.errorPrefix('$e'))));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: blue,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              t.confirmButton,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,
          height: 54,
          child: OutlinedButton(
            onPressed: () => context.push('/register'),
            style: OutlinedButton.styleFrom(
              backgroundColor: isDark
                  ? AppColor.bgPageDark
                  : AppColor.bgPageLight,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              t.authRegisterTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
