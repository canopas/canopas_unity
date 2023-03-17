import 'dart:io';
import 'package:oauth2/oauth2.dart'as oauth2;
import 'package:projectunity/data/configs/api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_to_front/window_to_front.dart';

class DesktopLoginManager{
  HttpServer? redirectServer;
  oauth2.Client? client;

  Future<void> redirect(Uri authorizationUri)async{
    if(await canLaunchUrl(authorizationUri)){
      await launchUrl(authorizationUri);
    }else{
      throw Exception('Can not launch $authorizationUri');
    }
  }

  Future<Map<String,String>> listen()async{
    var request= await redirectServer!.first;
    var params= request.uri.queryParameters;
    await WindowToFront.activate();
    request.response.statusCode=200;
    request.response.headers.set('content-type', 'text/plain');
    request.response.writeln(authenticatedResponse);
    await request.response.close();
    await redirectServer!.close();
    redirectServer= null;
    return params;
  }



}