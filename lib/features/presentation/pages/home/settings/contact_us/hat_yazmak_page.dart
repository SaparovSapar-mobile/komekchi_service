import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komekchi_service/features/presentation/bloc/contact_us/contact_us_cubit.dart';
import 'package:komekchi_service/core/utils/theme/app_colors.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:komekchi_service/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _ContactMethod { phone, email }

class HatYazmakPage extends StatelessWidget {
  const HatYazmakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ContactUsCubit>(),
      child: const _HatYazmakView(),
    );
  }
}

class _HatYazmakView extends StatefulWidget {
  const _HatYazmakView();

  @override
  State<_HatYazmakView> createState() => _HatYazmakViewState();
}

class _HatYazmakViewState extends State<_HatYazmakView> {
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();
  final _messageController = TextEditingController();
  _ContactMethod _method = _ContactMethod.phone;
  String? _savedPhone;

  bool get _phoneLocked =>
      _method == _ContactMethod.phone &&
      _savedPhone != null &&
      _savedPhone!.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _prefillPhone();
  }

  Future<void> _prefillPhone() async {
    final prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString('phone');
    if (phone == null || phone.isEmpty || !mounted) return;
    setState(() {
      _savedPhone = phone;
      if (_method == _ContactMethod.phone) {
        _contactController.text = phone;
      }
    });
  }

  @override
  void dispose() {
    _contactController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    final value = _contactController.text.trim();

    context.read<ContactUsCubit>().sendContactUs(
      email: _method == _ContactMethod.email ? value : null,
      phone: _method == _ContactMethod.phone ? value : null,
      message: _messageController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColor.cardBg(context);
    final cardBg = AppColor.pageBg(context);
    final textColor = AppColor.titleText(context);
    final hintColor = AppColor.descriptionText(context);
    final borderColor = AppColor.border(context);

    return BlocListener<ContactUsCubit, ContactUsState>(
      listener: (context, state) {
        if (state is ContactUsSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Hatyňyz ugradyldy!')));
          _contactController.clear();
          _messageController.clear();
        } else if (state is ContactUsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
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
              const SizedBox(height: 23),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 18,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'Yza',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: bg,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.forum_outlined,
                                    size: 20,
                                    color: AppColor.primary,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Hat ýazmak',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Method switch
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: bg,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _MethodTab(
                                    text: 'Telefon belgi',
                                    isSelected: _method == _ContactMethod.phone,
                                    cardBg: cardBg,
                                    textColor: textColor,
                                    hintColor: hintColor,
                                    onTap: () {
                                      setState(() {
                                        _method = _ContactMethod.phone;
                                        _contactController.text =
                                            _savedPhone ?? '';
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: _MethodTab(
                                    text: 'Email',
                                    isSelected: _method == _ContactMethod.email,
                                    cardBg: cardBg,
                                    textColor: textColor,
                                    hintColor: hintColor,
                                    onTap: () {
                                      setState(() {
                                        _method = _ContactMethod.email;
                                        _contactController.clear();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          Text(
                            _method == _ContactMethod.phone
                                ? 'Telefon belgiňiz'
                                : 'Email',
                            style: TextStyle(fontSize: 14, color: textColor),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _contactController,
                            readOnly: _phoneLocked,
                            keyboardType: _method == _ContactMethod.phone
                                ? TextInputType.phone
                                : TextInputType.emailAddress,
                            style: TextStyle(
                              color: _phoneLocked
                                  ? Colors.grey.shade600
                                  : textColor,
                              fontSize: 15,
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return _method == _ContactMethod.phone
                                    ? 'Telefon belgiňizi giriziň'
                                    : 'Email salgyňyzy giriziň';
                              }
                              if (_method == _ContactMethod.email &&
                                  (!v.contains('@') || !v.contains('.'))) {
                                return 'Email nädogry';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: _method == _ContactMethod.phone
                                  ? '+993 63 509004'
                                  : 'you@example.com',
                              hintStyle: TextStyle(color: hintColor),
                              filled: true,
                              fillColor: _phoneLocked
                                  ? Colors.grey.shade200
                                  : bg,
                              suffixIcon: _phoneLocked
                                  ? Icon(
                                      Icons.lock_outline,
                                      size: 18,
                                      color: Colors.grey.shade500,
                                    )
                                  : null,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: borderColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          Text(
                            'Hat ýazmak',
                            style: TextStyle(fontSize: 14, color: textColor),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _messageController,
                            maxLines: 6,
                            style: TextStyle(color: textColor, fontSize: 15),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Hatyňyzy ýazyň';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Hat ýaz',
                              hintStyle: TextStyle(color: hintColor),
                              filled: true,
                              fillColor: bg,
                              contentPadding: const EdgeInsets.all(14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: borderColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          BlocBuilder<ContactUsCubit, ContactUsState>(
                            builder: (context, state) {
                              final isLoading = state is ContactUsLoading;
                              return SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () => _submit(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
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
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
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

class _MethodTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Color cardBg;
  final Color textColor;
  final Color hintColor;
  final VoidCallback onTap;

  const _MethodTab({
    required this.text,
    required this.isSelected,
    required this.cardBg,
    required this.textColor,
    required this.hintColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? cardBg : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? textColor : hintColor,
          ),
        ),
      ),
    );
  }
}
