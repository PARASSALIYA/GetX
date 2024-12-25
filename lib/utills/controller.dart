import 'package:get/get.dart';

import 'modal.dart';

class HomeController extends GetxController {
  int i = 0;
  Rx<RxList> rxList = RxList().obs;
  // List<Modal> list = [];

  var studentDetails = <Modal>[].obs;

  // void listDataAdd(m) {
  //   studentDetails.add(m);
  // }

  // RxList<Modal> list = [];
}
