class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['Id'],
      name: json['Name'],
    );
  }
}

class SubCategory {
  final int id;
  final String name;

  SubCategory({required this.id, required this.name});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['Id'],
      name: json['Name'],
    );
  }
}

class Product {
  final int id;
  final String name;
  final String imageUrl;
  final String pricecode;

  Product({required this.id, required this.name, required this.imageUrl , required this.pricecode});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['Id'],
      name: json['Name'],
      imageUrl: json['ImageName'],
      pricecode: json["PriceCode"]
    );
  }
}
