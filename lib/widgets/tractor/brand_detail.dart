import 'package:flutter/material.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class BrandDetail extends StatefulWidget {
  final ds;
  BrandDetail(this.ds);

  @override
  _BrandDetailState createState() => _BrandDetailState();
}

class _BrandDetailState extends State<BrandDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: SizedBox(
              height: 270,
              child: Image.network(
                widget.ds["logo"],
                width: fullWidth(context),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 18, bottom: 5),
                      child: Text(
                        widget.ds["name"],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 13, bottom: 12),
                    //   child: Row(
                    //     children: [
                    //       const Icon(
                    //         Icons.location_on_outlined,
                    //         size: 18,
                    //       ),
                    //       const SizedBox(
                    //         width: 4,
                    //       ),
                    //       Text(
                    //         widget.ds["state_name"],
                    //       ),
                    //       const SizedBox(
                    //         width: 50,
                    //       ),
                    //       const Icon(
                    //         Icons.access_time_outlined,
                    //         size: 18,
                    //       ),
                    //       const SizedBox(
                    //         width: 6,
                    //       ),
                    //       Text(widget.ds["created_at"])
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
