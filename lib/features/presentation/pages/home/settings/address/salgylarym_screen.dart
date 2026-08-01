import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:komekchi_service/core/utils/theme/app_colors.dart';
import 'package:komekchi_service/core/widgets/empty_state_view.dart';
import 'package:komekchi_service/features/domain/entities/address.dart';
import 'package:komekchi_service/features/domain/entities/address_type.dart';
import 'package:komekchi_service/features/presentation/bloc/address/address_cubit.dart';
import 'package:komekchi_service/features/presentation/bloc/address/address_type_cubit.dart';
import 'package:komekchi_service/features/presentation/pages/home/detail_screen/map.dart';
import 'package:komekchi_service/features/presentation/pages/home/home_screen.dart';
import 'package:komekchi_service/features/presentation/pages/home/widget/address_type_display.dart';
import 'package:komekchi_service/injector.dart';
import 'package:komekchi_service/l10n/gen/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalgylarymScreen extends StatefulWidget {
  const SalgylarymScreen({super.key});

  @override
  State<SalgylarymScreen> createState() => _SalgylarymScreenState();
}

class _SalgylarymScreenState extends State<SalgylarymScreen> {
  late final AddressCubit _addressCubit = sl<AddressCubit>();
  late final AddressTypeCubit _typeCubit = sl<AddressTypeCubit>();
  bool _isLoggedIn = true;

  @override
  void initState() {
    super.initState();
    _checkLoginAndFetch();
  }

  // Addresses require auth — check for a saved token *before* hitting the
  // API instead of surfacing a raw backend error to a guest/logged-out user.
  Future<void> _checkLoginAndFetch() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getString('auth_token') != null;
    if (!mounted) return;
    setState(() => _isLoggedIn = loggedIn);
    if (loggedIn) {
      _addressCubit.fetchAddresses();
      _typeCubit.fetchAddressTypes();
    }
  }

  @override
  void dispose() {
    _addressCubit.close();
    _typeCubit.close();
    super.dispose();
  }

  void _openAddEdit({AddressItem? existing, AddressTypeItem? type}) {
    showSalgyAtiandyrBottomSheet(
      context,
      initialText: existing?.address ?? '',
      editUuid: existing?.uuid,
      initialType: type,
      onLocationAdded: (_) => _addressCubit.fetchAddresses(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColor.pageBg(context);
    final cardBg = AppColor.cardBg(context);
    final textColor = AppColor.titleText(context);
    final t = AppLocalizations.of(context)!;

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
                    t.myAddresses,
                    style: TextStyle(fontSize: 16, color: textColor),
                  ),
                  const Spacer(),
                  if (_isLoggedIn)
                    IconButton(
                      onPressed: () => _openAddEdit(),
                      icon: Icon(Icons.add, color: textColor),
                    ),
                ],
              ),
            ),
            Expanded(
              child: !_isLoggedIn
                  ? EmptyStateView(
                      icon: Icons.person_off_outlined,
                      title: t.notLoggedInTitle,
                      subtitle: t.notLoggedInAddressesSubtitle,
                      actionLabel: t.loginButton,
                      actionIcon: Icons.login,
                      onAction: () => context.push('/login'),
                    )
                  : BlocBuilder<AddressTypeCubit, AddressTypeState>(
                bloc: _typeCubit,
                builder: (context, typeState) {
                  if (typeState is AddressTypeLoading ||
                      typeState is AddressTypeInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (typeState is AddressTypeError) {
                    return Center(
                      child: Text(
                        typeState.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final types = (typeState as AddressTypeSuccess).items;

                  return BlocBuilder<AddressCubit, AddressState>(
                    bloc: _addressCubit,
                    builder: (context, addressState) {
                      if (addressState is AddressLoading ||
                          addressState is AddressInitial) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (addressState is AddressError) {
                        return Center(
                          child: Text(
                            addressState.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      if (types.isEmpty) {
                        return EmptyStateView.noAddresses(
                          onAddAddress: () => _openAddEdit(),
                        );
                      }

                      final addresses = (addressState as AddressSuccess).items;

                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        itemCount: types.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final type = types[index];
                          AddressItem? matched;
                          for (final a in addresses) {
                            if (a.addressTypeUuid == type.uuid) {
                              matched = a;
                              break;
                            }
                          }
                          return _AddressTypeTile(
                            type: type,
                            address: matched,
                            cardBg: cardBg,
                            textColor: textColor,
                            onTap: () =>
                                _openAddEdit(existing: matched, type: type),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressTypeTile extends StatelessWidget {
  final AddressTypeItem type;
  final AddressItem? address;
  final Color cardBg;
  final Color textColor;
  final VoidCallback onTap;

  const _AddressTypeTile({
    required this.type,
    required this.address,
    required this.cardBg,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColor.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(addressTypeIcon(type.name), color: AppColor.primary, size: 20),
        ),
        title: Text(
          addressTypeLabel(t, type.name),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        subtitle: address != null
            ? Text(
                address!.address,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColor.descriptionText(context),
                ),
              )
            : null,
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
      ),
    );
  }
}
