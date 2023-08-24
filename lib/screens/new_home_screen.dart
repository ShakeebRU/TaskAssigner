import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/providers/new_home_screen_provider.dart';
import 'package:taskapp/screens/select_messege_type_screen.dart';
import '../models/staff_controller_model.dart';
import '../models/staff_list_model.dart';
import '../utils/utils.dart';
import 'chat_screen.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color(0xFFF5FFFF),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 230, 230, 230),
          // backgroundColor: Utils.backgroudColor,
          leading: Consumer<NewHomeScreenProvider>(
              builder: (context, controller, child) =>
                  controller.selectedStaffList.length == 0
                      ? IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_outlined,
                              color: Colors.white))
                      : IconButton(
                          onPressed: () {
                            // Navigator.of(context).pop();
                            controller.selectedStaffList = [];
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: controller.selectedStaffList.length != 0
                                ? Colors.white
                                : Utils.backgroudColor,
                          ))),
          title: const Center(
            child: Text(
              "Create Task",
              style: TextStyle(color: Colors.white),
            ),
          ),
          flexibleSpace: Container(
            height: height * 0.15,
            // width: width,
            decoration: const BoxDecoration(
                color: Utils.backgroudColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          ),
          actions: [
            Consumer<NewHomeScreenProvider>(
                builder: (context, controller, child) => IconButton(
                    onPressed: () async {
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
                      await controller.uplaodAudioImage(context);
                      // controller.staffTextController.text =
                      //     str.substring(1, str.length - 1);
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return const SelectMessageTypes();
                      // }));
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.check,
                      color: controller.selectedStaffList.length != 0
                          ? Colors.white
                          : Utils.backgroudColor,
                    )))
          ],
        ),
        body: Consumer<NewHomeScreenProvider>(
          builder: (context, controller, child) =>
              FutureBuilder<StaffListModel>(
            future: controller.getStaff(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("try again latter "),
                );
              } else if (snapshot.hasData) {
                return ListView(
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
                            onTap: () {
                              // controller.customerController.text = controller
                              //     .customerList.listdata[index].name
                              //     .toString();
                              // controller.customerCode = controller
                              //     .customerList.listdata[index].customerCode
                              //     .toString();
                              // Navigator.of(context).pop();
                            },
                            leading: Text(controller
                                .staffList.listdata[index].staffID
                                .toString()),
                            title: Text(
                                controller.staffList.listdata[index].fullName),
                            subtitle: Text(
                                controller.staffList.listdata[index].email),
                            trailing: Checkbox(
                              value: controller.selectedStaffList.contains(
                                  controller
                                      .staffList.listdata[index].fullName),
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
                );
              }
              return Center(
                child: Container(
                  height: height * 0.05,
                  width: width * 0.3,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  color: Colors.grey,
                  child: const Row(
                    children: [
                      CircularProgressIndicator(
                        color: Utils.backgroudColor,
                        strokeWidth: 3,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Loading",
                        style: TextStyle(
                            fontSize: 15, color: Utils.backgroudColor),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
