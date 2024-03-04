
import 'package:ngdemo12/service/sql_service.dart';
import 'hive_service.dart';

class RootService{
  static Future<void> init() async {
    await SqlService.init();
    await HiveService.init();
  }
}