import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/main.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoginTab = false; // false = Agza bolmak tab active
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreed = true;

  String _selectedRole = 'Ulanyjy';
  final List<String> _roles = ['Ulanyjy', 'Hünärmen', 'Kompaniýa'];

  final TextEditingController _nameController =
      TextEditingController();
  final TextEditingController _phoneController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();
  final TextEditingController _confirmController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5);
    final cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A2E);
    final hintColor = isDark ? Colors.white38 : Colors.black38;
    final inputBg = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF7F7F7);
    final borderColor = isDark ? const Color(0xFF333333) : const Color(0xFFE0E0E0);
    final activeBorderColor = const Color(0xFF3D5AFE);
    const blue = Color(0xFF3D5AFE);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: textColor, size: 20),
                    onPressed: () => context.go('/walkthrough'),
                  ),
                  Text(
                    'Agza bolmak',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
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
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tab switcher
                    Container(
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor),
                      ),
                      child: Row(
                        children: [
                          _buildTab('Hasaba durmak', true, cardBg, textColor, borderColor),
                          _buildTab('Agza bolmak', false, cardBg, textColor, borderColor),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Wezipeler
                    Text('Wezipeler',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
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
                            .map((r) => DropdownMenuItem(
                                value: r,
                                child: Text(r,
                                    style: TextStyle(color: textColor))))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _selectedRole = v ?? _selectedRole),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Ady Familýasy
                    Text('Ady Familýasy',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    _inputField(
                      controller: _nameController,
                      inputBg: inputBg,
                      borderColor: activeBorderColor, // active = blue border
                      textColor: textColor,
                      hintColor: hintColor,
                      suffix: IconButton(
                        icon: Icon(Icons.cancel, color: hintColor, size: 18),
                        onPressed: () => _nameController.clear(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Telefon belgiňiz
                    Text('Telefon belgiňiz',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: inputBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor),
                          ),
                          child: Center(
                            child: Text('+993',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _inputField(
                            controller: _phoneController,
                            inputBg: inputBg,
                            borderColor: borderColor,
                            textColor: textColor,
                            hintColor: hintColor,
                            keyboardType: TextInputType.phone,
                            suffix: IconButton(
                              icon:
                                  Icon(Icons.cancel, color: hintColor, size: 18),
                              onPressed: () => _phoneController.clear(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Açar sözi
                    Text('Açar sözi',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    _inputField(
                      controller: _passwordController,
                      inputBg: inputBg,
                      borderColor: borderColor,
                      textColor: textColor,
                      hintColor: hintColor,
                      obscure: false, // showing plain text as in screenshot
                      suffix: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: hintColor,
                          size: 20,
                        ),
                        onPressed: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Açar sözüňizi tassyklaň
                    Text('Açar sözüňizi tassyklaň',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    _inputField(
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

                    const SizedBox(height: 16),

                    // Agree checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _agreed,
                          activeColor: blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          onChanged: (v) =>
                              setState(() => _agreed = v ?? false),
                        ),
                        Text(
                          'Düzgünler bilen tanyşdym?',
                          style: TextStyle(
                            color: blue,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Sign up button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(
    String label,
    bool isLogin,
    Color cardBg,
    Color textColor,
    Color borderColor,
  ) {
    final isActive = (_isLoginTab == isLogin);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (isLogin) {
            context.go('/login');
          } else {
            setState(() => _isLoginTab = false);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? cardBg : Colors.transparent,
            borderRadius: BorderRadius.circular(11),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? textColor : Colors.grey,
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
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