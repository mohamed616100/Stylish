class OrdersResponse {
  final OrdersData orders;
  final bool status;

  OrdersResponse({
    required this.orders,
    required this.status,
  });

  factory OrdersResponse.fromJson(Map<String, dynamic> json) {
    return OrdersResponse(
      orders: OrdersData.fromJson(json['orders'] ?? {}),
      status: json['status'] ?? false,
    );
  }
}

class OrdersData {
  final List<OrderModel> active;
  final List<OrderModel> canceled;
  final List<OrderModel> completed;

  OrdersData({
    required this.active,
    required this.canceled,
    required this.completed,
  });

  factory OrdersData.fromJson(Map<String, dynamic> json) {
    return OrdersData(
      active: (json['active'] as List? ?? [])
          .map((e) => OrderModel.fromJson(e))
          .toList(),
      canceled: (json['canceled'] as List? ?? [])
          .map((e) => OrderModel.fromJson(e))
          .toList(),
      completed: (json['completed'] as List? ?? [])
          .map((e) => OrderModel.fromJson(e))
          .toList(),
    );
  }
}

class OrderModel {
  final int id;
  final DriverModel driver;
  final List<OrderItemModel> items;
  final String? orderDate;
  final String? orderChangeDate;
  final double shipping;
  final int status;
  final double subtotal;
  final double tax;
  final double total;

  OrderModel({
    required this.id,
    required this.driver,
    required this.items,
    this.orderDate,
    this.orderChangeDate,
    required this.shipping,
    required this.status,
    required this.subtotal,
    required this.tax,
    required this.total,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      driver: DriverModel.fromJson(json['driver'] ?? {}),
      items: (json['items'] as List? ?? [])
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
      orderDate: json['order_date'],
      orderChangeDate: json['order_change_date'],
      shipping: (json['shipping'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? 0,
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class DriverModel {
  final double latitude;
  final double longitude;
  final String name;
  final String phone;

  DriverModel({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.phone,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}

class OrderItemModel {
  final int id;
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final int quantity;
  final double rating;
  final double totalPrice;

  OrderItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.quantity,
    required this.rating,
    required this.totalPrice,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imagePath: json['image_path'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (json['total_price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
