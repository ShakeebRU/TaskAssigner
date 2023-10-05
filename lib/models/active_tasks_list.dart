// class ActiveTasksModel {
//   ActiveTasksModel({
//     required this.listdata,
//   });
//   late List<Listdata> listdata;

//   ActiveTasksModel.fromJson(Map<String, dynamic> json) {
//     listdata =
//         List.from(json['listdata']).map((e) => Listdata.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['listdata'] = listdata.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

// class Listdata {
//   Listdata({
//     required this.taskID,
//     required this.saveDateTime,
//     required this.saveDateTimeString,
//     required this.taskTypeID,
//     required this.taskTypeName,
//     required this.taskDate,
//     required this.taskDateString,
//     this.taskDateTime,
//     required this.taskTime,
//     required this.taskTimeString,
//     this.userID,
//     this.toUserID,
//     this.toUserName,
//     required this.employeeID,
//     required this.employeeName,
//     required this.taskDetail,
//     required this.detailCode,
//     required this.detailName,
//     required this.contactNoEmail,
//     required this.contactPerson,
//     required this.dueDateAlert,
//     required this.dueDateTime,
//     required this.acknowledgeDateTime,
//     required this.doneDateTime,
//     required this.postDateTime,
//     required this.postRemarks,
//     required this.ratingPoints,
//     required this.status,
//     this.result,
//     this.chatType,
//     this.messageType,
//     this.stafflist,
//     this.docURL,
//     this.documentsURLList,
//   });
//   late final int taskID;
//   late final String saveDateTime;
//   late final String saveDateTimeString;
//   late final int taskTypeID;
//   late final String taskTypeName;
//   late final String taskDate;
//   late final String taskDateString;
//   late final Null taskDateTime;
//   late final TaskTime taskTime;
//   late final String taskTimeString;
//   late final Null userID;
//   late final Null toUserID;
//   late final Null toUserName;
//   late final int employeeID;
//   late final String employeeName;
//   late final String taskDetail;
//   late final double detailCode;
//   late final String detailName;
//   late final String contactNoEmail;
//   late final String contactPerson;
//   late final int dueDateAlert;
//   late final String dueDateTime;
//   late final String acknowledgeDateTime;
//   late final String doneDateTime;
//   late final String postDateTime;
//   late final String postRemarks;
//   late final int ratingPoints;
//   late final String status;
//   late final String result;
//   late final String chatType;
//   late final String messageType;
//   late final String stafflist;
//   late final String docURL;
//   late final String documentsURLList;

//   Listdata.fromJson(Map<String, dynamic> json) {
//     taskID = json['taskID'];
//     saveDateTime = json['saveDateTime'];
//     saveDateTimeString = json['saveDateTimeString'];
//     taskTypeID = json['taskTypeID'];
//     taskTypeName = json['taskTypeName'];
//     taskDate = json['taskDate'];
//     taskDateString = json['taskDateString'];
//     taskDateTime = null;
//     taskTime = TaskTime.fromJson(json['taskTime']);
//     taskTimeString = json['taskTimeString'];
//     userID = null;
//     toUserID = null;
//     toUserName = null;
//     employeeID = json['employeeID'];
//     employeeName = json['employeeName'];
//     taskDetail = json['taskDetail'];
//     detailCode = json['detailCode'];
//     detailName = json['detailName'];
//     contactNoEmail = json['contactNoEmail'];
//     contactPerson = json['contactPerson'];
//     dueDateAlert = json['dueDateAlert'];
//     dueDateTime = json['dueDateTime'];
//     acknowledgeDateTime = json['acknowledgeDateTime'];
//     doneDateTime = json['doneDateTime'];
//     postDateTime = json['postDateTime'];
//     postRemarks = json['postRemarks'];
//     ratingPoints = json['ratingPoints'];
//     status = json['status'];
//     result = null;
//     chatType = null;
//     messageType = null;
//     stafflist = null;
//     docURL = null;
//     documentsURLList = null;
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['taskID'] = taskID;
//     _data['saveDateTime'] = saveDateTime;
//     _data['saveDateTimeString'] = saveDateTimeString;
//     _data['taskTypeID'] = taskTypeID;
//     _data['taskTypeName'] = taskTypeName;
//     _data['taskDate'] = taskDate;
//     _data['taskDateString'] = taskDateString;
//     _data['taskDateTime'] = taskDateTime;
//     _data['taskTime'] = taskTime.toJson();
//     _data['taskTimeString'] = taskTimeString;
//     _data['userID'] = userID;
//     _data['toUserID'] = toUserID;
//     _data['toUserName'] = toUserName;
//     _data['employeeID'] = employeeID;
//     _data['employeeName'] = employeeName;
//     _data['taskDetail'] = taskDetail;
//     _data['detailCode'] = detailCode;
//     _data['detailName'] = detailName;
//     _data['contactNoEmail'] = contactNoEmail;
//     _data['contactPerson'] = contactPerson;
//     _data['dueDateAlert'] = dueDateAlert;
//     _data['dueDateTime'] = dueDateTime;
//     _data['acknowledgeDateTime'] = acknowledgeDateTime;
//     _data['doneDateTime'] = doneDateTime;
//     _data['postDateTime'] = postDateTime;
//     _data['postRemarks'] = postRemarks;
//     _data['ratingPoints'] = ratingPoints;
//     _data['status'] = status;
//     _data['result'] = result;
//     _data['chatType'] = chatType;
//     _data['messageType'] = messageType;
//     _data['stafflist'] = stafflist;
//     _data['docURL'] = docURL;
//     _data['documentsURLList'] = documentsURLList;
//     return _data;
//   }
// }

// class TaskTime {
//   TaskTime({
//     required this.hasValue,
//     required this.value,
//   });
//   late final bool hasValue;
//   late final Value value;

//   TaskTime.fromJson(Map<String, dynamic> json) {
//     hasValue = json['hasValue'];
//     value = Value.fromJson(json['value']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['hasValue'] = hasValue;
//     _data['value'] = value.toJson();
//     return _data;
//   }
// }

// class Value {
//   Value({
//     required this.ticks,
//     required this.days,
//     required this.hours,
//     required this.milliseconds,
//     required this.minutes,
//     required this.seconds,
//     required this.totalDays,
//     required this.totalHours,
//     required this.totalMilliseconds,
//     required this.totalMinutes,
//     required this.totalSeconds,
//   });
//   late final double ticks;
//   late final double days;
//   late final double hours;
//   late final double milliseconds;
//   late final double minutes;
//   late final double seconds;
//   late final double totalDays;
//   late final double totalHours;
//   late final double totalMilliseconds;
//   late final double totalMinutes;
//   late final double totalSeconds;

//   Value.fromJson(Map<String, dynamic> json) {
//     ticks = double.parse(json['ticks'].toString());
//     days = double.parse(json['days'].toString());
//     hours = double.parse(json['hours'].toString());
//     milliseconds = double.parse(json['milliseconds'].toString());
//     minutes = double.parse(json['minutes'].toString());
//     seconds = double.parse(json['seconds'].toString());
//     totalDays = double.parse(json['totalDays'].toString());
//     totalHours = double.parse(json['totalHours'].toString());
//     totalMilliseconds = double.parse(json['totalMilliseconds'].toString());
//     totalMinutes = double.parse(json['totalMinutes'].toString());
//     totalSeconds = double.parse(json['totalSeconds'].toString());
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['ticks'] = ticks;
//     _data['days'] = days;
//     _data['hours'] = hours;
//     _data['milliseconds'] = milliseconds;
//     _data['minutes'] = minutes;
//     _data['seconds'] = seconds;
//     _data['totalDays'] = totalDays;
//     _data['totalHours'] = totalHours;
//     _data['totalMilliseconds'] = totalMilliseconds;
//     _data['totalMinutes'] = totalMinutes;
//     _data['totalSeconds'] = totalSeconds;
//     return _data;
//   }
// }

class ActiveTasksModel {
  ActiveTasksModel({
    required this.listdata,
  });
  late final List<Listdata> listdata;

  ActiveTasksModel.fromJson(Map<String, dynamic> json) {
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
    required this.taskID,
    required this.saveDateTime,
    required this.saveDateTimeString,
    required this.taskTypeID,
    required this.taskTypeName,
    required this.taskDate,
    required this.taskDateString,
    this.taskDateTime,
    required this.taskTime,
    required this.taskTimeString,
    this.userID,
    this.toUserID,
    this.toUserName,
    required this.employeeID,
    required this.employeeName,
    required this.taskDetail,
    required this.detailCode,
    required this.detailName,
    required this.contactNoEmail,
    required this.contactPerson,
    required this.dueDateAlert,
    required this.dueDateTime,
    required this.acknowledgeDateTime,
    required this.doneDateTime,
    required this.doneRemarks,
    required this.doneDateTimeString,
    required this.postDateTime,
    this.postDateTimeString,
    required this.postRemarks,
    required this.ratingPoints,
    required this.status,
    this.result,
    this.chatType,
    required this.messageType,
    required this.docURL,
  });
  late final int taskID;
  late final String saveDateTime;
  late final String saveDateTimeString;
  late final int taskTypeID;
  late final String taskTypeName;
  late final String taskDate;
  late final String taskDateString;
  late final Null taskDateTime;
  late final TaskTime taskTime;
  late final String taskTimeString;
  late final Null userID;
  late final Null toUserID;
  late final Null toUserName;
  late final int employeeID;
  late final String employeeName;
  late final String taskDetail;
  late final double detailCode;
  late final String detailName;
  late final String contactNoEmail;
  late final String contactPerson;
  late final int dueDateAlert;
  late final String dueDateTime;
  late final String acknowledgeDateTime;
  late final String doneDateTime;
  late final String doneRemarks;
  late final String doneDateTimeString;
  late final String postDateTime;
  late final Null postDateTimeString;
  late final String postRemarks;
  late final int ratingPoints;
  late final String status;
  late final Null result;
  late final Null chatType;
  late final String messageType;
  late final String docURL;

  Listdata.fromJson(Map<String, dynamic> json) {
    taskID = json['taskID'];
    saveDateTime = json['saveDateTime'];
    saveDateTimeString = json['saveDateTimeString'];
    taskTypeID = json['taskTypeID'];
    taskTypeName = json['taskTypeName'];
    taskDate = json['taskDate'];
    taskDateString = json['taskDateString'];
    taskDateTime = null;
    taskTime = TaskTime.fromJson(json['taskTime']);
    taskTimeString = json['taskTimeString'];
    userID = null;
    toUserID = null;
    toUserName = null;
    employeeID = json['employeeID'];
    employeeName = json['employeeName'];
    taskDetail = json['taskDetail'];
    detailCode = json['detailCode'];
    detailName = json['detailName'];
    contactNoEmail = json['contactNoEmail'];
    contactPerson = json['contactPerson'];
    dueDateAlert = json['dueDateAlert'];
    dueDateTime = json['dueDateTime'];
    acknowledgeDateTime = json['acknowledgeDateTime'];
    doneDateTime = json['doneDateTime'];
    doneRemarks = json['doneRemarks'];
    doneDateTimeString = json['doneDateTimeString'];
    postDateTime = json['postDateTime'];
    postDateTimeString = null;
    postRemarks = json['postRemarks'];
    ratingPoints = json['ratingPoints'];
    status = json['status'];
    result = null;
    chatType = null;
    messageType = json['messageType'];
    docURL = json['docURL'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['taskID'] = taskID;
    _data['saveDateTime'] = saveDateTime;
    _data['saveDateTimeString'] = saveDateTimeString;
    _data['taskTypeID'] = taskTypeID;
    _data['taskTypeName'] = taskTypeName;
    _data['taskDate'] = taskDate;
    _data['taskDateString'] = taskDateString;
    _data['taskDateTime'] = taskDateTime;
    _data['taskTime'] = taskTime.toJson();
    _data['taskTimeString'] = taskTimeString;
    _data['userID'] = userID;
    _data['toUserID'] = toUserID;
    _data['toUserName'] = toUserName;
    _data['employeeID'] = employeeID;
    _data['employeeName'] = employeeName;
    _data['taskDetail'] = taskDetail;
    _data['detailCode'] = detailCode;
    _data['detailName'] = detailName;
    _data['contactNoEmail'] = contactNoEmail;
    _data['contactPerson'] = contactPerson;
    _data['dueDateAlert'] = dueDateAlert;
    _data['dueDateTime'] = dueDateTime;
    _data['acknowledgeDateTime'] = acknowledgeDateTime;
    _data['doneDateTime'] = doneDateTime;
    _data['doneRemarks'] = doneRemarks;
    _data['doneDateTimeString'] = doneDateTimeString;
    _data['postDateTime'] = postDateTime;
    _data['postDateTimeString'] = postDateTimeString;
    _data['postRemarks'] = postRemarks;
    _data['ratingPoints'] = ratingPoints;
    _data['status'] = status;
    _data['result'] = result;
    _data['chatType'] = chatType;
    _data['messageType'] = messageType;
    _data['docURL'] = docURL;
    return _data;
  }
}

class TaskTime {
  TaskTime({
    required this.hasValue,
    required this.value,
  });
  late final bool hasValue;
  late final Value value;

  TaskTime.fromJson(Map<String, dynamic> json) {
    hasValue = json['hasValue'];
    value = Value.fromJson(json['value']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hasValue'] = hasValue;
    _data['value'] = value.toJson();
    return _data;
  }
}

class Value {
  Value({
    required this.ticks,
    required this.days,
    required this.hours,
    required this.milliseconds,
    required this.minutes,
    required this.seconds,
    required this.totalDays,
    required this.totalHours,
    required this.totalMilliseconds,
    required this.totalMinutes,
    required this.totalSeconds,
  });
  late final double ticks;
  late final double days;
  late final double hours;
  late final double milliseconds;
  late final double minutes;
  late final double seconds;
  late final double totalDays;
  late final double totalHours;
  late final double totalMilliseconds;
  late final double totalMinutes;
  late final double totalSeconds;

  Value.fromJson(Map<String, dynamic> json) {
    ticks = double.parse(json['ticks'].toString());
    days = double.parse(json['days'].toString());
    hours = double.parse(json['hours'].toString());
    milliseconds = double.parse(json['milliseconds'].toString());
    minutes = double.parse(json['minutes'].toString());
    seconds = double.parse(json['seconds'].toString());
    totalDays = double.parse(json['totalDays'].toString());
    totalHours = double.parse(json['totalHours'].toString());
    totalMilliseconds = double.parse(json['totalMilliseconds'].toString());
    totalMinutes = double.parse(json['totalMinutes'].toString());
    totalSeconds = double.parse(json['totalSeconds'].toString());
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ticks'] = ticks;
    _data['days'] = days;
    _data['hours'] = hours;
    _data['milliseconds'] = milliseconds;
    _data['minutes'] = minutes;
    _data['seconds'] = seconds;
    _data['totalDays'] = totalDays;
    _data['totalHours'] = totalHours;
    _data['totalMilliseconds'] = totalMilliseconds;
    _data['totalMinutes'] = totalMinutes;
    _data['totalSeconds'] = totalSeconds;
    return _data;
  }
}
