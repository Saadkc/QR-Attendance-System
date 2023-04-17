import 'package:officeproject/data/repo.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qrscan/qrscan.dart' as scanner;

void login(String name) async {
  scanQrCode(name, "Log In");
}

void logout(String name) {
  scanQrCode(name, "Log Out");
}

void breakTime(String name) {
  scanQrCode(name, "Break");
}

void breakTimeOff() {
  SharedPreferences.getInstance().then((prefs) {
    String name = prefs.getString("name")!;
    scanQrCode(name, "Break-off");
  });
}

Future<void> scanQRCodeApp() async {
  var camerastatus = await Permission.camera.status;

  if (camerastatus.isGranted) {
    String? qrData = await scanner.scan();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime dateTime = DateTime.now();

    if (prefs.containsKey("status")) {
      String status = prefs.getString("status")!;
      if (status == "Log In") {
        breakTime(prefs.getString('name')!);
        prefs.setString("status", "break");
      } else if (status == "break") {
        breakTimeOff();
        prefs.setString("status", "break-off");
      } else {
        prefs.remove('status');
        logout(prefs.getString("name")!);
      }
    } else {
      login(prefs.getString("name")!);
      prefs.setString("status", "Log In");
      prefs.setString("time", dateTime.toString());
    }
  } else {
    await Permission.camera.request();
  }
}
