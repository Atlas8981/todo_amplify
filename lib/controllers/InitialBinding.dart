import 'package:get/get.dart';
import 'package:todo_amplify/controllers/TaskTypeController.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => TaskTypeController(), permanent: true);
  }
}
