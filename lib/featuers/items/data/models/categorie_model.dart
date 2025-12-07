import '../../../home/data/models/product_model.dart';

class CategorieModel {
  List<Categories>? categories;
  bool? status;

  CategorieModel({this.categories, this.status});

  CategorieModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Categories {
  String? description;
  int? id;
  String? imagePath;
  List<Products>? products;
  String? title;

  Categories(
      {this.description, this.id, this.imagePath, this.products, this.title});

  Categories.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    imagePath = json['image_path'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['image_path'] = this.imagePath;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    return data;
  }
}


