# Pensil Teaching App

Pensil Teach App is an education platform created specifically for the tutors of the digital age. Pensil Teaching app reduce gap between tutor and students and form a bridge no matter how far they are.

## Project Setup

<details>
     <summary> Click to expand </summary>
  
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

</details>

## Project Structure

<details>
 <summary> Click to expand </summary>
  
```
|-- lib
|   |-- build.yaml
|   |-- config
|   |   |-- config.dart
|   |   '-- configs.dart
|   |-- helper
|   |   |-- constants.dart
|   |   |-- enum.dart
|   |   |-- images.dart
|   |   |-- shared_prefrence_helper.dart
|   |   '-- utility.dart
|   |-- locator.dart
|   |-- main.dart
|   |-- model
|   |   |-- actor_model.dart
|   |   |-- batch_meterial_model.dart
|   |   |-- batch_model.dart
|   |   | (8 more...)
|   |   |-- quiz_model.dart
|   |   |-- subject.dart
|   |   '-- video_model.dart
|   |-- resources
|   |   |-- contact_service.dart
|   |   |-- exceptions
|   |   |   '-- exceptions.dart
|   |   |-- repository
|   |   |   |-- batch_repository.dart
|   |   |   '-- teacher
|   |   |       '-- teacher_repository.dart
|   |   '-- service
|   |       |-- api_gatway.dart
|   |       |-- api_gatway_impl.dart
|   |       |-- dio_client.dart
|   |       |-- notification_service.dart
|   |       '-- session
|   |           |-- session.dart
|   |           '-- session_impl.dart
|   |-- states
|   |   |-- auth
|   |   |   '-- auth_state.dart
|   |   |-- base_state.dart
|   |   |-- home_state.dart
|   |   |-- notificaion
|   |   |   '-- notification_state.dart
|   |   |-- quiz
|   |   |   '-- quiz_state.dart
|   |   '-- teacher
|   |       |-- announcement_state.dart
|   |       |-- batch_detail_state.dart
|   |       |-- create_batch_state.dart
|   |       |-- material
|   |       |   '-- batch_material_state.dart
|   |       |-- poll_state.dart
|   |       '-- video
|   |           '-- video_state.dart
|   '-- ui
|       |-- app.dart
|       |-- kit
|       |   |-- alert.dart
|       |   '-- overlay_loader.dart
|       |-- page
|       |   |-- announcement
|       |   |   '-- create_announcement.dart
|       |   |-- auth
|       |   |   |-- forgot_password.dart
|       |   |   |-- login.dart
|       |   |   |-- signup.dart
|       |   |   |-- update_password.dart
|       |   |   |-- verify_Otp.dart
|       |   |   '-- widgets
|       |   |       '-- Otp_widget.dart
|       |   |-- batch
|       |   |   |-- batch_master_page.dart
|       |   |   |-- create_batch
|       |   |   |   |-- create_batch.dart
|       |   |   |   |-- device_contacts_page.dart
|       |   |   |   |-- search_student_delegate.dart
|       |   |   |   '-- widget
|       |   |   |       |-- add_students_widget.dart
|       |   |   |       |-- batch_time_slots.dart
|       |   |   |       '-- search_batch_delegate.dart
|       |   |   |-- pages
|       |   |   |   |-- batch_assignment_page.dart
|       |   |   |   |-- detail
|       |   |   |   |   |-- batch_detail_page.dart
|       |   |   |   |   '-- student_list.dart
|       |   |   |   |-- material
|       |   |   |   |   |-- batch_study_material_page.dart
|       |   |   |   |   |-- upload_material.dart
|       |   |   |   |   '-- widget
|       |   |   |   |       '-- batch_material_card.dart
|       |   |   |   |-- quiz
|       |   |   |   |   |-- quiz_list_page.dart
|       |   |   |   |   |-- result
|       |   |   |   |   |   |-- quiz_result_page.dart
|       |   |   |   |   |   '-- view_quiz_solution.dart
|       |   |   |   |   '-- start
|       |   |   |   |       |-- start_quiz.dart
|       |   |   |   |       '-- widget
|       |   |   |   |           |-- question_count_section.dart
|       |   |   |   |           '-- timer.dart
|       |   |   |   '-- video
|       |   |   |       |-- add_video_page.dart
|       |   |   |       |-- batch_videos_page.dart
|       |   |   |       |-- video_player_pag2e.dart
|       |   |   |       |-- video_player_page.dart
|       |   |   |       |-- video_preview.dart
|       |   |   |       '-- widget
|       |   |   |           '-- batch_video_Card.dart
|       |   |   '-- widget
|       |   |       '-- tile_action_widget.dart
|       |   |-- common
|       |   |   |-- pdf_view.dart
|       |   |   |-- splash.dart
|       |   |   '-- web_view.page.dart
|       |   |-- home
|       |   |   |-- home_Scaffold.dart
|       |   |   |-- home_page_student.dart
|       |   |   |-- home_page_teacher.dart
|       |   |   |-- student_list_preview.dart
|       |   |   '-- widget
|       |   |       |-- announcement_widget.dart
|       |   |       |-- batch_widget.dart
|       |   |       '-- poll_widget.dart
|       |   |-- notification
|       |   |   '-- notifications_page.dart
|       |   '-- poll
|       |       |-- View_all_poll_page.dart
|       |       |-- create_poll.dart
|       |       '-- poll_option_widget.dart
|       |-- theme
|       |   |-- extentions.dart
|       |   |-- light_color.dart
|       |   |-- text_theme.dart
|       |   '-- theme.dart
|       '-- widget
|           |-- fab
|           |   |-- animated_fab.dart
|           |   '-- fab_button.dart
|           |-- form
|           |   |-- p_textfield.dart
|           |   '-- validator.dart
|           |-- image_viewer.dart
|           |-- p_avatar.dart
|           |-- p_button.dart
|           |-- p_chiip.dart
|           |-- p_loader.dart
|           |-- p_title_text.dart
|           |-- secondary_app_bar.dart
|           '-- url_Text.dart
|-- pubspec.yaml

```

  
</details>

## Dependencies
<details>
     <summary> Click to expand </summary>

* [intl](https://pub.dev/packages/intl)
* [dio](https://pub.dev/packages/dio)
* [share](https://pub.dev/packages/)
* [share](https://pub.dev/packages/share)
* [dartz](https://pub.dev/packages/dartz)
* [get_it](https://pub.dev/packages/get_it)
* [freezed](https://pub.dev/packages/freezed)
* [provider](https://pub.dev/packages/provider)
* [equatable](https://pub.dev/packages/equatable)
* [file_picker](https://pub.dev/packages/file_picker)
* [filter_list](https://pub.dev/packages/filter_list)
* [build_runner](https://pub.dev/packages/build_runner)
* [url_launcher](https://pub.dev/packages/url_launcher)
* [add_thumbnail](https://pub.dev/packages/add_thumbnail)
* [image_picker](https://pub.dev/packages/image_picker)
* [firebase_auth](https://pub.dev/packages/firebase_auth)
* [firebase_core](https://pub.dev/packages/firebase_core)
* [google_sign_in](https://pub.dev/packages/google_sign_in)
* [json_annotation](https://pub.dev/packages/json_annotation)
* [webview_flutter](https://pub.dev/packages/webview_flutter)
* [contacts_service](https://pub.dev/packages/contacts_service)
* [permission_handler](https://pub.dev/packages/permission_handler)
* [firebase_messaging](https://pub.dev/packages/firebase_messaging)
* [json_serializable](https://pub.dev/packages/json_serializable)
* [freezed_annotation](https://pub.dev/packages/freezed_annotation)
* [shared_preferences](https://pub.dev/packages/shared_preferences)
* [advance_pdf_viewer](https://pub.dev/packages/advance_pdf_viewer)
* [cached_network_image](https://pub.dev/packages/cached_network_image)
* [cached_network_image](https://pub.dev/packages/cached_network_image)
* [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
     
</details>

## Contributing

If you wish to contribute a change to any of the existing feature or add new in this repo, send a pull request. We welcome and encourage all pull requests. It usually will take us within 24-48 hours to respond to any issue or request.


## Visitors Count

<img align="left" src = "https://profile-counter.glitch.me/flutter_pensil_app/count.svg" alt ="Loading">
