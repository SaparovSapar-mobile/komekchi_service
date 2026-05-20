import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/app_theme.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/bank_bottomsheet.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../auth/auth_screen.dart.dart';
import 'tolegbottomsheet.dart';

class SelectedDate extends StatefulWidget {
  const SelectedDate({super.key});

  @override
  State<SelectedDate> createState() => _SelectedDateState();
}

class _SelectedDateState extends State<SelectedDate> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedToleg;
  String? _selectedBank;

  final List<String> tolegList = ['Nagt', 'Bank karty', 'Online töleg'];

  final List<String> bankList = [
    'Halkbank',
    'Rysgal bank',
    'Senagat bank',
    'TÝB',
  ];

  String getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    return '$day.$month.$year';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _showTolegBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return TolegBottomSheet(
          selected: _selectedToleg,
          onSelected: (val) {
            setState(() => _selectedToleg = val);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showBankBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return BankBottomSheet(
          selected: _selectedBank,
          onSelected: (val) {
            setState(() => _selectedBank = val);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5);
    final cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A2E);
    final borderColor = isDark
        ? const Color(0xFF333333)
        : const Color(0xFFD0D7FB);
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
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            SizedBox(
              height: 49,
              child: 
             AppBarWidget(textColor) ),
            const Divider(height: 1, color: Color(0xFFF5F7FF)),

            // Back + Title
            SizedBox(
              height: 49,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                    const Text(
                      'Maglumatlyňyzy giriziň',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1, color: Color(0xFFF5F7FF)),

            // Content
            Expanded(
              child: Container(
                color: const Color(0xFFF5F7FF),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Orange info banner
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF6F8FD),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFF6F8FD),
                              width: 0.5,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Image.asset(
                                    "assets/images/icon/i.png",
                                    width: 15.0,
                                    height: 15.0,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Eger siz hyzmat sargyt edip, soň pikirlerňizi üýtgetseňiz ýa-da hyzmatdan ýüz öwürseňiz, hyzma...',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFFF6600),
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Doly adyňyz
                        const Text(
                          'Doly adyňyz',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        inputField(
                          controller: _nameController,
                          inputBg: const Color(0xFFF7F7F7),
                          borderColor: borderColor,
                          textColor: textColor,
                          hintColor: Colors.black38,
                          text: "Adyňyzy giriziň",
                          keyboardType: TextInputType.text,
                          suffix: IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.black38,
                              size: 18,
                            ),
                            onPressed: () => _phoneController.clear(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Telefon belgiňiz
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
                            codeBox(
                              '+993',
                              textColor,
                              const Color(0xFFF7F7F7),
                              borderColor,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: inputField(
                                controller: _phoneController,
                                inputBg: const Color(0xFFF7F7F7),
                                borderColor: borderColor,
                                textColor: textColor,
                                hintColor: Colors.black38,
                                keyboardType: TextInputType.phone,
                                suffix: IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.black38,
                                    size: 18,
                                  ),
                                  onPressed: () => _phoneController.clear(),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Töleg şekili
                        const Text(
                          'Töleg şekili',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _showTolegBottomSheet(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFD0D7FB),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _selectedToleg ?? 'Töleg görnüşi saýlaň',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: _selectedToleg != null
                                          ? Colors.black
                                          : Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey.shade500,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Bank saýlaň
                        const Text(
                          'Bank saýlaň',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => _showBankBottomSheet(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFD0D7FB),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _selectedBank ?? 'Hiç zat saýlanmady',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: _selectedBank != null
                                          ? Colors.black
                                          : Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey.shade500,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Çagyryş button
                        Container(
                          width: 360,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Çagyryş',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _DropdownField({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD0D7FB)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
          ),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade500),
          style: const TextStyle(fontSize: 15, color: Colors.black),
          items: items.map((item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
