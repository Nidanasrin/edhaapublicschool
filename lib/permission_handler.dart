import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermissions() async {
  final micStatus = await Permission.microphone.request();
  final storageStatus = await Permission.storage.request(); // For Android <=12
  final audioStatus = await Permission.audio.request(); // For Android 13+

  if (micStatus.isGranted &&
      (storageStatus.isGranted || audioStatus.isGranted)) {
    return true;
  } else {
    return false;
  }
}
