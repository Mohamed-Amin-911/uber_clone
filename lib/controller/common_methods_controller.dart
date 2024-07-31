import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:uber_clone/view/widgets/getx_snackbar.dart';

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
      getxSnackbar(title: "Error", msg: "Check your connection");
    }
  }
}
