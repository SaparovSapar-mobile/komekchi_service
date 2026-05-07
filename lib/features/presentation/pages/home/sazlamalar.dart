import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:komekchi_service/core/utils/theme/app_theme.dart';

import '../../../../core/utils/theme/app_colors.dart';

class SazlamalarScreen extends StatefulWidget {
  const SazlamalarScreen({super.key});

  @override
  State<SazlamalarScreen> createState() => _SazlamalarScreenState();
}

class _SazlamalarScreenState extends State<SazlamalarScreen> {
  bool sesliBildirisler = true;
  bool pinKod = true;

  String getCurrentDate() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    return '$day.$month.$year';
  }

  @override
  Widget build(BuildContext context) {
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
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 31.0, vertical: 10.31),
                child: Row(
                  children: [
                    Image.asset("assets/images/logo/mini_logo.png", width: 37.14, height: 38.42),
                    const SizedBox(width: 4),
                    const Text(
                      "Kömekçi\nHyzmat",
                      style: TextStyle(fontSize: 10.0, color: AppColor.primary, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(getCurrentDate(), style: const TextStyle(fontSize: 16, color: Colors.black)),
                    const SizedBox(width: 2),
                    const Text("|"),
                    const SizedBox(width: 2),
                    const Icon(Icons.cloud, size: 16, color: Colors.black45),
                    const Text(" 32° Aşgabat", style: TextStyle(fontSize: 16, color: Colors.black)),
                  ],
                ),
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Meniň sahypam
                    _SectionTitle(
                      title: 'Meniň sahypam',
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit_outlined, size: 20, color: Colors.black54),
                      ),
                    ),
                    _SectionCard(
                      children: [
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.person, color: Colors.grey),
                          ),
                          title: const Text(
                            'Mekan Çaryýew',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text('Ulanyjy', style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Sazlamalar
                    const _SectionTitle(title: 'Sazlamalar'),
                    _SectionCard(
                      children: [
                        _SettingsRow(
                          icon: Icons.translate,
                          iconColor: Colors.blue,
                          title: 'Diller',
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Turkmen', style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
                              Icon(Icons.chevron_right, color: Colors.grey.shade400),
                            ],
                          ),
                          onTap: () {},
                        ),
                        _Divider(),
                        _SettingsRow(
                          icon: Icons.dark_mode_outlined,
                          iconColor: Colors.indigo,
                          title: 'Tema',
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Dark', style: TextStyle(fontSize: 13, color: Colors.grey.shade500)),
                              Icon(Icons.chevron_right, color: Colors.grey.shade400),
                            ],
                          ),
                          onTap: () {},
                        ),
                        _Divider(),
                        _SettingsRow(
                          icon: Icons.location_on_outlined,
                          iconColor: Colors.red,
                          title: 'Salgylarym',
                          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
                          onTap: () {},
                        ),
                        _Divider(),
                        _SettingsRow(
                          icon: Icons.credit_card,
                          iconColor: Colors.orange,
                          title: 'Kartlarym',
                          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
                          onTap: () {},
                        ),
                        _Divider(),
                        _SettingsRow(
                          icon: Icons.notifications_outlined,
                          iconColor: Colors.blue,
                          title: 'Sesli bildirişler',
                          trailing: Switch(
                            value: sesliBildirisler,
                            onChanged: (val) => setState(() => sesliBildirisler = val),
                            activeColor: AppColor.primary,
                          ),
                        ),
                        _Divider(),
                        _SettingsRow(
                          icon: Icons.lock_outline,
                          iconColor: Colors.blue,
                          title: 'Pin kod',
                          trailing: Switch(
                            value: pinKod,
                            onChanged: (val) => setState(() => pinKod = val),
                            activeColor: AppColor.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Biz barada
                    const _SectionTitle(title: 'Biz barada'),
                    _SectionCard(
                      children: [
                        _SettingsRow(
                          icon: Icons.info_outline,
                          iconColor: Colors.blue,
                          title: 'Karhana barada',
                          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
                          onTap: () {},
                        ),
                        _Divider(),
                        _SettingsRow(
                          icon: Icons.headset_mic_outlined,
                          iconColor: Colors.blue,
                          title: 'Biz bilen habarlaşmak',
                          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
                          onTap: () {},
                        ),
                        _Divider(),
                        _SettingsRow(
                          icon: Icons.chat_outlined,
                          iconColor: Colors.blue,
                          title: 'Hat yazmak',
                          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
                          onTap: () {},
                        ),
                        _Divider(),
                        _SettingsRow(
                          icon: Icons.security_outlined,
                          iconColor: Colors.blue,
                          title: 'Gizlinlik syýasaty',
                          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
                          onTap: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Akkountdan çykmak
                    const _SectionTitle(title: 'Akkountdan çykmak'),
                    _SectionCard(
                      children: [
                        _SettingsRow(
                          icon: Icons.logout,
                          iconColor: Colors.blue,
                          title: 'Çykmak',
                          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
                          onTap: () {},
                        ),
                        _Divider(),
                        _SettingsRow(
                          icon: Icons.delete_outline,
                          iconColor: Colors.red,
                          title: 'Hasabym pozmak',
                          titleColor: Colors.black,
                          trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
                          onTap: () {},
                        ),
                        _Divider(),
                        _SettingsRow(
                          icon: Icons.system_update_outlined,
                          iconColor: Colors.blue,
                          title: 'Programmany täzelemek',
                          subtitle: 'Version 2.14.0',
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('New version', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                              const SizedBox(width: 4),
                              Icon(Icons.refresh, size: 16, color: Colors.grey.shade500),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ],
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

// Section title widget
class _SectionTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const _SectionTitle({required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
          const Spacer(),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

// White card wrapper
class _SectionCard extends StatelessWidget {
  final List<Widget> children;
  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100, width: 0.5),
      ),
      child: Column(children: children),
    );
  }
}

// Settings row
class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final Widget trailing;
  final VoidCallback? onTap;

  const _SettingsRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.trailing,
    this.subtitle,
    this.titleColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: titleColor ?? Colors.black),
      ),
      subtitle: subtitle != null
          ? Text(subtitle!, style: TextStyle(fontSize: 12, color: Colors.grey.shade500))
          : null,
      trailing: trailing,
    );
  }
}

// Thin divider
class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, indent: 56, color: Colors.grey.shade100);
  }
}