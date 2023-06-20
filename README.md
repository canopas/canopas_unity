## Unity - Flutter Application

Unity is cross-platform Leave Management application written in dart using Flutter.

## Download App

<img src="https://github.com/canopas/canopas-unity/blob/update-doc/screenshots/app-store-dl.png" width="200">   <img src="https://github.com/canopas/canopas-unity/blob/update-doc/screenshots/google-playstore-dl.png" width="200">

## Features
* Unity is open source leave management app designed to track employee's leave within an organization.
* Unity allows you to create and manage multiple spaces.
* You can easily add employees with different role types such as Admin, HR and Employee.

:boom: Unity app uses `firestore` database. :boom:

## Getting started
* Project setup instructions 

#### 1. [Flutter Environment Setup](https://docs.flutter.dev/get-started/install)
> **Note**: Flutter sdk vesion `3.3.7` is recommended to run project.

#### 2. Clone the repo
```sh
$ git clone https://github.com/canopas/canopas-unity.git
```
#### 3. Setup the firebase app

1. You'll need to create a Firebase instance. Follow the instructions at https://console.firebase.google.com/

2. Once your Firebase instance is created, you'll need to be enable Google authentication.

* Go to Firebase console for your new instance.
* Click "Authentication" in the left-hand menu
* Click the "sign-in method" tab
* Click the "Google" and enable it.

3. Enable the Firebase Database
* Go to the Firebase Console
* Click "Firestore Database" in the left-hand menu
* Click the "Create Database" button
* It will prompt you to set up, rules, for the sake of simplicity, let us choose test mode, for now.
* On the next screen, select any of the locations you prefer.

4. Add Flutter App in Firebase
* In the Firebase console, in the settings of your project
* Click on the Flutter Icon to add Flutter app
* Follow the instruction to add Flutter app

  <img width="1050" alt="Screenshot 2020-05-04 at 6 01 40 PM" src="https://github.com/canopas/canopas-unity/blob/update-doc/screenshots/flutter_firebase_register.png">

* It will create `firebase_options.dart` file in the `lib` folder.

5. Get Google ClientId for app
* Go to [Google APIs console](https://console.cloud.google.com/apis/).
* On the top bar, Choose your project from drop down menu if selected default project is not your current project.
* Click on the "API APIs and services".

  <img width="1080" alt="Screenshot 2020-05-04 at 6 01 40 PM" src="https://github.com/canopas/canopas-unity/blob/update-doc/screenshots/Google%20cloud-console.png">

* On the left side menu, Select "Credentials".
* Click on the "Web client(auto created by Google Service)".
* Copy **"Client Id"** and **"Client Secret"** (We will use in next step).

6. Create Local file 
* Add a new dart file named `desktop_credentials` in the `lib` folder.
* Add the below Code in the file.
```
const String googleClientId =
  "YOUR_GOOGLE_CLIENT_ID";
  const String authClientSecret = "YOUR AUTH_CLIENT_SECRET";
```

7. Run app on Android (Skip if not running on Android)
* Run the following command from the project folder to get your SHA-1 key:

```
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

* Open Android app within your Firebase console
* Add your SHA-1 key by clicking "Add Fingerprint".
* Download google-services.json.
* Replace it with old `google_services.json` in `android/app/` (You can also do it by Flutterfire CLI).

8.Run app on iOS(Skip if not running on iOS)
* Open XCode, right click the Runner folder, select the "Add Files to 'Runner'" menu, and select the GoogleService-Info.plist file to add it to /ios/Runner in XCode
* Open /ios/Runner/Info.plist in a text editor.
* Then add the CFBundleURLTypes attributes
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

9. Run app on web(Skip if not running on web)
* Open the "Credentials" page of the [Google APIs console](https://console.cloud.google.com/apis/).
* Click on the `Web client  (auto created by Google Service)`.
* Copy the  `Client ID` located at the top left side of the page.
* Open web/index.html file, add the following meta tag.
```
<meta name="google-signin-client_id" content="YOUR_GOOGLE_SIGN_IN_OAUTH_CLIENT_ID.apps.googleusercontent.com">

```
* Add localhost entries if you are running app on specific port on `Authorized JavaScript origins` or use the port that already specified in this field.
* Run `flutter run -d chrome --web-hostname localhost --web-port 7357`.
* Replace the port with one you added to the  `Authorized JavaScript origins` fields.
