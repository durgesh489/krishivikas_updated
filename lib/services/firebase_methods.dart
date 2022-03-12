import 'package:cloud_firestore/cloud_firestore.dart';
class FirebaseMethods{
  Future createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();
    if (snapshot.exists) {
      return true;
    } else {
      return await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }
  Future<Stream<QuerySnapshot>> getMessages(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }
  Future addMessage(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }
  Future<Stream<QuerySnapshot>> getChatRoom(String myUserName) async {
    // String myUserName = await SharedPreference().getStringValuesSF('PR_Auth');
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .where("usersPhoneNumbers", arrayContains: myUserName)
        .snapshots();
  }
  Future lastMessageUpdate(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }


}
