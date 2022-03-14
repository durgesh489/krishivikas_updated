import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/auth_methods.dart';
import 'package:krishivikas/services/firebase_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:intl/intl.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class IndividualChatScreen extends StatefulWidget {
  final otherUserPhoneNumber,otherUserDeviceTokenId;
  IndividualChatScreen(this.otherUserPhoneNumber,this.otherUserDeviceTokenId);

  @override
  _IndividualChatScreenState createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  // String myPhoneNumber = "";
  // String myId = "";
  String messageId = "";
  String chatRoomId = "";
  var messageStream;
  // String userTokenId = "";
  bool isUserExist = false;

  TextEditingController messageController = TextEditingController();

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  getChatRoomIdByPhoneNumbers(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  getMyInfo() async {
    await SharedPreferencesFunctions().getUserPhoneNumber();
    await SharedPreferencesFunctions().getDeviceToken();
    // myId = (await SharedPreferencesHelper().getUserId())!;
    chatRoomId = getChatRoomIdByPhoneNumbers(
        SharedPreferencesFunctions.phoneNumber.toString(),
        widget.otherUserPhoneNumber);
  }

  getAndSetMessages() async {
    messageStream = await FirebaseMethods().getMessages(chatRoomId);
  }

  // getUserTokenId() async {
  //   QuerySnapshot tokenIdQS =
  //       await DatabaseMethods().getUserInfo(widget.userPhoneNumber);
  //   if (tokenIdQS.docs.length == 1) {
  //     isUserExist = true;
  //     userTokenId = tokenIdQS.docs[0]["tokenId"];
  //     print(userTokenId);
  //   }
  // }

  doThisOnLaunch() async {
    await getMyInfo();
    getAndSetMessages();
    // getUserTokenId();
    // print(userTokenId);

    setState(() {});
  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  onSendClick(bool send) {
    if (messageController.text != "") {
      AuthMethods().sendNotification([widget.otherUserDeviceTokenId], messageController.text,
          SharedPreferencesFunctions.phoneNumber.toString());
      String date = DateFormat("dd/MM/yyyy ").format(DateTime.now());
      String time = DateFormat('hh:mm a').format(DateTime.now());
      Map<String, dynamic> messageInfoMap = {
        "message": messageController.text,
        "sendBy": SharedPreferencesFunctions.phoneNumber.toString(),
        "date": date,
        "time": time,
        "ts": DateTime.now(),
      };
      Map<String, dynamic> lastMessageInfoMap = {
        "lastMessage": messageController.text,
        "lastMessageSendBy": SharedPreferencesFunctions.phoneNumber.toString(),
        "lastMessageTs": DateTime.now(),
        "lastMessageTime": time,
        "lastMessageDate": date
      };
      if (messageId == "") {
        messageId = getRandomString(12);
      }
      print(chatRoomId);

      FirebaseMethods()
          .addMessage(chatRoomId, messageId, messageInfoMap)
          .then((value) {
        FirebaseMethods().lastMessageUpdate(chatRoomId, lastMessageInfoMap);
      });
      if (send) {
        messageController.text = "";
        messageId = "";
        setState(() {});
      }
    }
  }

  Widget ChatListTile(ds) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: ds["sendBy"] == SharedPreferencesFunctions.phoneNumber
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: ds["sendBy"] == SharedPreferencesFunctions.phoneNumber
            ? const EdgeInsets.only(top: 3, bottom: 3, left: 50, right: 8)
            : const EdgeInsets.only(top: 3, bottom: 3, left: 8, right: 50),
        decoration: BoxDecoration(
          color: ds["sendBy"] == SharedPreferencesFunctions.phoneNumber
              ? Colors.cyan[300]
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 65.0, bottom: 12, left: 12, top: 12),
              child: Text(
                ds["message"],
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              bottom: 7,
              right: 10,
              child: Text(
                ds["time"],
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget AllChats() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? snapshot.data!.docs.length == 0
                ? Center(
                    child: appText(
                        "No Chats to show", 15, Colors.grey, FontWeight.bold))
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 65),
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      return ChatListTile(ds);
                    },
                  )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          // leading: IconButton(onPressed: (){}, icon: Icon(Icons.clear_outlined)),
          title: Text(widget.otherUserPhoneNumber),
          actions: [
            // PopupMenuButton(
            //   icon: Icon(
            //     Icons.more_vert,
            //     color: Colors.black,
            //   ),
            //   itemBuilder: (context) {
            //     return [
            //       PopupMenuItem(
            //         child: Text("Settings"),
            //       ),
            //     ];
            //   },
            // ),
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              AllChats(),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(2),
                  child: Row(
                    children: [
                      // IconButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       chatBool = false;
                      //     });
                      //   },
                      //   icon: Icon(
                      //     Icons.cancel,
                      //     size: 28,
                      //   ),
                      // ),
                      Expanded(
                        child: Card(
                          color: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: BorderSide(width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextField(
                              onChanged: (value) {},
                              minLines: 1,
                              maxLines: 3,
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Message",
                              ),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: kPrimaryColor,
                        child: IconButton(
                          onPressed: () {
                            onSendClick(true);
                          },
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
