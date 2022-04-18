import 'package:get/get.dart';
import 'package:todo_amplify/controllers/task_type_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => TaskTypeController(), permanent: true);
  }
}
