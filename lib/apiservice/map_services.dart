import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> getCurrentLocationData() async {
  final PermissionStatus permissionStatus = await Permission.location.request();
  // final status = await Permission.location.isGranted;
  // Permission.location.isGranted;
  if (permissionStatus == PermissionStatus.granted) {
    return true;
  } else {
    return F;
  }
  // return status;
}
