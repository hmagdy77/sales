import 'package:get/get.dart';
import '../../core/service/services.dart';

abstract class MainController extends GetxController {}

class MainControllerImp extends MainController {
  MyService myService = Get.find();
  // var selectedBody = ''.obs;
}
