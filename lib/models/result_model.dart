class ResultModel {
  ResultModel({
    required this.status,
    required this.returnId,
    required this.returnMessage,
  });
  late final bool status;
  late final String returnId;
  late final String returnMessage;

  ResultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    returnId = json['returnId'] ?? "";
    returnMessage = json['returnMessage'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['returnId'] = returnId;
    _data['returnMessage'] = returnMessage;
    return _data;
  }
}
