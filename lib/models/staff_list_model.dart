class StaffListModel {
  StaffListModel({
    required this.status,
    required this.listdata,
  });
  late final bool status;
  late final List<Listdata> listdata;

  StaffListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    listdata =
        List.from(json['listdata']).map((e) => Listdata.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['listdata'] = listdata.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Listdata {
  Listdata({
    required this.staffID,
    required this.fullName,
    required this.address,
    required this.cell1,
    required this.cell2,
    required this.email,
    required this.cnic,
    required this.remarks,
    required this.status,
  });
  late final int staffID;
  late final String fullName;
  late final String address;
  late final String cell1;
  late final String cell2;
  late final String email;
  late final String cnic;
  late final String remarks;
  late final String status;

  Listdata.fromJson(Map<String, dynamic> json) {
    staffID = json['staffID'];
    fullName = json['fullName'];
    address = json['address'];
    cell1 = json['cell1'];
    cell2 = json['cell2'];
    email = json['email'];
    cnic = json['cnic'] ?? "";
    remarks = json['remarks'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['staffID'] = staffID;
    _data['fullName'] = fullName;
    _data['address'] = address;
    _data['cell1'] = cell1;
    _data['cell2'] = cell2;
    _data['email'] = email;
    _data['cnic'] = cnic;
    _data['remarks'] = remarks;
    _data['status'] = status;
    return _data;
  }
}
