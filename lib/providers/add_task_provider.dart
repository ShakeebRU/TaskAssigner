import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taskapp/models/customer_list_model.dart';
import 'package:taskapp/models/result_model.dart';
import 'package:taskapp/models/staff_list_model.dart';
import 'package:taskapp/models/task_type_model.dart';
import 'package:taskapp/utils/utils.dart';
import '../models/staff_controller_model.dart';
import '../models/user_model.dart';
import '../screens/bottom_navigation.dart';
import '../utils/preferences.dart';

class AddTaskProvider with ChangeNotifier {
  UserModel? userData;
  ResultModel? result;
  bool isLoading = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController staffTextController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController messegeController = TextEditingController();
  void disposeControllers() {
    dateController.dispose();
    timeController.dispose();
    emailController.dispose();
    numberController.dispose();
    dateTimeController.dispose();
    customerController.dispose();
    staffTextController.dispose();
    messegeController.dispose();
    descriptionController.dispose();
  }

  String customerCode = '';
  bool isChecked = false;
  String selectedDate = "";
  // String selectedTime = "";
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  int milliseconds = 0;
  String description = "";
  String dateError = "";
  String timeError = "";
  DateTime selectedDateTime = DateTime.now();

  late TaskTypeModel taskTypes;
  String? selectedTaskType;

  CustomerListModel customerList = CustomerListModel.fromJson({"listdata": []});
  CustomerListModel customerSearchList =
      CustomerListModel.fromJson({"listdata": []});

  int? selectedCustumerId;
  late StaffListModel staffList;
  List<String> selectedStaffList = [];
  List<StaffControllerModel> staffController = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(Utils.getTaskTypeList));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      taskTypes = TaskTypeModel.fromJson(jsonData);
    } else {
      // Handle API error
      print("Error");
    }
    await Preferences.init().then((value) {
      userData = value.getAuth();
    });
    await getCustomer();

    await getStaff();
    isLoading = false;
    notifyListeners();
  }

  Future getCustomer() async {
    dynamic header = {'Authorization': "Bearer ${userData!.token}"};
    final response1 = await http.get(
        Uri.parse(Utils.getCustomerList + "?search=${customerController.text}"),
        headers: header);
    if (response1.statusCode == 200) {
      // print(response1.body);
      final jsonData = json.decode(response1.body);
      customerList = CustomerListModel.fromJson(jsonData);
      customerSearchList = CustomerListModel.fromJson(jsonData);
      ;
      print("List Length : ${customerList.listdata.length}");
    } else {
      // Handle API error
      print("Error : ${response1.statusCode}");
      customerList = CustomerListModel.fromJson({"listdata": []});
      customerSearchList = CustomerListModel.fromJson({"listdata": []});
    }
    notifyListeners();
    // return customerList;
  }

  Future getCustumerSearch() async {
    customerSearchList = CustomerListModel.fromJson({"listdata": []});
    if (customerController.text != "") {
      customerSearchList.listdata = customerList.listdata
          .where((element) => element.name
              .toLowerCase()
              .contains(customerController.text.toLowerCase()))
          .toList();
    } else {
      customerSearchList.listdata = customerList.listdata;
    }
  }

  Future<StaffListModel> getStaff() async {
    await Preferences.init().then((value) {
      userData = value.getAuth();
    });
    dynamic header = {'Authorization': "Bearer ${userData!.token}"};
    final response1 =
        await http.get(Uri.parse(Utils.getStaffList), headers: header);
    if (response1.statusCode == 200) {
      final jsonData = json.decode(response1.body);
      staffList = StaffListModel.fromJson(jsonData);
    } else {
      // Handle API error
      print("Error : ${response1.statusCode}");
      staffList = StaffListModel.fromJson({"listdata": []});
    }
    notifyListeners();
    return staffList;
  }

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        dateTimeController.text = selectedDateTime.toString();
        notifyListeners();
      }
    }
  }

  void setIsChecked(bool val) {
    isChecked = val;
    notifyListeners();
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          selectedDate != "" ? DateTime.parse(selectedDate) : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      selectedDate = picked.toString();
      dateController.text = selectedDate.toString().substring(0, 10);
      dateError = "";
      notifyListeners();
    }
  }

  void selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      hours = picked.hour;
      minutes = picked.minute;
      timeController.text = "$hours:$minutes:$seconds:$milliseconds";
      timeError = "";
      notifyListeners();
    }
  }

  XFile? pickedImage;
  Future<void> pickImage() async {
    final PermissionStatus status = await Permission.camera.request();
    // final PermissionStatus status = await Permission.photos.request();
    if (status.isGranted) {
      final picker = ImagePicker();
      final pickedImage1 = await picker.pickImage(source: ImageSource.gallery);
      pickedImage = pickedImage1;
      notifyListeners();
    } else if (status.isDenied) {
      // Handle denied permission
      print('Permission denied');
    } else if (status.isPermanentlyDenied) {
      // Handle permanently denied permission
      print('Permission permanently denied');
    }
  }

  Future<void> submitForm(BuildContext context) async {
    print("clicked");
    if (formKey.currentState!.validate() && selectedTaskType != null) {
      // Form is valid, process the data
      await createTask(context);
      print("valid");
    } else {
      // Form has validation errors, show error messages
      if (dateController.text == "") {
        dateError = 'Please select a date';
      }
      if (timeController.text == "") {
        timeError = 'Please select a time';
      }
      if (selectedTaskType == null) {
        Utils.flushBarErrorMessage("Select Task Type", context);
      }
    }
  }

  Future createTask(BuildContext context) async {
    Map<String, dynamic> data = {
      "taskTypeID": int.parse(selectedTaskType!),
      "taskDate": dateController.text,
      "taskTime": {
        "ticks": 0,
        "days": 0,
        "hours": hours,
        "milliseconds": 0,
        "minutes": minutes,
        "seconds": 0
      },
      "userID": userData!.userID,
      "taskDetail": description,
      "detailCode": selectedCustumerId!,
      "contactNoEmail": emailController.text,
      "contactPerson": numberController.text,
      "dueDateAlert": isChecked ? 1 : 0,
      "dueDateTime": dateTimeController.text != ""
          ? dateTimeController.text.replaceFirst(" ", "T")
          : "",
      "MessageType": "Text",
      "stafflist": staffController,
    };

    print("Data : {${jsonEncode(data)}}");
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userData!.token}'
    };
    Response response = await post(Uri.parse(Utils.createtask),
        headers: header, body: jsonEncode(data));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      result = ResultModel.fromJson(jsonData);
      if (result!.status) {
        Utils.flushBarSuccessfulMessage("Task Created Successfully", context);
        staffController = [];
        dateController.clear();
        timeController.clear();
        emailController.clear();
        description = "";
        descriptionController.clear();
        numberController.clear();
        dateTimeController.clear();
        customerController.clear();
        staffTextController.clear();
        selectedTaskType = null;
        isChecked = false;
        selectedCustumerId = null;
        notifyListeners();
      }

      // print(jsonData);
    } else {
      // Handle API error
      print("Error : ${response.body}");
    }
  }

  String str = "";
  String messegeText = "";
  Future<String> imageToBase64(XFile imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print(base64Image);
    return base64Image;
  }

  Future uplaodAudioImage(BuildContext context) async {
    if (pickedImage != null) {
      str = await imageToBase64(pickedImage!);
      // str = base64Encode(utf8.encode(str));
    }
    Map<String, dynamic> data = {
      "computerNo": int.parse(result!.returnId),
      "imageBase64": str,
      "audioTranslate": messegeText,
      "type": pickedImage != null
          ? "Image"
          : str != ""
              ? "Audio"
              : "Text"
    };
    print("token : {${userData!.token}}");
    Map<String, String> header = {
      'Authorization': 'Bearer ${userData!.token}',
      'Content-Type': 'application/json'
    };
    Response response = await post(Uri.parse(Utils.uploadAudioImage),
        headers: header, body: jsonEncode(data));
    if (response.statusCode == 200) {
      print("data: ${result!.returnId}");
      final jsonData = json.decode(response.body);
      ResultModel result1 = ResultModel.fromJson(jsonData);
      if (result1.status) {
        Utils.flushBarSuccessfulMessage("uploaded Successfully", context);
        messegeController.clear();
        pickedImage = null;
        notifyListeners();
        result = null;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNAvigation()));
      }

      // print(jsonData);
    } else {
      // Handle API error
      print("Error : ${response.statusCode}");
    }
  }
}
