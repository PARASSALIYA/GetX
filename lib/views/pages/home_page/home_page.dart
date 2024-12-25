import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/utills/controller.dart';

import '../../../utills/modal.dart';
import '../../../utills/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 46, 75, 150),
        foregroundColor: Colors.white,
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => ListView.builder(
            itemCount: homeController.studentDetails.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                leading: Text(homeController.studentDetails[index].grid),
                title: Text(homeController.studentDetails[index].name),
                subtitle: Text(homeController.studentDetails[index].std),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      homeController.studentDetails
                          .remove(homeController.studentDetails[index]);
                    });
                  },
                  icon: const Icon(Icons.delete),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.detail);
        },
        backgroundColor: const Color.fromARGB(255, 46, 75, 150),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
