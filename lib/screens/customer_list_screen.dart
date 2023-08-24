import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/add_task_provider.dart';
import '../utils/utils.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  final focus = FocusNode();
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
                              onChanged: (value) async {
                                await controller.getCustomer();
                              },
                              decoration: const InputDecoration(
                                  hintText: "Search Customer",
                                  border: InputBorder.none),
                              controller: controller.customerController),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Utils.backgroudColor,
                          ))
                    ],
                  ),
                ),
                Container(
                  height: height * 0.74,
                  width: width,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: controller.customerList.listdata.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: Colors.grey,
                        height: 2,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        tileColor: Colors.white,
                        onTap: () {
                          controller.customerController.text = controller
                              .customerList.listdata[index].name
                              .toString();
                          controller.customerCode = controller
                              .customerList.listdata[index].customerCode
                              .toString();
                          Navigator.of(context).pop();
                        },
                        leading: Text(controller
                            .customerList.listdata[index].customerCode
                            .toString()),
                        title:
                            Text(controller.customerList.listdata[index].name),
                        subtitle: Text(
                            controller.customerList.listdata[index].cityName),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
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
