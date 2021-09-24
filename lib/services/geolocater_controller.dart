import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GeolocaterController extends GetxController {
  bool isLoadingFinish = false;
  bool isRequiredPermission = false;
  late Position currentLocation;

  Future<Position?> getLocation() async {
    print("get location start");
    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      return null;
    }
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .catchError((e) {
      print("Error $e");
    });
  }

  void permissionOK() {
    getLocation().then((post) {
      isLoadingFinish = true;
      currentLocation = post!;
      // ignore: unnecessary_null_comparison
      if (post == null) {
        isRequiredPermission = true;
      } else {
        isRequiredPermission = false;
      }
    });
  }
}
