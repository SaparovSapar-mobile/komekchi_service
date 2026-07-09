part of '../auth_screen.dart.dart';

extension AuthLoginForm on _AuthScreenState {
  // ─── LOGIN FORM ─────────────────────────────────────────────────────────────

  Widget _buildLoginForm(
    bool isDark,
    Color cardBg,
    Color textColor,
    Color borderColor,
  ) {
    final inputBg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final hintColor = isDark ? Colors.white38 : Colors.black38;
    const blue = AppColor.primary;
    final isEmail = _methodTabController.index == 1;

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
          isEmail ? 'Email' : 'Telefon belgiňiz',
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        isEmail
            ? inputField(
                controller: _loginEmailController,
                inputBg: inputBg,
                text: "Emailyňyzy giriziň",
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
          'Açar sözi',
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        inputField(
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
            "Açar sözi ýatdan çykardym",
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
                if (context.mounted) context.go("/main");
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Ýalňyşlyk: $e')));
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
            child: const Text(
              'Tassyklamak',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
              'Agza bolmak',
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
