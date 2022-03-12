import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class ImageToFullScreen extends StatefulWidget {
  final String url;
  ImageToFullScreen(this.url);

  @override
  _ImageToFullScreenState createState() => _ImageToFullScreenState();
}

class _ImageToFullScreenState extends State<ImageToFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: fullWidth(context),
          height: fullHeight(context),
          child: CachedNetworkImage(imageUrl: widget.url)
        ),
      ),
      
    );
  }
}