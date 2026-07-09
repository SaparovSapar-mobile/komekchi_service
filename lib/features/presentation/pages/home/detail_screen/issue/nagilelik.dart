import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/const.dart';
import 'package:komekchi_service/features/presentation/bloc/complaint/submit_complaint_cubit.dart';
import 'package:komekchi_service/injector.dart';

import '../../../../../../core/utils/theme/app_colors.dart';
import '../../../auth/parts/auth_helper.dart';
import 'tab_item.dart';

class NagilelikScreen extends StatefulWidget {
  const NagilelikScreen({super.key});

  @override
  State<NagilelikScreen> createState() => _NagilelikScreenState();
}

class _NagilelikScreenState extends State<NagilelikScreen> {
  int _selectedTab = 0; // 0 = Telefon, 1 = Email
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _regPhoneController = TextEditingController();
  late final SubmitComplaintCubit _submitCubit = sl<SubmitComplaintCubit>();

  String getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    return '$day.$month.$year';
  }

  @override
  void dispose() {
    _regPhoneController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _submitCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final cardBg = isDark ? AppColor.bgBlogDark : AppColor.bgBlogLight;
    final textColor = AppColor.titleText(context);
    final borderColor = isDark ? const Color(0xFF333333) : AppColor.borderColor;
    final inputBg = isDark ? AppColor.bgPageDark : AppColor.bgPageLight;
    final hintColor = isDark ? Colors.white38 : Colors.black38;
    return Scaffold(
      backgroundColor: AppColor.primary,
      resizeToAvoidBottomInset: false,
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
          color: cardBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Back
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  ),
                  Text('Yza', style: TextStyle(fontSize: 16, color: textColor)),
                ],
              ),
            ),
            DividerWidget(),

            // Content
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: bg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            "assets/images/logo/flag.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Nagilelik bildirmek',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Tab switcher
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor, width: 1),
                      ),
                      child: Row(
                        children: [
                          TabItem(
                            title: 'Telefon belgi',
                            isSelected: _selectedTab == 0,
                            onTap: () => setState(() {
                              _selectedTab = 0;
                              _messageController.clear();
                            }),
                          ),
                          TabItem(
                            title: 'Email',
                            isSelected: _selectedTab == 1,
                            onTap: () => setState(() {
                              _selectedTab = 1;
                              _messageController.clear();
                            }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Input field (telefon yoki email)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: _selectedTab == 0
                          ? buildPhoneField(context, _regPhoneController)
                          : buildEmailField(context, _emailController),
                    ),
                    const SizedBox(height: 16),

                    // Hat yazmak
                    Text(
                      'Hat ýazmak',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.titleText(context),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _messageController,
                      maxLines: 5,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Hat ýaz',
                        hintStyle: TextStyle(
                          color: AppColor.descriptionText(context),
                          fontSize: 15,
                        ),
                        filled: true,
                        fillColor: bg,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColor.borderColor,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColor.borderColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColor.primary,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Ugratmak button
                    BlocConsumer<SubmitComplaintCubit, SubmitComplaintState>(
                      bloc: _submitCubit,
                      listener: (context, state) {
                        if (state is SubmitComplaintSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Nagilelik ugradyldy'),
                            ),
                          );
                          context.pop();
                        }
                        if (state is SubmitComplaintError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Ýalňyşlyk: ${state.message}'),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state is SubmitComplaintLoading;
                        final message = _messageController.text.trim();

                        return SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: message.isNotEmpty && !isLoading
                                ? () => _submitCubit.submit(message)
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Ugratmak',
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
