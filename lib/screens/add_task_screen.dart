import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/providers/add_task_provider.dart';
import 'package:taskapp/screens/image_pick_screen.dart';
import 'package:taskapp/screens/staff_list_screen.dart';
import 'package:taskapp/screens/upload_voice_text_screen.dart';

import '../utils/utils.dart';
import 'customer_list_screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AddTaskProvider>(context, listen: false).fetchData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // Provider.of<AddTaskProvider>(context, listen: false).disposeControllers();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color(0xFFF5FFFF),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 230, 230, 230),
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          title: const Text(
            "Add Task",
            style: TextStyle(color: Colors.white),
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
        ),
        body: Consumer<AddTaskProvider>(
          builder: (context, controller, child) => controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Utils.backgroudColor),
                )
              : Form(
                  key: controller.formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(
                      children: [
                        const Text(
                          'Name:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0xFFEAF2F4)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x14202020),
                                blurRadius: 15,
                                offset: Offset(0, 6),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: TextFormField(
                                      // keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          hintText: "Enter Name",
                                          border: InputBorder.none),
                                      // validator: (value) {
                                      //   final RegExp phoneRegExp =
                                      //       RegExp(r'^03\d{2}-?\d{7}$');
                                      //   if (controller.numberController.text !=
                                      //           "" &&
                                      //       !phoneRegExp.hasMatch(controller
                                      //           .numberController.text)) {
                                      //     return 'Please Enter valid number';
                                      //   }
                                      //   return null;
                                      // },
                                      controller: controller.numberController),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.person,
                                    color: Utils.backgroudColor,
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'E-mail/Phone:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0xFFEAF2F4)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x14202020),
                                blurRadius: 15,
                                offset: Offset(0, 6),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: TextFormField(
                                      decoration: const InputDecoration(
                                          hintText: "Enter E-mail / Phone",
                                          border: InputBorder.none),
                                      controller: controller.emailController),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.mail,
                                    color: Utils.backgroudColor,
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Select Date:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0xFFEAF2F4)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x14202020),
                                blurRadius: 15,
                                offset: Offset(0, 6),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: TextFormField(
                                      decoration: const InputDecoration(
                                          hintText: "YYYY-MM-DD",
                                          border: InputBorder.none),
                                      onTap: () =>
                                          controller.selectDate(context),
                                      readOnly: true,
                                      validator: (value) {
                                        if (controller.dateController.text ==
                                            '') {
                                          return 'Please select a date';
                                        }
                                        return null;
                                      },
                                      controller: controller.dateController),
                                ),
                              ),
                              IconButton(
                                  onPressed: () =>
                                      controller.selectDate(context),
                                  icon: const Icon(
                                    Icons.date_range,
                                    color: Utils.backgroudColor,
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Select Time:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0xFFEAF2F4)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x14202020),
                                blurRadius: 15,
                                offset: Offset(0, 6),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: TextFormField(
                                      decoration: const InputDecoration(
                                          hintText: "hh:mm:ss",
                                          border: InputBorder.none),
                                      onTap: () {
                                        controller.selectTime(context);
                                      },
                                      readOnly: true,
                                      validator: (value) {
                                        if (controller.timeController.text ==
                                            '') {
                                          return 'Please select a time';
                                        }
                                        return null;
                                      },
                                      controller: controller.timeController),
                                ),
                              ),
                              IconButton(
                                  onPressed: () =>
                                      controller.selectTime(context),
                                  icon: const Icon(
                                    Icons.timer,
                                    color: Utils.backgroudColor,
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Description:",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 4),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0xFFEAF2F4)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x14202020),
                                blurRadius: 15,
                                offset: Offset(0, 6),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: TextFormField(
                            controller: controller.descriptionController,
                            decoration: const InputDecoration(
                                hintText: "Enter Description",
                                border: InputBorder.none),
                            maxLines: 4,
                            onChanged: (value) {
                              setState(() {
                                controller.description = value;
                              });
                            },
                            validator: (value) {
                              if (controller.description == '') {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: controller.isChecked,
                              onChanged: (newValue) {
                                // setState(() {
                                //   controller.isChecked = newValue!;
                                // });
                                controller.setIsChecked(newValue!);
                              },
                            ),
                            const Text(
                              "Set Due Date",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        controller.isChecked
                            ? Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Select Due Date:',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Container(
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFEAF2F4)),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        shadows: const [
                                          BoxShadow(
                                            color: Color(0x14202020),
                                            blurRadius: 15,
                                            offset: Offset(0, 6),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 4),
                                              child: TextFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "Select DateTime",
                                                          border:
                                                              InputBorder.none),
                                                  onTap: () => controller
                                                      .selectDateTime(context),
                                                  readOnly: true,
                                                  // validator: (value) {
                                                  //   if (controller
                                                  //           .dateTimeController.text ==
                                                  //       '') {
                                                  //     return 'Please select a date';
                                                  //   }
                                                  //   return null;
                                                  // },
                                                  controller: controller
                                                      .dateTimeController),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () => controller
                                                  .selectDateTime(context),
                                              icon: const Icon(
                                                Icons.calendar_month,
                                                color: Utils.backgroudColor,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.only(left: 4),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0xFFEAF2F4)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x14202020),
                                blurRadius: 15,
                                offset: Offset(0, 6),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              isExpanded: true,
                              iconSize: 20,
                              value: controller.selectedTaskType,
                              onChanged: (newValue) {
                                setState(() {
                                  controller.selectedTaskType = newValue!;
                                });
                              },
                              items: controller.taskTypes.listdata
                                  .map<DropdownMenuItem<String>>((item) {
                                return DropdownMenuItem<String>(
                                  value: item.taskTypeID.toString(),
                                  child: Text(
                                    item.description,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              hint: const Text('Select Task Type'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Select Customer:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0xFFEAF2F4)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x14202020),
                                blurRadius: 15,
                                offset: Offset(0, 6),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: TextFormField(
                                      onTap: () => Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const CustomerListScreen();
                                          })),
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          hintText: "Customer Name",
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (controller
                                                .customerController.text ==
                                            '') {
                                          return 'Please select a custumer';
                                        }
                                        return null;
                                      },
                                      controller:
                                          controller.customerController),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Select Staff List',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0xFFEAF2F4)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x14202020),
                                blurRadius: 15,
                                offset: Offset(0, 6),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: TextFormField(
                                      onTap: () => Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return const StaffListScreen();
                                          })),
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                          hintText: "Staff Members",
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (controller
                                                .staffTextController.text ==
                                            '') {
                                          return 'Please select staff members';
                                        }
                                        return null;
                                      },
                                      controller:
                                          controller.staffTextController),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                await controller.submitForm(context);
                                Future.delayed(Duration(seconds: 1));
                                // Navigator.of(context).pop();
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: height * 0.05,
                                    // padding: EdgeInsets.symmetric(
                                    //   horizontal: width * 0.2,
                                    // ),
                                    child: Container(
                                      width: width * 0.25,
                                      height: height * 0.05,
                                      decoration: ShapeDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment(1.00, 0.06),
                                          end: Alignment(-1, -0.06),
                                          colors: [
                                            Utils.lightbackgroudColor,
                                            Utils.backgroudColor
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'Save',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await controller.submitForm(context);
                                if (controller.result != null) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const ImagePickScreen();
                                  }));
                                }
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: height * 0.05,
                                    // padding: EdgeInsets.symmetric(
                                    //   horizontal: width * 0.2,
                                    // ),
                                    child: Container(
                                      width: width * 0.25,
                                      height: height * 0.05,
                                      decoration: ShapeDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment(1.00, 0.06),
                                          end: Alignment(-1, -0.06),
                                          colors: [
                                            Utils.lightbackgroudColor,
                                            Utils.backgroudColor
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'Image',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await controller.submitForm(context);
                                if (controller.result != null) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (Context) {
                                    return SpeechRecognitionScreen();
                                  }));
                                }
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: height * 0.05,
                                    // padding: EdgeInsets.symmetric(
                                    //   horizontal: width * 0.2,
                                    // ),
                                    child: Container(
                                      width: width * 0.25,
                                      height: height * 0.05,
                                      decoration: ShapeDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment(1.00, 0.06),
                                          end: Alignment(-1, -0.06),
                                          colors: [
                                            Utils.lightbackgroudColor,
                                            Utils.backgroudColor
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'Audio',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
        ));
  }
}
