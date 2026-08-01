part of '../auth_screen.dart.dart';

extension AuthRegisterForm on _AuthScreenState {
  // ─── REGISTER FORM ──────────────────────────────────────────────────────────

  Widget _buildRegisterForm(
    bool isDark,
    Color cardBg,
    Color textColor,
    Color borderColor,
  ) {
    final inputBg = AppColor.pageBg(context);
    final hintColor = AppColor.titleText(context);
    const blue = AppColor.primary;
    final isEmail = _methodTabController.index == 1;
    final t = AppLocalizations.of(context)!;

    Color fieldBorder(TextEditingController controller) =>
        _showRegisterErrors && controller.text.trim().isEmpty
            ? Colors.red
            : borderColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 8),
          // Text(
          //   'Wezipeler',
          //   style: TextStyle(
          //     color: textColor,
          //     fontSize: 14,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
          // const SizedBox(height: 8),
          // Container(
          //   height: 52,
          //   decoration: BoxDecoration(
          //     color: inputBg,
          //     borderRadius: BorderRadius.circular(12),
          //     border: Border.all(color: borderColor),
          //   ),
          //   padding: const EdgeInsets.symmetric(horizontal: 14),
          //   child: DropdownButton<String>(
          //     value: _selectedRole,
          //     isExpanded: true,
          //     underline: const SizedBox(),
          //     dropdownColor: cardBg,
          //     style: TextStyle(color: textColor, fontSize: 15),
          //     icon: Icon(Icons.keyboard_arrow_down, color: hintColor),
          //     items: _roles
          //         .map(
          //           (r) => DropdownMenuItem(
          //             value: r,
          //             child: Text(r, style: TextStyle(color: textColor)),
          //           ),
          //         )
          //         .toList(),
          //     onChanged: (v) =>
          //         _refresh(() => _selectedRole = v ?? _selectedRole),
          //   ),
          // ),

          const SizedBox(height: 16),

          // Ady Familýasy
          Text(
            t.nameLabel,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          inputField(
            context: context,
            controller: _nameController,
            inputBg: inputBg,
            text: t.nameHint,
            borderColor: fieldBorder(_nameController),
            textColor: textColor,
            hintColor: Colors.grey,
          ),

          const SizedBox(height: 16),

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
                  controller: _regEmailController,
                  inputBg: inputBg,
                  text: t.emailHint,
                  borderColor: fieldBorder(_regEmailController),
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
                        controller: _regPhoneController,
                        inputBg: inputBg,
                        type: FieldType.phone,
                        borderColor: fieldBorder(_regPhoneController),
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
            controller: _regPasswordController,
            inputBg: inputBg,
            borderColor: fieldBorder(_regPasswordController),
            textColor: textColor,
            hintColor: hintColor,
            obscure: _obscureRegPassword,
            suffix: IconButton(
              icon: Icon(
                _obscureRegPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: hintColor,
                size: 20,
              ),
              onPressed: () =>
                  _refresh(() => _obscureRegPassword = !_obscureRegPassword),
            ),
          ),

          const SizedBox(height: 16),

          // Confirm password
          Text(
            t.confirmPasswordLabel,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          inputField(
            context: context,
            controller: _confirmController,
            inputBg: inputBg,
            borderColor: fieldBorder(_confirmController),
            textColor: textColor,
            hintColor: hintColor,
            obscure: _obscureConfirm,
            suffix: IconButton(
              icon: Icon(
                _obscureConfirm
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: hintColor,
                size: 20,
              ),
              onPressed: () =>
                  _refresh(() => _obscureConfirm = !_obscureConfirm),
            ),
          ),

          const SizedBox(height: 12),

          // Checkbox
          Row(
            children: [
              Checkbox(
                value: _agreed,
                activeColor: blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (v) => _refresh(() => _agreed = v ?? false),
              ),
              Text(
                t.agreeTerms,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _agreed
                  ? () async {
                      final requiredControllers = [
                        _nameController,
                        isEmail ? _regEmailController : _regPhoneController,
                        _regPasswordController,
                        _confirmController,
                      ];
                      final hasEmptyField = requiredControllers.any(
                        (c) => c.text.trim().isEmpty,
                      );
                      if (hasEmptyField) {
                        _refresh(() => _showRegisterErrors = true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(t.fillAllFields)),
                        );
                        return;
                      }
                      try {
                        if (isEmail) {
                          await ApiService().registerWithEmail(
                            name: _nameController.text.trim(),
                            email: _regEmailController.text.trim(),
                            password: _regPasswordController.text,
                          );
                        } else {
                          final phone =
                              '+993${_regPhoneController.text.trim()}';
                          await ApiService().registerWithPhone(
                            name: _nameController.text.trim(),
                            phone: phone,
                            password: _regPasswordController.text,
                          );
                        }
                        if (context.mounted) context.push("/smsscreen");
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(t.errorPrefix('$e'))),
                        );
                      }
                    }
                  : null,
              child: Text(
                t.sendCode,
                style: textStyle1.copyWith(color: AppColor.titleDark),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
