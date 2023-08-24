import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/models/staff_controller_model.dart';

import '../providers/add_task_provider.dart';
import '../utils/utils.dart';

class StaffListScreen extends StatefulWidget {
  const StaffListScreen({super.key});

  @override
  State<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xFFF5FFFF),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 230, 230, 230),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          title: const Text(
            "Select Customer",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Consumer<AddTaskProvider>(
                builder: (context, controller, child) => IconButton(
                    onPressed: () {
                      controller.staffController = [];
                      controller.staffList.listdata.forEach((element) {
                        if (controller.selectedStaffList
                            .contains(element.fullName)) {
                          // print("Element : $element");
                          controller.staffController.add(StaffControllerModel(
                              staffID: controller
                                  .staffList
                                  .listdata[controller.staffList.listdata
                                      .indexOf(element)]
                                  .staffID));
                        }
                        print("Staffs : ${controller.staffController}");
                      });
                      String str = controller.selectedStaffList.toString();

                      controller.staffTextController.text =
                          str.substring(1, str.length - 1);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.check, color: Colors.white)))
          ],
          flexibleSpace: Container(
            // height: height * 0.1,
            // width: width,
            decoration: BoxDecoration(
                color: Utils.backgroudColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<AddTaskProvider>(
            builder: (context, controller, child) => ListView(
              children: [
                Container(
                  height: height * 0.7,
                  width: width,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: controller.staffList.listdata.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: Colors.grey,
                        height: 2,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        // onTap: () {
                        //   // controller.customerController.text = controller
                        //   //     .customerList.listdata[index].name
                        //   //     .toString();
                        //   // controller.customerCode = controller
                        //   //     .customerList.listdata[index].customerCode
                        //   //     .toString();
                        //   // Navigator.of(context).pop();
                        // },
                        leading: Text(controller
                            .staffList.listdata[index].staffID
                            .toString()),
                        title:
                            Text(controller.staffList.listdata[index].fullName),
                        subtitle:
                            Text(controller.staffList.listdata[index].email),
                        trailing: Checkbox(
                          value: controller.selectedStaffList.contains(
                              controller.staffList.listdata[index].fullName),
                          onChanged: (check) {
                            if (check == true) {
                              controller.selectedStaffList.add(controller
                                  .staffList.listdata[index].fullName);
                            } else {
                              controller.selectedStaffList.remove(controller
                                  .staffList.listdata[index].fullName);
                            }
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
