class CustomerListModel {
  CustomerListModel({
    required this.listdata,
  });
  late final List<Listdata> listdata;

  CustomerListModel.fromJson(Map<String, dynamic> json) {
    listdata =
        List.from(json['listdata']).map((e) => Listdata.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['listdata'] = listdata.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Listdata {
  Listdata({
    required this.customerCode,
    required this.name,
    required this.urduName,
    required this.cityName,
  });
  late final int customerCode;
  late final String name;
  late final String urduName;
  late final String cityName;

  Listdata.fromJson(Map<String, dynamic> json) {
    customerCode = json['customerCode'];
    name = json['name'];
    urduName = json['urduName'];
    cityName = json['cityName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customerCode'] = customerCode;
    _data['name'] = name;
    _data['urduName'] = urduName;
    _data['cityName'] = cityName;
    return _data;
  }
}
