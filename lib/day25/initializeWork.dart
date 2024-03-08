import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm-entry-point')
dispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    print(inputData.toString());
    int? totalExecution;
    final sharedPreference = await SharedPreferences.getInstance();
    const key = "totalExecution";
    try {
      totalExecution = sharedPreference.getInt(key);
      sharedPreference.setInt(
          key, totalExecution == null ? 1 : totalExecution + 1);
      print("total execution: $totalExecution");
    } catch (e) {
      print(e.toString());
    }
    return Future.value(true);
  });
}
