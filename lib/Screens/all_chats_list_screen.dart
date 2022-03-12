import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:krishivikas/Screens/individual_chat_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/firebase_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
// import 'package:permission_handler/permission_handler.dart';

class AllChatsListScreen extends StatefulWidget {
  const AllChatsListScreen({Key? key}) : super(key: key);

  @override
  _AllChatsListScreenState createState() => _AllChatsListScreenState();
}

class _AllChatsListScreenState extends State<AllChatsListScreen> {
  // String myName = "";
  // String myImageUrl = "";
  // String myPhoneNumber = "";
  // String myId = "";
  // String myAbout = "";
  var chatRoomStream;

  getMyInfo() async {
    await SharedPreferencesFunctions().getUserPhoneNumber();
    await SharedPreferencesFunctions().getDeviceToken();
    print(SharedPreferencesFunctions.phoneNumber);
    // myName = (await SharedPreferencesHelper().getUserName())!;
    // myImageUrl = (await SharedPreferencesHelper().getUserProfile())!;
    // myPhoneNumber = (await SharedPreferencesHelper().getPhoneNumber())!;
    // myId = (await SharedPreferencesHelper().getUserId())!;
    // myAbout = (await SharedPreferencesHelper().getUserAbout())!;
    chatRoomStream = await FirebaseMethods()
        .getChatRoom(SharedPreferencesFunctions.phoneNumber.toString());
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyInfo();
  }

  Widget ChatRoomListTile(DocumentSnapshot ds) {
    String userPhoneNumber =
        SharedPreferencesFunctions.phoneNumber == ds["usersPhoneNumbers"][0]
            ? ds["usersPhoneNumbers"][1]
            : ds["usersPhoneNumbers"][0];
    // String userName = myName == ds["usersNames"][0]
    //     ? ds["usersNames"][1]
    //     : ds["usersNames"][0];
    // String userImageUrl = myImageUrl == ds["usersImageUrls"][0]
    //     ? ds["usersImageUrls"][1]
    //     : ds["usersImageUrls"][0];
    String userDeviceTokenIdId =
        SharedPreferencesFunctions.deviceToken == ds["usersDeviceTokenIds"][0]
            ? ds["usersDeviceTokenIds"][1]
            : ds["usersDeviceTokenIds"][0];
    String lastMessage = ds["lastMessage"];
    String lastMessageTS = ds["lastMessageTime"];

    return Container(
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IndividualChatScreen(
                      userPhoneNumber, userDeviceTokenIdId)));
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 7),
        // leading: ClipRRect(
        //   borderRadius: BorderRadius.circular(50),
        //   child: Image.network(userImageUrl,fit: BoxFit.cover,width: 50,height: 50,),
        // ),
        leading: Container(
            width: 50,
            height: 50,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
            child: Icon(
              Icons.person,
              color: Colors.white,
            )
            //  CachedNetworkImage(
            //   imageUrl: userImageUrl,
            //   fit: BoxFit.cover,
            //   placeholder: (context, url) => CircleAvatar(
            //     backgroundColor: Colors.teal[700],
            //     child: Icon(
            //       Icons.person,
            //       color: Colors.white,
            //       size: 40,
            //     ),
            //   ),
            //   errorWidget: (context, url, error) => CircleAvatar(
            //     backgroundColor: Colors.teal[700],
            //     child: Icon(
            //       Icons.error,
            //       color: Colors.white,
            //       size: 40,
            //     ),
            //   ),
            // ),
            ),
        // leading: userImageUrl != ""
        //     ? Container(
        //       width: 50,
        //         child: ClipRRect(
        //           borderRadius: BorderRadius.circular(50),
        //           child: Image.network(
        //             userImageUrl,
        //             fit: BoxFit.cover,
        //             width: 50,
        //             height: 50,
        //           ),
        //         ),
        //       )
        //     : Container(
        //        width: 50,
        //         child: CircleAvatar(
        //           backgroundColor: Colors.teal[700],
        //           radius: 28,
        //           child: IconButton(
        //             icon: Icon(Icons.person,size: 30,),
        //             onPressed: (){

        //             },

        //           ),
        //         ),
        //       ),

        title: Padding(
          padding: const EdgeInsets.only(bottom: 3.0),
          child: Text(userPhoneNumber,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              )),
        ),
        subtitle: Text(
          lastMessage.length > 20
              ? "${lastMessage.substring(0, 20)}..."
              : lastMessage,
          style: TextStyle(fontSize: 17),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              lastMessageTS,
            ),
            SizedBox(
              height: 20,
            ),
            // CircleAvatar(
            //   radius: 10,
            //   backgroundColor: Colors.green,
            //   child: Text(
            //     "1",
            //     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: chatRoomStream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return snapshot.hasData
                  ? snapshot.data!.docs.length == 0
                      ? Center(
                          child: Text("No Chats"),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot ds = snapshot.data!.docs[index];
                            return ChatRoomListTile(ds);
                          },
                        )
                  : Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
