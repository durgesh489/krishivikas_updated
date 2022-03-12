import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:krishivikas/Screens/image_to_full_screen.dart';
import 'package:krishivikas/const/colors.dart';

// BoxDecoration boxDecoration = BoxDecoration(
//     border: Border.all(width: 1), borderRadius: BorderRadius.circular(5));
// StreamBuilder(
//               stream: lostThingsStream,
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 return snapshot.hasData
//                     ? snapshot.data!.docs.length == 0
//                         ? Center(child: Text(widget.collectionName=="Lost"?"No Lost Things":"No found Things"))
//                         : ListView.builder(
//                           shrinkWrap: true,
//                             itemCount: snapshot.data!.docs.length,
//                             itemBuilder: (context, index) {
//                               DocumentSnapshot ds = snapshot.data!.docs[index];
//                               return LostThingTile(ds);
//                             })
//                     : Center(child: CircularProgressIndicator());
//               },
//             ),
BoxDecoration boxDecoration(double borderWidth, double borderRadius) {
  return BoxDecoration(
    border: Border.all(width: borderWidth),
    borderRadius: BorderRadius.circular(borderRadius),
  );
}

BoxDecoration gboxDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
        colors: [Colors.grey, Colors.green],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
  );
}

OutlineInputBorder outlineBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey.shade400, width: 2));
}

TextStyle textStyle(double size) {
  return TextStyle(color: Colors.black, fontSize: size);
}

TextStyle boldTextStyle(double size) {
  return TextStyle(
      color: Colors.black, fontSize: size, fontWeight: FontWeight.bold);
}

goto(BuildContext context, Widget nextScreen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen));
}

gotoWithoutBack(BuildContext context, Widget nextScreen) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => nextScreen));
}

goBack(BuildContext context) {
  Navigator.of(context).pop();
}

Widget normalText(String text, double size) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
    ),
  );
}

Widget boldText(String text, double size) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
  );
}

Widget veryBoldText(String text, double size) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontWeight: FontWeight.w900),
    textAlign: TextAlign.center,
  );
}

Widget appText(String text, double size, Color? color, FontWeight fontWeight) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight),
  );
}

Widget CustomMaterialButton(BuildContext context, Function fun, String buttonText) {
  return MaterialButton(
    minWidth: MediaQuery.of(context).size.width,
    height: 45,
    color: kPrimaryColor,
    onPressed: () {
      fun();
    },
    child: Text(
      buttonText,
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
  );
}

Widget SecondaryButton(
    BuildContext context, Function fun, String buttonText, Color? color) {
  return MaterialButton(
    color: color,
    onPressed: () {
      fun();
    },
    child: Text(
      buttonText,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}

showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: kPrimaryColor,
    content: appText(content, 16, Colors.white, FontWeight.bold,),
  ));
}

Widget DrawerItems(Icon icon, String title, Function fun) {
  return ListTile(
    onTap: () {
      fun();
    },
    leading: icon,
    title: appText(title, 17, Colors.brown, FontWeight.bold),
    trailing: Icon(
      Icons.arrow_forward_ios,
      size: 15,
      color: Colors.brown,
    ),
  );
}

Widget VSpace(double h) {
  return SizedBox(
    height: h,
  );
}

Widget HSpace(double w) {
  return SizedBox(
    width: w,
  );
}

double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Widget CustomTextfield(TextEditingController controller, String hintText,
    String labelText, String errorText, TextInputType keyboardType) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
    child: TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: RequiredValidator(errorText: errorText),
      decoration: InputDecoration(
        label: Text(labelText),
        contentPadding: EdgeInsets.only(left: 15),
        hintText: hintText,
        enabledBorder: outlineBorder(),
        focusedBorder: outlineBorder(),
        errorBorder: outlineBorder(),
        focusedErrorBorder: outlineBorder(),
      ),
    ),
  );
}

Widget CachedNetworkImg(String url, double w, double h, String assetImage,BuildContext context) {
  return InkWell(
    onTap: () {
      goto(context, ImageToFullScreen(url));
    },
    child: CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      width: w,
      height: h,
      placeholder: (context, url) {
        return Center(
          child: Text("Loading"),
        );
      },
      errorWidget: (context, url, dynamic) {
        return Center(
            child: Image.asset(
          assetImage,
          width: w,
          fit: BoxFit.cover,
        ));
      },
    ),
  );
}
