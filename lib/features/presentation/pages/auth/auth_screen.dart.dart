import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/main.dart';

import '../../../../core/utils/theme/app_colors.dart';

class AuthScreen extends StatefulWidget {
  final bool showLogin;
  const AuthScreen({super.key, this.showLogin = true});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool _obscureLoginPassword = true;
  final TextEditingController _loginPhoneController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  bool _obscureRegPassword = true;
  bool _obscureConfirm = true;
  bool _agreed = true;
  String _selectedRole = 'Ulanyjy';
  final List<String> _roles = ['Ulanyjy', 'Hyzmat Beriji'];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _regPhoneController = TextEditingController();
  final TextEditingController _regPasswordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.showLogin ? 0 : 1,
    );
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginPhoneController.dispose();
    _loginPasswordController.dispose();
    _nameController.dispose();
    _regPhoneController.dispose();
    _regPasswordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final textColor = isDark ? AppColor.titleTextDark : AppColor.titleTextLight;
    final borderColor = isDark ? const Color(0xFF333333) : AppColor.borderColor;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ─── Header ───
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
                    onPressed: () => context.pop(),
                  ),
                  Text(
                    _tabController.index == 0 ? 'Hasaba durmak' : 'Agza bolmak',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: Image.asset(
                      isDark
                          ? "assets/images/logo/bedtime_dark.png"
                          : "assets/images/logo/bedtime1.png",
                      width: 36,
                      height: 36,
                    ),
                    onPressed: () {
                      themeNotifier.value =
                          themeNotifier.value == ThemeMode.light
                          ? ThemeMode.dark
                          : ThemeMode.light;
                    },
                  ),
                ],
              ),
            ),
            Container(
              color: isDark ? AppColor.bgPageDark : AppColor.bgPageLight,
              height: 6,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
            ),
            // ─── TabBar ───
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: isDark ? AppColor.bgPageDark : AppColor.bgPageLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.all(3),
                  labelColor: isDark
                      ? AppColor.titleTextDark
                      : AppColor.titleTextLight,
                  unselectedLabelColor: AppColor.descriptionTextLight,
                  labelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Inter",
                    height: 1.2,
                    letterSpacing: 0,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  tabs: const [
                    Tab(text: 'Hasaba durmak'),
                    Tab(text: 'Agza bolmak'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ─── TabBarView (плавное переключение) ───
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // ── Login tab ──
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildLoginForm(
                      isDark,
                      cardBg,
                      textColor,
                      borderColor,
                    ),
                  ),
                  // ── Register tab ──
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildRegisterForm(
                      isDark,
                      cardBg,
                      textColor,
                      borderColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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

        // Phone
        Text(
          'Telefon belgiňiz',
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
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
                setState(() => _obscureLoginPassword = !_obscureLoginPassword),
          ),
        ),

        const SizedBox(height: 10),

        TextButton(
          onPressed: () => context.push('/forgot'),
          child: Text(
            "Açar sözi ýatdan çykardym",
            style: TextStyle(
              color: isDark ? AppColor.titleTextDark : AppColor.primary,
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
            onPressed: () => context.push("/sms"),
            style: ElevatedButton.styleFrom(
              backgroundColor: blue,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Geçmek',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  // ─── REGISTER FORM ──────────────────────────────────────────────────────────

  Widget _buildRegisterForm(
    bool isDark,
    Color cardBg,
    Color textColor,
    Color borderColor,
  ) {
    final inputBg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final hintColor = isDark ? AppColor.titleTextDark : AppColor.titleTextLight;
    const blue = AppColor.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            'Wezipeler',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: inputBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: DropdownButton<String>(
              value: _selectedRole,
              isExpanded: true,
              underline: const SizedBox(),
              dropdownColor: cardBg,
              style: TextStyle(color: textColor, fontSize: 15),
              icon: Icon(Icons.keyboard_arrow_down, color: hintColor),
              items: _roles
                  .map(
                    (r) => DropdownMenuItem(
                      value: r,
                      child: Text(r, style: TextStyle(color: textColor)),
                    ),
                  )
                  .toList(),
              onChanged: (v) =>
                  setState(() => _selectedRole = v ?? _selectedRole),
            ),
          ),

          const SizedBox(height: 16),

          // Ady Familýasy
          Text(
            'Ady Familýasy',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          inputField(
            controller: _nameController,
            inputBg: inputBg,
            text: "Adyňyzy giriziň",
            borderColor: borderColor,
            textColor: textColor,
            hintColor: Colors.grey,
          ),

          const SizedBox(height: 16),

          // Phone
          Text(
            'Telefon belgiňiz',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              codeBox('+993', textColor, inputBg, borderColor),
              const SizedBox(width: 10),
              Expanded(
                child: inputField(
                  controller: _regPhoneController,
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
            controller: _regPasswordController,
            inputBg: inputBg,
            borderColor: borderColor,
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
                  setState(() => _obscureRegPassword = !_obscureRegPassword),
            ),
          ),

          const SizedBox(height: 16),

          // Confirm password
          Text(
            'Açar sözüňizi tassyklaň',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          inputField(
            controller: _confirmController,
            inputBg: inputBg,
            borderColor: borderColor,
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
                  setState(() => _obscureConfirm = !_obscureConfirm),
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
                onChanged: (v) => setState(() => _agreed = v ?? false),
              ),
              Text(
                'Düzgünler bilen tanyşdym?',
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
              onPressed: _agreed ? () => context.push("/sms") : null,
              child: const Text(
                'Agza bol',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColor.titleTextDark,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─── HELPERS ────────────────────────────────────────────────────────────────

Widget codeBox(String code, Color textColor, Color inputBg, Color borderColor) {
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

enum FieldType { phone, code, text }

Widget inputField({
  required TextEditingController controller,
  String? text,
  required Color inputBg,
  required Color borderColor,
  required Color textColor,
  required Color hintColor,
  FieldType type = FieldType.text,
  bool obscure = false,
  TextInputType keyboardType = TextInputType.text,
  Widget? suffix,
  String? Function(String?)? validator,
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
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,
            inputFormatters: type == FieldType.phone
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8),
                  ]
                : [],
            validator:
                validator ??
                (type == FieldType.phone
                    ? (value) {
                        if (value == null || value.length < 8) {
                          return "Dolzhno byt 8 cifr";
                        }
                        return null;
                      }
                    : null),
            style: TextStyle(color: textColor, fontSize: 15),
            decoration: InputDecoration(
              hintText: text,
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
