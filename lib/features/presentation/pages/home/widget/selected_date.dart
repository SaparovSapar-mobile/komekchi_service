import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/const.dart';
import 'package:komekchi_service/features/presentation/bloc/order/create_order_cubit.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/bank_bottomsheet.dart';

import '../../../../../core/utils/theme/app_colors.dart';
import '../../auth/auth_screen.dart.dart';
import '../../auth/parts/auth_helper.dart';
import 'tolegbottomsheet.dart';

class SelectedDate extends StatefulWidget {
  final String? subcategoryUuid;
  final int quantity;
  final String? orderDate;
  final String? orderTime;

  const SelectedDate({
    super.key,
    this.subcategoryUuid,
    this.quantity = 1,
    this.orderDate,
    this.orderTime,
  });

  @override
  State<SelectedDate> createState() => _SelectedDateState();
}

class _SelectedDateState extends State<SelectedDate> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
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
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    final subcategoryUuid = widget.subcategoryUuid;
    final orderDate = widget.orderDate;
    final orderTime = widget.orderTime;

    if (subcategoryUuid == null || orderDate == null || orderTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hyzmat we wagt saýlanmady')),
      );
      return;
    }

    if (_addressController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Salgyňyzy giriziň')));
      return;
    }

    context.read<CreateOrderCubit>().createOrder(
      subcategoryUuid: subcategoryUuid,
      address: _addressController.text.trim(),
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
      orderDate: orderDate,
      orderTime: orderTime,
      quantity: widget.quantity,
    );
  }

  void _showTolegBottomSheet(BuildContext context) {
    FocusScope.of(context).unfocus();
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
    FocusScope.of(context).unfocus();
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
    final bg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final cardBg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final textColor = AppColor.titleText(context);
    final borderColor = isDark
        ? const Color(0xFF333333)
        : const Color(0xFFD0D7FB);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              SizedBox(height: 49, child: AppBarWidget(textColor, isDark)),
              const DividerWidget(),

              // Back + Title
              SizedBox(
                height: 49,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                      ),
                      Text(
                        'Maglumatlaryňyzy giriziň',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const DividerWidget(),

              // Content
              Expanded(
                child: Container(
                  color: bg,
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
                        color: bg,
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
                              color: cardBg,
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
                                    'Eger siz hyzmat sargyt edip, soň pikirlerňizi üýtgetseňiz ýa-da hyzmatdan ýüz öwürseňiz',
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
                          Text(
                            'Doly adyňyz',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          inputField(
                            controller: _nameController,
                            inputBg: cardBg,
                            borderColor: borderColor,
                            textColor: textColor,
                            hintColor: AppColor.descriptionText(context),
                            text: "Adyňyzy giriziň",
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 16),

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
                              codeBox('+993', textColor, cardBg, borderColor),
                              const SizedBox(width: 10),
                              Expanded(
                                child: inputField(
                                  controller: _phoneController,
                                  inputBg: cardBg,
                                  type: FieldType.phone,
                                  borderColor: borderColor,
                                  textColor: textColor,
                                  hintColor: AppColor.descriptionText(context),
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          Text(
                            'Salgy',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          inputField(
                            controller: _addressController,
                            inputBg: cardBg,
                            borderColor: borderColor,
                            textColor: textColor,
                            hintColor: AppColor.descriptionText(context),
                            text: "Salgyňyzy giriziň",
                            keyboardType: TextInputType.streetAddress,
                          ),

                          const SizedBox(height: 16),

                          Text(
                            'Bellik',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          inputField(
                            controller: _noteController,
                            inputBg: cardBg,
                            borderColor: borderColor,
                            textColor: textColor,
                            hintColor: AppColor.descriptionText(context),
                            text: "Bellik (hökmany däl)",
                            keyboardType: TextInputType.text,
                          ),

                          const SizedBox(height: 16),

                          // Töleg şekili
                           Text(
                            'Töleg şekili',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: textColor,
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
                                color: cardBg,
                                borderRadius: BorderRadius.circular(12),
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
                          BlocConsumer<CreateOrderCubit, CreateOrderState>(
                            listener: (context, state) {
                              if (state is CreateOrderSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Bron üstünlikli döredildi'),
                                  ),
                                );
                                context.go('/main');
                              } else if (state is CreateOrderError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              }
                            },
                            builder: (context, state) {
                              final isLoading = state is CreateOrderLoading;
                              return SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () => _submit(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primary,
                                    disabledBackgroundColor: AppColor.primary
                                        .withOpacity(0.6),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text(
                                          'Çagyryş',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              );
                            },
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
