import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx/utills/controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utills/modal.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 46, 75, 150),
        foregroundColor: Colors.white,
        title: const Text("Detail Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // image
                Container(
                  height: 250,
                  width: 400,
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: const Alignment(0.8, 0.9),
                    children: [
                      CircleAvatar(
                        radius: s.height * 0.15,
                        foregroundImage: Global.image != null
                            ? FileImage(Global.image!) as ImageProvider
                            : const NetworkImage(
                                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                              ),
                      ),
                      // image
                      FloatingActionButton.extended(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: s.height * 0.15,
                                padding: const EdgeInsets.all(16),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        ImagePicker picker = ImagePicker();
                                        XFile? xFile = await picker.pickImage(
                                            source: ImageSource.camera);

                                        Global.image = File(xFile!.path);
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      icon: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.camera_alt,
                                            size: 30,
                                            color: Color.fromARGB(
                                                255, 46, 75, 150),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            " Take Picture From Camera",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        ImagePicker picker = ImagePicker();
                                        XFile? xFile = await picker.pickImage(
                                            source: ImageSource.gallery);

                                        Global.image = File(xFile!.path);
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                      icon: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.image,
                                            size: 30,
                                            color: Color.fromARGB(
                                                255, 46, 75, 150),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Choose Picture From Gallery",
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        backgroundColor: const Color.fromARGB(255, 46, 75, 150),
                        label: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                TextFormField(
                  onChanged: (value) => Global.name = value,
                  decoration: InputDecoration(
                    hintText: 'Student Name ',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) =>
                      (value!.isEmpty) ? 'Please enter  Student Name' : null,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(
                  height: 20,
                ),
                // GRID
                TextFormField(
                  onChanged: (val) => Global.grid = val,
                  decoration: InputDecoration(
                    hintMaxLines: 10,
                    hintText: 'Student GRID ',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),
                // Standard
                TextFormField(
                  onChanged: (val) => Global.std = val,
                  decoration: InputDecoration(
                    hintText: 'Student Standard',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Modal m = Modal(
                          name: Global.name,
                          grid: Global.grid,
                          std: Global.std,
                          image: Global.image,
                        );
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          homeController.studentDetails.add(m);
                        }
                        SnackBar snackBar = const SnackBar(
                          content: Text(
                            "Student Added",
                            style: TextStyle(fontSize: 18),
                          ),
                          width: 350,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        setState(() {});
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(255, 46, 75, 150)),
                        padding: WidgetStatePropertyAll(EdgeInsets.only(
                            left: 40, right: 40, top: 10, bottom: 10)),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        formKey.currentState!.reset();
                        Global.name = '';
                        Global.grid = '';
                        Global.std = '';
                        Global.image = null;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Reset",
                              style: TextStyle(fontSize: 18),
                            ),
                            width: 350,
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                          ),
                        );
                        setState(() {});
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(255, 46, 75, 150)),
                        padding: WidgetStatePropertyAll(EdgeInsets.only(
                            left: 40, right: 40, top: 10, bottom: 10)),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      child: const Text(
                        "Reset",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
