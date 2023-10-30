import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/providers/history_provider.dart';

import '../components/images_widget.dart';
import '../utils/utils.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color(0xFFF5FFFF),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFF5FFFF),
          leading: Consumer<HistoryProvider>(
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
          title: Consumer<HistoryProvider>(
              builder: (context, controller, child) => !controller.isSearch()
                  ? const Center(
                      child: Text(
                        "History",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : const Center(
                      child: Text(
                        "History",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
          actions: [
            Consumer<HistoryProvider>(
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
        body: Consumer<HistoryProvider>(
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
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
                        : SizedBox.shrink(),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: controller.searchList!.listdata.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox.shrink();
                      },
                      itemBuilder: (BuildContext context, int index) {
                        // print(controller.searchList!.listdata[index].taskID);
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
                                        "To : ${controller.searchList!.listdata[index].employeeName.toString()}",
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        "Task : ${controller.searchList!.listdata[index].taskDetail}",
                                        // maxLines: 1,
                                        // overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      controller.searchList!.listdata[index]
                                                  .messageType
                                                  .toLowerCase() ==
                                              "image"
                                          ? ImagesWidget(
                                              taskId: controller.searchList!
                                                  .listdata[index].taskID,
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.25,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller
                                            .searchList!.listdata[index].status
                                            .toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: controller.searchList!
                                                        .listdata[index].status
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "post"
                                                ? Colors.green
                                                : Colors.red),
                                      ),
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
