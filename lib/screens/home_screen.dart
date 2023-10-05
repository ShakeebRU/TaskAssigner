import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/providers/home_screen_provider.dart';
import 'package:taskapp/screens/add_task_screen.dart';
import '../models/user_model.dart';
import '../utils/preferences.dart';
import '../utils/utils.dart';
import 'customer/task_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _showRemarksDialog(BuildContext context, int taskID) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Consumer<HomeScreenProvider>(
            builder: (context, controller, child) => AlertDialog(
                  title: Text('Cencel Task'),
                  content: TextField(
                    controller: controller.remarksController,
                    decoration: InputDecoration(labelText: 'Remarks'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        String remarks = controller.remarksController.text;
                        await controller.cencelTask(taskID, remarks, context);
                      },
                      child: const Text('Submit'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Cancel the dialog
                        controller.remarksController.clear();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                ));
      },
    );

    // if (remarks != null) {
    //   print('Remarks submitted: $remarks');
    // } else {
    //   print('Dialog cancelled');
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // Provider.of<HomeScreenProvider>(context, listen: false)
    //     .disposeControllers();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color(0xFFF5FFFF),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFF5FFFF),
          leading: Consumer<HomeScreenProvider>(
              builder: (context, controller, child) => !controller.isSearch()
                  ? IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ))
                  : IconButton(
                      onPressed: () {
                        controller.setIsSearch(false);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ))),
          title: Consumer<HomeScreenProvider>(
            builder: (context, controller, child) => !controller.isSearch()
                ? const Center(
                    child: Text(
                      "Active Tasks",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : const Center(
                    child: Text(
                      "Active Tasks",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
          actions: [
            Consumer<HomeScreenProvider>(
                builder: (context, controller, child) => !controller.isSearch()
                    ? IconButton(
                        onPressed: () {
                          controller.setIsSearch(true);
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ))
                    : IconButton(
                        onPressed: () {
                          // controller.setIsSearch(true);
                          controller.showOptionDialog(context);
                        },
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        )))
          ],
          flexibleSpace: Container(
            height: height * 0.15,
            // width: width,
            decoration: const BoxDecoration(
                color: Utils.backgroudColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            // child: Center(),
          ),
          // actions: [Icon(Icons.logout)],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //       return const AddTaskScreen();
        //     }));
        //   },
        //   child: const Icon(Icons.add),
        // ),
        body: Consumer<HomeScreenProvider>(
          builder: (context, controller, child) => FutureBuilder<bool>(
            future: controller.getTasks(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("try again latter "),
                );
              } else if (snapshot.hasData) {
                if (controller.searchList!.listdata.length == 0) {
                  return const Center(
                    child: Text("No Task Found"),
                  );
                }
                return ListView(
                  children: [
                    controller.isSearch()
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            // width: width * 0.7,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
                              padding: const EdgeInsets.only(left: 4),
                              child: TextFormField(
                                  onChanged: (value) async {
                                    // await controller.getCustomer();
                                    controller.seacrhList();
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Search",
                                      border: InputBorder.none),
                                  controller: controller.searchController),
                            ),
                          )
                        : const SizedBox.shrink(),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: controller.searchList!.listdata.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox.shrink();
                      },
                      itemBuilder: (BuildContext context, int index) {
                        // print(
                        //     "Type : ${controller.searchList!.listdata[index].taskDetail}");
                        return Container(
                          width: width,
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 241, 195, 250),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Row(
                            children: [
                              Container(
                                width: width * 0.1,
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Utils.backgroudColor),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Created on : ${controller.searchList!.listdata[index].saveDateTimeString.toString()}",
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Utils.backgroudColor),
                                      ),
                                      Text(
                                        "Status :  ${controller.searchList!.listdata[index].status.toString()}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: controller.searchList!
                                                        .listdata[index].status
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "done"
                                                ? Colors.green
                                                : Colors.red),
                                      ),
                                      // Text(
                                      //   "Completed on : ${controller.searchList!.listdata[index].doneDateTime.toString().replaceFirst("T", " ")}",
                                      //   textAlign: TextAlign.center,
                                      //   maxLines: 2,
                                      //   overflow: TextOverflow.ellipsis,
                                      //   style: const TextStyle(
                                      //       fontSize: 12, color: Colors.green),
                                      // ),
                                      Text(
                                        "To : ${controller.searchList!.listdata[index].employeeName.toString() != "" ? controller.searchList!.listdata[index].employeeName.toString() : controller.searchList!.listdata[index].detailName}",
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                      Text(
                                        "Task : ${controller.searchList!.listdata[index].taskDetail}",
                                        // maxLines: 1,
                                        // overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.22,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            UserModel? user =
                                                await Preferences.init().then(
                                                    (value) => value.getAuth());
                                            if (user!.userType.toLowerCase() ==
                                                "customer") {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return TaskDetailScreen(
                                                  data: controller.searchList!
                                                      .listdata[index],
                                                );
                                              }));
                                            } else {
                                              await _showRemarksDialog(
                                                  context,
                                                  controller.searchList!
                                                      .listdata[index].taskID);
                                              controller.remarksController
                                                  .clear();
                                            }

                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Utils.backgroudColor,
                                          ))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    controller.searchList!.listdata.length != 0
                        ? const SizedBox.shrink()
                        //  const Divider(
                        //     color: Colors.grey,
                        //     height: 2,
                        //   )
                        : const SizedBox.shrink(),
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
