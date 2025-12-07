import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/card_model.dart';
import 'cart_states.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final List<CartItem> _items = [];
  static const _prefsKey = 'cart_items_v1';

  static CartCubit get(context) => BlocProvider.of(context);

  List<CartItem> get items => List.unmodifiable(_items);

  // load saved cart (call once when cubit created)
  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null || raw.isEmpty) {
      emit(CartUpdated(items));
      return;
    }
    try {
      final List decoded = json.decode(raw) as List;
      _items.clear();
      _items.addAll(decoded.map((e) => CartItem.fromMap(Map<String, dynamic>.from(e))));
      emit(CartUpdated(items));
    } catch (e) {
      await prefs.remove(_prefsKey);
      emit(CartUpdated(items));
    }
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(_items.map((e) => e.toMap()).toList());
    await prefs.setString(_prefsKey, encoded);
  }

  Future<void> addItem(CartItem item) async {
    final index = _items.indexWhere((e) => e.id == item.id);
    if (index >= 0) {
      _items[index].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    await _saveToPrefs();
    emit(CartUpdated(items));
  }

  Future<void> removeItem(String id) async {
    _items.removeWhere((e) => e.id == id);
    await _saveToPrefs();
    emit(CartUpdated(items));
  }

  Future<void> increment(String id) async {
    final index = _items.indexWhere((e) => e.id == id);
    if (index >= 0) {
      _items[index].quantity++;
      await _saveToPrefs();
      emit(CartUpdated(items));
    }
  }

  Future<void> decrement(String id) async {
    final index = _items.indexWhere((e) => e.id == id);
    if (index >= 0) {
      final current = _items[index].quantity;
      if (current > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      await _saveToPrefs();
      emit(CartUpdated(items));
    }
  }

  double get subtotal => _items.fold(0.0, (s, e) => s + e.total);

  // when empty show zero
  double get taxAndFees => _items.isEmpty ? 0.0 : 3.0;
  double get deliveryFee => _items.isEmpty ? 0.0 : 2.0;

  double get orderTotal => subtotal + taxAndFees + deliveryFee;
  int get totalItems => _items.fold(0, (s, e) => s + e.quantity);

  Future<void> clear() async {
    _items.clear();
    await _saveToPrefs();
    emit(CartUpdated(items));
  }
}
