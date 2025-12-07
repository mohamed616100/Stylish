class CartItem {
  final String id;
  final String title;
  final String? image;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    this.image,
    required this.price,
    this.quantity = 1,
  });

  double get total => price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> m) {
    return CartItem(
      id: m['id']?.toString() ?? '',
      title: m['title'] ?? '',
      image: m['image'],
      price: (m['price'] is num) ? (m['price'] as num).toDouble() : double.tryParse('${m['price']}') ?? 0.0,
      quantity: (m['quantity'] is int) ? m['quantity'] as int : int.tryParse('${m['quantity']}') ?? 1,
    );
  }
}
