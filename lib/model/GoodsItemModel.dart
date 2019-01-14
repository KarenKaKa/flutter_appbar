class GoodsItemModel {
  String name;
  String id;
  String price;
  String originalPrice;
  String img;
  String discount;
  bool showMoreButton; //是否是查看更多按钮

  GoodsItemModel(
      {this.name,
      this.id,
      this.price,
      this.originalPrice,
      this.img,
      this.discount,
      this.showMoreButton = false}); //原价

  GoodsItemModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        originalPrice = json['originalPrice'],
        img = json['img'],
        discount = json['discount'],
        price = json['price'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'discount': discount,
        'originalPrice': originalPrice,
        'img': img,
        'price': price,
      };
}
