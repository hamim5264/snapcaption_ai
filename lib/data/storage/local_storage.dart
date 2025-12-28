import 'package:get_storage/get_storage.dart';
import '../../app/constants/app_constants.dart';

class LocalStorage {
  static final _box = GetStorage();

  static String? get userApiKey => _box.read(AppConstants.kUserApiKey);

  static Future<void> setUserApiKey(String? key) async =>
      _box.write(AppConstants.kUserApiKey, key);

  static int get dailyCount => _box.read(AppConstants.kDailyCount) ?? 0;

  static String? get dailyDate => _box.read(AppConstants.kDailyDate);

  static Future<void> resetDay(String today) async {
    await _box.write(AppConstants.kDailyDate, today);
    await _box.write(AppConstants.kDailyCount, 0);
  }

  static Future<void> incrementDailyCount() async {
    final current = dailyCount;
    await _box.write(AppConstants.kDailyCount, current + 1);
  }
}
