import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class CommonMethodsController extends GetxController {
  RxBool isOnline = false.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }

  checkConnectivity() async {
    isLoading.value = true;
    var connectionResult = await Connectivity().checkConnectivity();
    if (connectionResult.contains(ConnectivityResult.mobile) ||
        connectionResult.contains(ConnectivityResult.wifi)) {
      isLoading.value = false;
      isOnline.value = true;
    } else {
      isLoading.value = false;
      isOnline.value = false;
      Get.snackbar("Error", "Check your connection",
          animationDuration: const Duration(seconds: 2),
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
