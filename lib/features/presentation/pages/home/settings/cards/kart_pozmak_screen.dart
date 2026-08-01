import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/theme/app_colors.dart';
import '../../../auth/parts/auth_helper.dart';
import '../../home_screen.dart';
import 'card_model.dart';
import 'cards_store.dart';

class KartPozmakScreen extends StatefulWidget {
  final SavedCard card;
  const KartPozmakScreen({super.key, required this.card});

  @override
  State<KartPozmakScreen> createState() => _KartPozmakScreenState();
}

class _KartPozmakScreenState extends State<KartPozmakScreen> {
  late final TextEditingController _numberController;
  late final TextEditingController _expiryController;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController(text: widget.card.maskedNumber);
    _expiryController = TextEditingController(text: widget.card.expiry);
    _nameController = TextEditingController(text: widget.card.holderName);
  }

  @override
  void dispose() {
    _numberController.dispose();
    _expiryController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _confirmDelete() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _DeleteCardSheet(
        onSelected: (confirmed) {
          if (confirmed) {
            CardsStore.remove(widget.card.id);
            if (context.mounted) context.pop();
          }
        },
      ),
    );
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
                    'Menin kartym',
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
                    Container(
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            widget.card.bankLogo,
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.card.bankName,
                            style: TextStyle(color: textColor, fontSize: 15),
                          ),
                        ],
                      ),
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
                      borderColor: borderColor,
                      textColor: textColor,
                      hintColor: hintColor,
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
                      borderColor: borderColor,
                      textColor: textColor,
                      hintColor: hintColor,
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
                        onPressed: _confirmDelete,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5050),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Karty pozmak',
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

class _DeleteCardSheet extends StatelessWidget {
  final ValueChanged<bool> onSelected;
  const _DeleteCardSheet({required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppColor.titleText(context);
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgPageLight;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: 56,
            height: 6,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFD1D1D1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFFFEE2E2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: Color(0xFFFF5050),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Karty pozmak!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onSelected(false);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: Color(0xFFE0E0E0)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('Ýok', style: TextStyle(color: textColor)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onSelected(true);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFFFF5050),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Howa'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
