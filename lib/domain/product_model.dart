class ProductModel {
  String? message;
  List<ProductData> data = [];
  ProductModel();
  ProductModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    json["data"].forEach((element) {
      data.add(ProductData.fromJson(element));
    });
  }
}

class ProductData {
  late String productId;
  late String name;
  late String description;
  late String imageUrl;
  late String type;
  late int price;

  ProductData.fromJson(Map<String, dynamic> json) {
    productId = json["productId"];
    name = json["name"];
    description = json["description"];
    imageUrl = json["imageUrl"];
    type = json["type"];
    price = json["price"];
  }
}
