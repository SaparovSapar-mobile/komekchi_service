import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/theme/app_colors.dart';
import '../../../../../../core/widgets/empty_state_view.dart';
import '../../home_screen.dart';
import 'card_model.dart';
import 'cards_store.dart';

class KartlarymScreen extends StatelessWidget {
  const KartlarymScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = AppColor.pageBg(context);
    final cardBg = AppColor.cardBg(context);
    final textColor = AppColor.titleText(context);

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
                    'Kartlarym',
                    style: TextStyle(fontSize: 16, color: textColor),
                  ),
                  const Spacer(),
                  IconButton(
                    // onPressed: () => context.push('/kartGoshmak'),
                    onPressed: () {},
                    icon: Icon(Icons.add, color: textColor),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ValueListenableBuilder<List<SavedCard>>(
                valueListenable: CardsStore.cards,
                builder: (context, cards, _) {
                  if (cards.isEmpty) {
                    return EmptyStateView.noCards(
                      onAddCard: () => context.push('/kartGoshmak'),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    itemCount: cards.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      return _CardTile(
                        card: card,
                        cardBg: cardBg,
                        textColor: textColor,
                        onTap: () => context.push('/kartPozmak', extra: card),
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

class _CardTile extends StatelessWidget {
  final SavedCard card;
  final Color cardBg;
  final Color textColor;
  final VoidCallback onTap;

  const _CardTile({
    required this.card,
    required this.cardBg,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Image.asset(card.bankLogo, width: 32, height: 32),
        title: Text(
          card.holderName.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${card.maskedNumber} ${card.expiry}',
              style: TextStyle(
                fontSize: 12,
                color: AppColor.descriptionText(context),
              ),
            ),
            if (card.isGold)
              Text(
                'Altyn asyr kart (Beýleki banklar)',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColor.descriptionText(context),
                ),
              ),
          ],
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
      ),
    );
  }
}
