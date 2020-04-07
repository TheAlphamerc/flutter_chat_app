
  import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_app/model/user.dart';
import 'package:flutter_chat_app/theme/theme.dart';
import 'package:image_picker/image_picker.dart';
Widget customTitleText(String title, {BuildContext context}){
  return Text(title ?? '',style: TextStyle(color: Colors.black87,fontFamily: 'HelveticaNeue', fontWeight:FontWeight.w900, fontSize: 20),);
}
Widget customText(String msg, {Key key, TextStyle style,TextAlign textAlign = TextAlign.justify,TextOverflow overflow = TextOverflow.visible,BuildContext context,bool softwrap = true}){

  if(msg == null){
    return SizedBox(height: 0,width: 0,);
  }
  else{
    if(context != null && style != null){
      var fontSize = style.fontSize ?? Theme.of(context).textTheme.body1.fontSize;
      style =  style.copyWith(fontSize: fontSize - ( fullWidth(context) <= 375  ? 2 : 0));
    }
    return Text(msg,style: style,textAlign: textAlign,overflow:overflow,softWrap: softwrap,key: key,);
  }
}
Widget userAvatar(User user, {double radius = 30}) {
    user = User(
      profilePic:
          'http://www.azembelani.co.za/wp-content/uploads/2016/07/20161014_58006bf6e7079-3.png',
    );
    return CircleAvatar(radius: radius, child: Image.network(user.profilePic));
  }
double fullWidth(BuildContext context) {
  // cprint(MediaQuery.of(context).size.width.toString());
  return MediaQuery.of(context).size.width;
} 
double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
} 
Widget customInkWell({Widget child,BuildContext context,Function(bool,int) function1,Function onPressed,bool isEnable = false, int no = 0,Color color = Colors.transparent,Color splashColor,BorderRadius radius}){
  if(splashColor == null){
    splashColor = Theme.of(context).primaryColorLight;
  }
  if(radius == null){
    radius = BorderRadius.circular(0);
  }
  return Material(
    
    color:color,
    child: InkWell(
      borderRadius: radius,
      onTap: (){
        if(function1 != null){
          function1(isEnable,no);
        }
        else if(onPressed != null){
          onPressed();
        }
      },
      splashColor: splashColor,
      child: child,
    ),
  );
}
SizedBox sizedBox({double height = 5, String title}){
    return SizedBox(
      height: title == null || title.isEmpty ? 0 : height,
    );
  }


void showAlert(BuildContext context,{@required Function onPressedOk,@required String title,String okText = 'OK', String cancelText = 'Cancel'}) async{
   showDialog(
     context: context,
     builder: (context){ return  customAlert(context,onPressedOk: onPressedOk,title: title,okText: okText,cancelText: cancelText);  }
   );
  }
Widget customAlert(BuildContext context,{@required Function onPressedOk,@required String title,String okText = 'OK', String cancelText = 'Cancel'}) {
    return AlertDialog(
          title: Text('Alert',style: TextStyle(fontSize: getDimention(context,25),color: Colors.black54)),
          content: customText(title,style: TextStyle(color: Colors.black45)),
          actions: <Widget>[
          FlatButton(
            textColor: Colors.grey,
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text(cancelText),
           ),
           FlatButton(
             textColor: Theme.of(context).primaryColor,
            onPressed: (){
              Navigator.pop(context);
              onPressedOk();
            },
            child: Text(okText),
         )
       ],
    );
  }
void customSnackBar(GlobalKey<ScaffoldState> _scaffoldKey,String msg,{double height = 30, Color backgroundColor = Colors.black}){
    if( _scaffoldKey == null || _scaffoldKey.currentState == null){
      return;
    }
    _scaffoldKey.currentState.hideCurrentSnackBar();
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      content:Text(msg, style: TextStyle(color:Colors.white,),));
           _scaffoldKey.currentState.showSnackBar(snackBar);
  }
Widget emptyListWidget(BuildContext context, String title,{String subTitle,String image = 'emptyImage.png'}){
  return Container(
     color: Color(0xfffafafa),
    child:Center(
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: fullWidth(context) * .95,
          height: fullWidth(context) * .95,
          decoration: BoxDecoration(
            // color: Color(0xfff1f3f6),
            boxShadow: <BoxShadow>[
              // BoxShadow(blurRadius: 50,offset: Offset(0, 0),color: Color(0xffe2e5ed),spreadRadius:20),
              BoxShadow(offset: Offset(0, 0),color: Color(0xffe2e5ed),),
              BoxShadow(blurRadius: 50,offset: Offset(10,0),color: Color(0xffffffff),spreadRadius:-5),
            ],
            shape: BoxShape.circle
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/$image',height: 170),
            SizedBox(height: 20,),
            customText(title,style: Theme.of(context).typography.dense.display1.copyWith(color: Color(0xff9da9c7))),
            customText(subTitle,style: Theme.of(context).typography.dense.body2.copyWith(color: Color(0xffabb8d6))),
        ],) 
    ],)
  )
  );
}


 Widget loader(){
   if(Platform.isIOS){
     return Center(child: CupertinoActivityIndicator(),);
   }
   else{
     return Center(
       child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),),
     );
   }
 }
  Widget customSwitcherWidget({@required child, Duration duraton = const Duration(milliseconds: 500)}){
   return AnimatedSwitcher(
      duration: duraton,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(child: child, scale: animation);
      },
      child: child,
   );
  }
  
  Widget customExtendedText(String text, bool isExpanded,{BuildContext context, TextStyle style,@required Function onPressed, @required TickerProvider provider,AlignmentGeometry alignment = Alignment.topRight,@required EdgeInsetsGeometry padding , int wordLimit = 100,bool isAnimated = true }){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         AnimatedSize(
          vsync: provider,
          duration:  Duration(milliseconds: (isAnimated ? 500 : 0)),
          child: ConstrainedBox(
            constraints: isExpanded  ?  BoxConstraints() :  BoxConstraints(maxHeight: wordLimit == 100 ? 100.0 : 260.0),
              child:  customText(
                text,
                softwrap: true,
                overflow: TextOverflow.fade,
                style: style ,
                context: context,
                textAlign: TextAlign.start))),
              text != null && text.length > wordLimit ? 
              Container(
                alignment: alignment,
                child: InkWell(
                 onTap: onPressed,
                  child: Padding(
                    padding: padding,
                    child: Text(!isExpanded ? 'more...' : 'Less...',style: TextStyle(color: Colors.blue,fontSize: 14),),
                  )
                )
                ,
              )
               : Container()
    ]);
  }
  double getDimention(context, double unit){
  if(fullWidth(context) <= 360.0){
    return unit / 1.3;
  }
  else {
    return unit;
  }
}
Widget customListTile(BuildContext context,{Widget title,Widget subtitle, Widget leading,Widget trailing,Function onTap}){
   return customInkWell(
     context: context,
     onPressed: (){if(onTap != null){onTap();}},
     child: Padding(
       padding: EdgeInsets.symmetric(vertical: 0),
       child:Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           SizedBox(width: 10,),
           Container(
                 width: 40,
                 height: 40,
                 child: leading,
               ),
           SizedBox(width: 20,),
           Container(
             width: fullWidth(context) - 80 ,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Row(
                   children: <Widget>[
                     Expanded(child:title ?? Container()),
                    trailing ?? Container(),
                   ],
                 ),
                 subtitle
               ],
             ),
           ),
            SizedBox(width: 10,),
         ],
       )
     )
   );
}

openImagePicker(BuildContext context,Function onImageSelected) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 100,
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(children: <Widget>[
                   Expanded(
                     child:  FlatButton(
                    color: Theme.of(context).primaryColor,
                    child: Text('Use Camera',style: TextStyle(color: Theme.of(context).backgroundColor),),
                      onPressed: () {
                        getImage(context, ImageSource.camera,onImageSelected);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    child: Text('Use Gallery',style: TextStyle(color: Theme.of(context).backgroundColor),),
                    onPressed: () {
                       getImage(context, ImageSource.gallery,onImageSelected);
                    },
                  ),
                )
                ],)
              ],
            ),
          );
        });
  }
  getImage(BuildContext context, ImageSource source,Function onImageSelected) {
    ImagePicker.pickImage(source: source,imageQuality: 50).then((File file) {
      onImageSelected(file);
      Navigator.pop(context);
    });
  }