import 'package:permission_handler/permission_handler.dart';

class Permissions {
  // checkForPermissions(BuildContext context) async {
  //   List<PermissionStatus> statuses = [
  //     await Permission.location.status,
  //     await Permission.storage.status,
  //     await Permission.camera.status,
  //     await Permission.microphone.status,
  //   ];

  //   for (PermissionStatus staus in statuses) {
  //     if (staus.isUndetermined || staus.isRestricted || staus.isDenied) {
  //       showPermissionsDialog(context);
  //       break;
  //     }
  //   }
  // }

  askForAppPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      // Permission.location,
      Permission.storage,
      // Permission.camera,
      Permission.microphone,
    ].request();
    return statuses;
  }

  // Future<void> requestPermission(Permission permission) async {
  //   final status = await permission.request();
  // }
}
