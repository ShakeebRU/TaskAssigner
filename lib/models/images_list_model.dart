class ImagesListModel {
  ImagesListModel({
    required this.status,
    required this.list,
  });
  late bool status;
  late List<Data> list;

  ImagesListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    list = List.from(json['list']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    var _data = <String, dynamic>{};
    _data['status'] = status;
    _data['list'] = list.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.computerNo,
    this.imageBase64,
    this.audioTranslate,
    this.type,
    required this.subID,
    required this.imageURL,
  });
  late int computerNo;
  late Null imageBase64;
  late Null audioTranslate;
  late Null type;
  late int subID;
  late String imageURL;

  Data.fromJson(Map<String, dynamic> json) {
    computerNo = json['computerNo'];
    imageBase64 = null;
    audioTranslate = null;
    type = null;
    subID = json['subID'];
    imageURL = json['imageURL'];
  }

  Map<String, dynamic> toJson() {
    var _data = <String, dynamic>{};
    _data['computerNo'] = computerNo;
    _data['imageBase64'] = imageBase64;
    _data['audioTranslate'] = audioTranslate;
    _data['type'] = type;
    _data['subID'] = subID;
    _data['imageURL'] = imageURL;
    return _data;
  }
}
