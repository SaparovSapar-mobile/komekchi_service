import 'package:flutter/foundation.dart';

import 'card_model.dart';

/// Локальное хранилище карт (без бэкенда пока) — переживает переходы
/// между экранами Kartlarym/Kart goşmak/Kart pozmak в рамках сессии.
class CardsStore {
  CardsStore._();

  static final ValueNotifier<List<SavedCard>> cards = ValueNotifier([]);

  static void add(SavedCard card) {
    cards.value = [...cards.value, card];
  }

  static void remove(String id) {
    cards.value = cards.value.where((c) => c.id != id).toList();
  }
}
