// class TaskTypeModel {
//   TaskTypeModel({
//     required this.taskTypeID,
//     required this.description,
//     required this.remarks,
//     required this.status,
//   });
//   late final int taskTypeID;
//   late final String description;
//   late final String remarks;
//   late final String status;

//   TaskTypeModel.fromJson(Map<String, dynamic> json) {
//     taskTypeID = json['taskTypeID'];
//     description = json['description'];
//     remarks = json['remarks'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['taskTypeID'] = taskTypeID;
//     _data['description'] = description;
//     _data['remarks'] = remarks;
//     _data['status'] = status;
//     return _data;
//   }
// }
class TaskTypeModel {
  TaskTypeModel({
    required this.status,
    required this.listdata,
  });
  late final bool status;
  late final List<Listdata> listdata;

  TaskTypeModel.fromJson(Map<String, dynamic> json) {
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
    required this.taskTypeID,
    required this.description,
    required this.remarks,
    required this.status,
  });
  late final int taskTypeID;
  late final String description;
  late final String remarks;
  late final String status;

  Listdata.fromJson(Map<String, dynamic> json) {
    taskTypeID = json['taskTypeID'];
    description = json['description'];
    remarks = json['remarks'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['taskTypeID'] = taskTypeID;
    _data['description'] = description;
    _data['remarks'] = remarks;
    _data['status'] = status;
    return _data;
  }
}
