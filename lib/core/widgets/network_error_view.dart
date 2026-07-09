import 'package:flutter/material.dart';

import 'decorated_state_icon.dart';
import '../error/faiulre.dart';
import '../utils/theme/app_colors.dart';

enum NetworkErrorType { noInternet, server }

/// Полноэкранный стейт "нет интернета" / "ошибка сервера" с кнопкой ретрая.
/// Используется везде, где загрузка данных с сервера может упасть
/// (Home, брони, аксии и т.д.) — просто подставь `onRetry`.
class NetworkErrorView extends StatelessWidget {
  final NetworkErrorType type;
  final VoidCallback onRetry;

  const NetworkErrorView({
    super.key,
    required this.type,
    required this.onRetry,
  });

  /// Выбирает нужный вариант по типу ошибки из [Failure.fromException]:
  /// NetworkFailure → "нет интернета", всё остальное → "ошибка сервера".
  factory NetworkErrorView.fromFailure(
    Failure failure, {
    required VoidCallback onRetry,
  }) {
    return NetworkErrorView(
      type: failure is NetworkFailure
          ? NetworkErrorType.noInternet
          : NetworkErrorType.server,
      onRetry: onRetry,
    );
  }

  bool get _isNoInternet => type == NetworkErrorType.noInternet;

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
              icon: _isNoInternet ? Icons.wifi_off_rounded : Icons.dns_outlined,
              badgeIcon: _isNoInternet ? null : Icons.close,
            ),
            const SizedBox(height: 24),
            Text(
              _isNoInternet ? 'Internet ýok' : 'Internet nasazlyk',
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _isNoInternet ? 'Sizde internet ýok' : 'Internet birikmesi näsaz',
              style: TextStyle(color: subtitleColor, fontSize: 14),
            ),
            const SizedBox(height: 28),
            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: 20),
                label: Text(
                  _isNoInternet ? 'Baglanyşygy barlaň' : 'Gaýtadan synanyşyň',
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
        ),
      ),
    );
  }
}
