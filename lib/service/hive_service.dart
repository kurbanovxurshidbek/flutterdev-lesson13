import 'package:hive/hive.dart';
import '../model/member_model.dart';
import 'package:path_provider/path_provider.dart';


class HiveService {
  static var box = Hive.box("my_nosql");

  static Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDocumentDirectory.path)
      ..registerAdapter(MemberAdapter());
    await Hive.openBox("my_nosql");
  }

  /// Save object using key and value
  static storeMember(Member member) async {
    box.put("member", member);
  }

  static Member loadMember() {
    var member = box.get('member');
    return member;
  }

  static removeMember() async {
    box.delete("member");
  }

  /// Save object without key
  static saveMember(Member member) async {
    box.add(member);
  }

  static updateMember(int index,Member member) async {
    box.putAt(index, member);
  }

  static List getAllMembers() {
    //List members = box.values.toList();
    List<Member> members = [];
    for (int i = 0; i < box.length; i++) {
      var member = box.getAt(i);
      members.add(member);
    }
    return members;
  }

  static deleteMemberByIndex(int index) async {
    box.deleteAt(index);
  }
}