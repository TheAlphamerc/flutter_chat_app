
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/page/chat_screen.dart';
import 'package:flutter_chat_app/page/login.dart';
import 'package:flutter_chat_app/page/profile_page.dart';
import 'package:flutter_chat_app/page/splash.dart';
import 'package:flutter_chat_app/page/welcomPage.dart';
import 'package:flutter_chat_app/widgets/customRoute.dart';
import '../widgets/customWidgets.dart';

class Routes{
  static dynamic route(){
      return {
          '/': (BuildContext context) =>   SplashPage(),
      };
  }


  static Route onGenerateRoute(RouteSettings settings) {
     final List<String> pathElements = settings.name.split('/');
     if (pathElements[0] != '' || pathElements.length == 1) {
       return null;
     }
     switch (pathElements[1]) {
      case "ChatScreenPage": 
       
        return CustomRoute<bool>(builder:(BuildContext context)=> ChatScreenPage());
      
      case "WelcomePage":return CustomRoute<bool>(builder:(BuildContext context)=> WelcomePage()); 
      case "LoginPage":return CustomRoute<bool>(builder:(BuildContext context)=> LoginPage()); 
      case "ProfilePage":return CustomRoute<bool>(builder:(BuildContext context)=> ProfilePage()); 
     
      default:return onUnknownRoute(RouteSettings(name: '/Feature'));
     }
  }

   static Route onUnknownRoute(RouteSettings settings){
     return MaterialPageRoute(
          builder: (_) => Scaffold(
                appBar: AppBar(title: customTitleText(settings.name.split('/')[1]),centerTitle: true,),
                body: Center(
                  child: Text('${settings.name.split('/')[1]} Comming soon..'),
                ),
              ),
        );
   }
}