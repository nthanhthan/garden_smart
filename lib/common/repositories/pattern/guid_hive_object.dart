
import 'package:foodapp/app/core.dart';

/// a HiveObject whose key is a string
abstract class GuidHiveObject extends HiveObject {
  @override
  String get key => super.key.toString();
}
