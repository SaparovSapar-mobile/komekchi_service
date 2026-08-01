import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/theme/app_colors.dart';
import '../../../auth/parts/auth_helper.dart';
import '../../home_screen.dart';
import 'bank_select_field.dart';
import 'card_model.dart';
import 'cards_store.dart';

class KartGoshmakScreen extends StatefulWidget {
  const KartGoshmakScreen({super.key});

  @override
  State<KartGoshmakScreen> createState() => _KartGoshmakScreenState();
}

class _KartGoshmakScreenState extends State<KartGoshmakScreen> {
  BankOption _selectedBank = kBanks.first;
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _numberController.addListener(_onFieldsChanged);
    _expiryController.addListener(_onFieldsChanged);
    _nameController.addListener(_onFieldsChanged);
  }

  void _onFieldsChanged() => setState(() {});

  @override
  void dispose() {
    _numberController.dispose();
    _expiryController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _numberController.text.trim().isNotEmpty &&
      _expiryController.text.trim().isNotEmpty && 
      _nameController.text.trim().isNotEmpty;

  void _submit() {
    CardsStore.add(
      SavedCard(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        bankName: _selectedBank.name,
        bankLogo: _selectedBank.logo,
        cardNumber: _numberController.text.trim().replaceAll(' ', ''),
        expiry: _expiryController.text.trim(),
        holderName: _nameController.text.trim(),
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColor.pageBg(context);
    final cardBg = AppColor.cardBg(context);
    final textColor = AppColor.titleText(context);
    final borderColor = AppColor.border(context);
    final hintColor = isDark ? Colors.white38 : Colors.black38;

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
                  Text(
                    'Taze kart',
                    style: TextStyle(fontSize: 16, color: textColor),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bank saýla',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    BankSelectField(
                      selected: _selectedBank,
                      onChanged: (bank) => setState(() => _selectedBank = bank),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Kart belgisi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    inputField(
                      context: context,
                      controller: _numberController,
                      inputBg: cardBg,
                      text: '0000 0000 0000 0000',
                      borderColor: borderColor,
                      textColor: textColor,
                      hintColor: hintColor,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Kartyn möhleti',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    inputField(
                      context: context,
                      controller: _expiryController,
                      inputBg: cardBg,
                      text: 'AA/ÝY',
                      borderColor: borderColor,
                      textColor: textColor,
                      hintColor: hintColor,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Ady Familýasy',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    inputField(
                      context: context,
                      controller: _nameController,
                      inputBg: cardBg,
                      text: 'Adyňyzy giriziň',
                      borderColor: borderColor,
                      textColor: textColor,
                      hintColor: hintColor,
                    ),
                    const SizedBox(height: 10),

                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Kömek gerekmi?',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? AppColor.titleDark : AppColor.primary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _isValid ? _submit : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Goşmak',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
