import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class UserProfileScreen extends StatefulWidget {
  final ds;
  UserProfileScreen(this.ds);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 38,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: widget.ds["photo"],
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return CircleAvatar(
                            child: Icon(
                              Icons.person,
                              size: 50,
                            ),
                          );
                        },
                        errorWidget: (context, url, dynamic) {
                          return CircleAvatar(
                            child: Icon(
                              Icons.person,
                              size: 50,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.ds["name"],
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.mobile_friendly,
                        color: Colors.orange,
                        size: 19,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          widget.ds["mobile"],
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  VSpace(20),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.orange,
                        size: 19,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          widget.ds["email"],
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                  VSpace(20),
                  Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.orange,
                        size: 19,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          widget.ds["company_name"] ?? "No Company",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                  VSpace(20),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.orange,
                        size: 19,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          widget.ds["address"] ?? "No Address",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      )
                    ],
                  ),
                  VSpace(20),
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                        color: Colors.orange,
                        size: 19,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          widget.ds["user_type_id"] == 1
                              ? "Individual"
                              : "Dealer",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
