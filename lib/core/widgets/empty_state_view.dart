import 'package:flutter/material.dart';

import 'decorated_state_icon.dart';
import '../utils/theme/app_colors.dart';

/// Полноэкранный стейт "пусто" (нет результатов поиска, нет данных,
/// нет адресов, нет броней и т.д.) — визуально в паре с [NetworkErrorView].
class EmptyStateView extends StatelessWidget {
  final IconData icon;
  final IconData? badgeIcon;
  final Color? badgeColor;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final IconData? actionIcon;
  final VoidCallback? onAction;

  const EmptyStateView({
    super.key,
    required this.icon,
    this.badgeIcon,
    this.badgeColor,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.actionIcon,
    this.onAction,
  });

  /// "Gözleg boş" — пустой результат поиска.
  factory EmptyStateView.search({required VoidCallback onNewSearch}) {
    return EmptyStateView(
      icon: Icons.search,
      title: 'Gözleg boş',
      subtitle: 'Gözleg boýunça hiç zat tapylmady',
      actionLabel: 'Täze gözleg',
      actionIcon: Icons.search,
      onAction: onNewSearch,
    );
  }

  /// "Maglumat ýok" — нет данных, без кнопки действия.
  factory EmptyStateView.noData({String? subtitle}) {
    return EmptyStateView(
      icon: Icons.description_outlined,
      badgeIcon: Icons.info_outline,
      title: 'Maglumat ýok',
      subtitle: subtitle ?? 'Häzirlikçe maglumat ýok',
    );
  }

  /// "Salgylarym boş" — нет сохранённых адресов.
  factory EmptyStateView.noAddresses({required VoidCallback onAddAddress}) {
    return EmptyStateView(
      icon: Icons.location_on_outlined,
      badgeIcon: Icons.add,
      title: 'Salgylarym boş',
      subtitle: 'Sizde heniz salgy ýok',
      actionLabel: 'Salgy goş',
      actionIcon: Icons.add,
      onAction: onAddAddress,
    );
  }

  /// "Sargytlarym boş" — нет броней/заказов.
  factory EmptyStateView.noBookings({required VoidCallback onBook}) {
    return EmptyStateView(
      icon: Icons.calendar_today_outlined,
      badgeIcon: Icons.close,
      title: 'Sargytlarym boş',
      subtitle: 'Täze bron zakaz ediň',
      actionLabel: 'Bron et',
      actionIcon: Icons.bookmark_add_outlined,
      onAction: onBook,
    );
  }

  /// "Bildiririş ýok" — нет уведомлений, без кнопки.
  factory EmptyStateView.noNotifications() {
    return const EmptyStateView(
      icon: Icons.notifications_none_rounded,
      badgeIcon: Icons.close,
      title: 'Bildiririş ýok',
      subtitle: 'Täze bildiriş ýok',
    );
  }

  /// "Kartlar ýok" — нет привязанных карт.
  factory EmptyStateView.noCards({required VoidCallback onAddCard}) {
    return EmptyStateView(
      icon: Icons.credit_card_outlined,
      badgeIcon: Icons.close,
      title: 'Kartlar ýok',
      subtitle: 'Kartlar goşulmady',
      actionLabel: 'Kart goş',
      actionIcon: Icons.credit_card,
      onAction: onAddCard,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = AppColor.titleText(context);
    final subtitleColor = AppColor.descriptionText(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedStateIcon(
              icon: icon,
              badgeIcon: badgeIcon,
              badgeColor: badgeColor,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(color: subtitleColor, fontSize: 14),
              ),
            ],
            if (onAction != null) ...[
              const SizedBox(height: 28),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: onAction,
                  icon: Icon(actionIcon ?? Icons.refresh, size: 20),
                  label: Text(
                    actionLabel ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
