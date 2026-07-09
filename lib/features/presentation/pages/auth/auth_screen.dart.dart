import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/app_text_style.dart';
import 'package:komekchi_service/main.dart';

import '../../../../core/api_service.dart';
import '../../../../core/utils/theme/app_colors.dart';
import 'parts/auth_helper.dart';

part 'parts/login_form.dart';
part 'parts/register_form.dart';

class AuthScreen extends StatefulWidget {
  final bool showLogin;
  const AuthScreen({super.key, this.showLogin = true});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  // Внутренний таб выбора способа входа/регистрации: Telefon belgi / Email
  late TabController _methodTabController;

  bool _obscureLoginPassword = true;
  final TextEditingController _loginPhoneController = TextEditingController();
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  bool _obscureRegPassword = true;
  bool _obscureConfirm = true;
  bool _agreed = true;
  String _selectedRole = 'Ulanyjy';
  final List<String> _roles = ['Ulanyjy', 'Hyzmat Beriji'];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _regPhoneController = TextEditingController();
  final TextEditingController _regEmailController = TextEditingController();
  final TextEditingController _regPasswordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextStyle textStyle1 = AppTextStyle.semiBold16;

  @override
  void initState() {
    super.initState();
    _methodTabController = TabController(length: 2, vsync: this);
    _methodTabController.addListener(() => setState(() {}));
  }

  // setState — protected member, поэтому недоступен напрямую из extension
  // методов в parts/login_form.dart и parts/register_form.dart.
  void _refresh(VoidCallback fn) => setState(fn);

  @override
  void dispose() {
    _methodTabController.dispose();
    _loginPhoneController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _nameController.dispose();
    _regPhoneController.dispose();
    _regEmailController.dispose();
    _regPasswordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final borderColor = isDark ? const Color(0xFF333333) : AppColor.borderColor;
    final TextStyle textStyle = AppTextStyle.semiBold18;

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
                      color: AppColor.titleText(context),
                      size: 20,
                    ),
                    onPressed: () => context.pop(),
                  ),
                  Text(
                    widget.showLogin ? 'Hasaba durmak' : 'Agza bolmak',
                    style: textStyle.copyWith(
                      color: AppColor.titleText(context),
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
            // ─── TabBar: Telefon belgi / Email ───
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: isDark ? AppColor.bgPageDark : AppColor.bgPageLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _methodTabController,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.all(3),
                  labelColor: AppColor.descriptionText(context),
                  unselectedLabelColor: AppColor.descriptionLight,
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
                    Tab(text: 'Telefon belgi'),
                    Tab(text: 'Email'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: widget.showLogin
                    ? _buildLoginForm(
                        isDark,
                        cardBg,
                        AppColor.titleText(context),
                        borderColor,
                      )
                    : _buildRegisterForm(
                        isDark,
                        cardBg,
                        AppColor.titleText(context),
                        borderColor,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
