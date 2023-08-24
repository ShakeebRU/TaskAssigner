class StaffControllerModel {
  StaffControllerModel({
    required this.staffID,
  });
  late final int staffID;

  StaffControllerModel.fromJson(Map<String, dynamic> json) {
    staffID = json['staffID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['staffID'] = staffID;
    return _data;
  }
}
