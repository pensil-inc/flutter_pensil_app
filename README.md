# Pensil Teaching App

Pensil Teach App is an education platform created specifically for the tutors of the digital age. Pensil Teaching app reduce gap between tutor and students and form a bridge no matter how far they are.

## Project Setup
#### 1. [Flutter Environment Setup](https://flutter.dev/docs/get-started/install)

#### 2. Clone the repo

``` sh
$ git clone https://github.com/pensil-inc/flutter_pensil_app.git
$ cd flutter_pensil_app/
```

#### 3. Setup the firebase app

1. You'll need to create a Firebase instance. Follow the instructions at https://console.firebase.google.com.
2. Once your Firebase instance is created, you'll need to enable Google authentication.

* Go to the Firebase Console for your new instance.
* Click "Authentication" in the left-hand menu
* Click the "sign-in method" tab
* Click "Google" and enable it

3. Enable the Firebase Database
* Go to the Firebase Console
* Click "Database" in the left-hand menu
* Click the "Create Database" button
* It will prompt you to set up, rules, for the sake of simplicity, let us choose test mode, for now.
* On the next screen select any of the locations you prefer.

* Create an app within your Firebase instance for Android, with package name > `com.pensil.pensilapp`
* Run the following command to get your SHA-1 key:

```
keytool -exportcert -list -v \
-alias androiddebugkey -keystore ~/.android/debug.keystore
```

* In the Firebase console, in the settings of your Android app, add your SHA-1 key by clicking "Add Fingerprint".

* Download google-services.json 
* place `google-services.json` into `/android/app/`.

7. (skip if not running on iOS)

* Create an app within your Firebase instance for iOS, with your app package name
* Follow instructions to download GoogleService-Info.plist
* Open XCode, right click the Runner folder, select the "Add Files to 'Runner'" menu, and select the GoogleService-Info.plist file to add it to /ios/Runner in XCode
* Open /ios/Runner/Info.plist in a text editor. Locate the CFBundleURLSchemes key. The second item in the array value of this key is specific to the Firebase instance. Replace it with the value for REVERSED_CLIENT_ID from GoogleService-Info.plist


## Contributing

If you wish to contribute a change to any of the existing feature or add new in this repo, send a pull request. We welcome and encourage all pull requests. It usually will take us within 24-48 hours to respond to any issue or request.


## Visitors Count

<img align="left" src = "https://profile-counter.glitch.me/flutter_pensil_app/count.svg" alt ="Loading">
