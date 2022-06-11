class Goods {
  late int id;
  late String goodsGroup;
  late String goodsName;
  late String imageUrl;
  late String startDate;
  late String endDate;
  String? annotation;
  Goods({
    required this.id,
    required this.goodsGroup,
    required this.goodsName,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    this.annotation,
  });

  Goods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    goodsGroup = json['goodsGroup'];
    goodsName = json['goodsName'];
    imageUrl = json['imageUrl'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    annotation = json['annotation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['goodsGroup'] = this.goodsGroup;
    data['goodsName'] = this.goodsName;
    data['imageUrl'] = this.imageUrl;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['annotation'] = this.annotation;
    return data;
  }
}
