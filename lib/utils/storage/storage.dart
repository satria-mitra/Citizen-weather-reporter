import 'package:get_storage/get_storage.dart';

class LocalStorage {
  late final GetStorage _storage;

  static LocalStorage? _instance;

  LocalStorage._internal();

  factory LocalStorage.instance() {
    _instance ??= LocalStorage._internal();
    return _instance!;
  }

  // async init method
  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = LocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  //save data

  Future<void> writeData(String key, int value) async {
    await _storage.write(key, value);
  }
}
