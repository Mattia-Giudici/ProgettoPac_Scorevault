import 'package:permission_handler/permission_handler.dart';

class PermissionsHandler {

Future<bool> requestGalleryPermission() async {
  var status = await Permission.photos.request();
  if (status.isGranted) {
    return true;
  } else if (status.isDenied) {
    // L'utente ha negato il permesso
    return false;
  } else if (status.isPermanentlyDenied) {
    // Apri le impostazioni dell'app
    await openAppSettings();
    return false;
  }
  return false;
}

}