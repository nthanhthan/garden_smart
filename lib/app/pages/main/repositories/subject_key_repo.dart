import 'package:foodapp/app/core.dart';

class SubjectKeyRepo extends ActiveRepo<String, SubjectKeyConfig>{
  @override
  String get boxName => ModelTypeDefine.subjectKeybox;

}