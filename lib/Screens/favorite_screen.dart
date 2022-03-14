import 'package:flutter/material.dart';

import 'package:krishivikas/widgets/all_widgets.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: appText("Coming Soon ...", 16, Colors.grey, FontWeight.bold),
      ),
    );
  }
}
