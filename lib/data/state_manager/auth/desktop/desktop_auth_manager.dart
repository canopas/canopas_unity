import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:projectunity/data/configs/api.dart';

import 'desktop_manager.dart';


@Injectable()
class DesktopAuthManager extends DesktopLoginManager {


  Future<oauth2.Credentials> login() async {
    await redirectServer?.close();
    redirectServer = await HttpServer.bind('localhost', 3000);
    final redirectURL = redirectUrl + redirectServer!.port.toString();
    oauth2.Client authenticatedHttpClient =
    await _getOauthClient(Uri.parse(redirectURL));
    return authenticatedHttpClient.credentials;
  }

  Future<oauth2.Client> _getOauthClient(Uri redirectUrl) async {
    var grant = oauth2.AuthorizationCodeGrant(googleClientId,
        Uri.parse(googleAuthApi),
        Uri.parse(googleTokenApi),
        httpClient: _JsonAcceptingHttpClient(),
        secret: authClientSecret);
    var authorizationUrl =
    grant.getAuthorizationUrl(redirectUrl, scopes: [emailScope]);
    await redirect(authorizationUrl);
    var responseQueryParameters = await listen();
    var client =
    await grant.handleAuthorizationResponse(responseQueryParameters);
    return client;
  }

  Future<bool> signOutFromGoogle(String accessToken) async {
       final Uri uri = Uri.parse(revokeTokenUrl).replace(queryParameters: {
         token: accessToken});
       final http.Response response = await http.post(uri);
       if (response.statusCode == 200) {
         return true;
    } else {
      return false;
    }
  }

  }

class _JsonAcceptingHttpClient extends http.BaseClient {
  final _httpClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers[headerTitle] = headerData;
    return _httpClient.send(request);
  }

}

  

  


