## Set-up Guides

#### 1. [Flutter Environment Setup](https://docs.flutter.dev/get-started/install)
> **Note**: Flutter sdk version `'>=3.2.0 <4.0.0'` is recommended to run project.

#### 2. Clone the repo
```sh
$ git clone https://github.com/canopas/canopas-unity.git
```
#### 3. Rename the app Package Name
* Rename the app package name (because this can affect the Firebase).
* You can do it manually or using this package [Rename Package](https://pub.dev/packages/rename) or look at this [Stackoverflow Question](https://stackoverflow.com/questions/51534616/how-to-change-package-name-in-flutter).

#### 4. Setup the Firebase app
* You'll need to create a Firebase instance. Follow the instructions at https://console.firebase.google.com.

#### 5. Enable Google Authentication
* Go to the Firebase console for your new instance.
* Click "Authentication" in the left-hand menu.
* Click the "sign-in method" tab.
* Click the "Google" and enable it.

#### 6. Enable the Firebase Database
* Go to the Firebase Console.
* Click "Firestore Database" in the left-hand menu.
* Click the "Create Database" button.
* It will prompt you to set up, rules, for the sake of simplicity, let us choose test mode, for now.
* On the next screen, select any of the locations you prefer.

#### 7. Add Flutter App in Firebase
* In the Firebase console, in the settings of your project.
* Click on the Flutter Icon to add the Flutter app.
* Follow the instructions to add the Flutter app.

  <img src="./screenshots/flutter_firebase_register.png" width="1050" ></img>

* It will create a `firebase_options.dart` file in the `lib` folder.

#### 8. Get Google ClientId for app
* Go to [Google APIs console](https://console.cloud.google.com/apis/).
* On the top bar, Choose your project from the drop-down menu if the selected default project is not your current project.
* Click on the "API APIs and services".

  <img src="./screenshots/google-cloud-console.png" width="1080"></img>

* On the left side menu, Select "Credentials".
* Click on the "Web client(auto created by Google Service)".
* Copy **"Client Id"** and **"Client Secret"** (We will use in next step).

#### 9. Create Local file
* Add a new dart file named `desktop_credentials` in the `lib` folder.
* Add the below Code in the file.
```
const String googleClientId =
  "YOUR_GOOGLE_CLIENT_ID";
  const String authClientSecret = "YOUR AUTH_CLIENT_SECRET";
```

####  * Run app on Android
* Run the following command from the project folder to get your SHA-1 key:

```
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

* Open the Android app within your Firebase console.
* Add your SHA-1 key by clicking "Add Fingerprint".
* Download google-services.json.
* Replace it with the old `google_services.json` in `android/app/` (You can also do it by Flutterfire CLI).

####  * Run the app on iOS
* Open XCode, right-click the Runner folder, select the "Add Files to 'Runner'" menu, and select the GoogleService-Info.plist file to add it to /ios/Runner in XCode.
* Open /ios/Runner/Info.plist in a text editor.
* Then add the CFBundleURLTypes attributes.
```
<key>CFBundleURLTypes</key>
<array>
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<!-- TODO Replace this value: -->
			<!-- Copied from GoogleService-Info.plist key REVERSED_CLIENT_ID -->
			<string>com.googleusercontent.apps.861823949799-vc35cprkp249096uujjn0vvnmcvjppkn</string>
		</array>
	</dict>
</array>
```
* When running the app on the simulator for the first time, it may take a longer time to build.

####  * Run the app on the web
* Open the "Credentials" page of the [Google APIs console](https://console.cloud.google.com/apis/).
* Click on the `Web client  (auto-created by Google Service)`.
* Copy the  `Client ID` located at the top left side of the page.
* Open the web/index.html file, and add the following meta tag.
```
<meta name="google-signin-client_id" content="YOUR_GOOGLE_SIGN_IN_OAUTH_CLIENT_ID.apps.googleusercontent.com">

```
* Add localhost entries if you are running an app on a specific port on `Authorized JavaScript origins` or use the port that is already specified in this field.
* Run `flutter run -d chrome --web-hostname localhost --web-port 7357`.
* Replace the port with the one you added to the  `Authorized JavaScript origins` fields.
