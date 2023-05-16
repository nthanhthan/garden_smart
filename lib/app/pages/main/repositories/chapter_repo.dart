import 'package:foodapp/app/core.dart';

class ChapterRepo extends ActiveRepo<String, SubjectModel>{
  @override
  String get boxName => ModelTypeDefine.subjectbox;

}