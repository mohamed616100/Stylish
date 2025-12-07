class ProductModel {
  List<Products>? products;
  bool? status;

  ProductModel({this.products, this.status});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Products {
  int? bestSeller;
  Category? category;
  String? description;
  int? id;
  String? imagePath;
  bool? isFavorite;
  String? name;
  double? price;
  double? rating;

  Products(
      {this.bestSeller,
        this.category,
        this.description,
        this.id,
        this.imagePath,
        this.isFavorite,
        this.name,
        this.price,
        this.rating});

  Products.fromJson(Map<String, dynamic> json) {
    bestSeller = json['best_seller'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    description = json['description'];
    id = json['id'];
    imagePath = json['image_path'];
    isFavorite = json['is_favorite'];
    name = json['name'];
    price = json['price'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['best_seller'] = this.bestSeller;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['description'] = this.description;
    data['id'] = this.id;
    data['image_path'] = this.imagePath;
    data['is_favorite'] = this.isFavorite;
    data['name'] = this.name;
    data['price'] = this.price;
    data['rating'] = this.rating;
    return data;
  }
}

class Category {
  String? description;
  int? id;
  String? imagePath;
  String? title;

  Category({this.description, this.id, this.imagePath, this.title});

  Category.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    imagePath = json['image_path'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['image_path'] = this.imagePath;
    data['title'] = this.title;
    return data;
  }
}
