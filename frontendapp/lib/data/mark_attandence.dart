import 'package:officeproject/data/repo.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qrscan/qrscan.dart' as scanner;

void login() {
  SharedPreferences.getInstance().then((prefs) {
    String name = prefs.getString("name")!;

    scanQrCode(name, "Log In");
  });
}

void logout() {
  SharedPreferences.getInstance().then((prefs) {
    String name = prefs.getString("name")!;

    scanQrCode(name, "Log Out");
  });
}

void breakTime() {
  SharedPreferences.getInstance().then((prefs) {
    String name = prefs.getString("name")!;

    scanQrCode(name, "Break", breakTime: DateTime.now());
  });
}

void breakTimeOff() {
  SharedPreferences.getInstance().then((prefs) {
    String name = prefs.getString("name")!;

    scanQrCode(name, "Break", breakTimeOff: DateTime.now());
  });
}

Future<void> scanQRCodeApp() async {
  var camerastatus = await Permission.camera.status;

  if (camerastatus.isGranted) {
    String? qrData = await scanner.scan();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    

  } else {
    await Permission.camera.request();
  }
}