# MarsWin

A Flutter application for the MarsWin betting site.

[![Deploy to Firebase Hosting](https://github.com/nicolasloontjens/MarsWin-Flutter/actions/workflows/firebase-hosting-merge.yml/badge.svg)](https://github.com/nicolasloontjens/MarsWin-Flutter/actions/workflows/firebase-hosting-merge.yml)

## Project Description:

This app was built to interact with our MarsWin system. It uses the Flutter framework and is built for web currently.

You can find a demo video of this application <a href="">here</a>.

## Project requirements and dependencies:

Requirements:
- Flutter SDK (https://flutter.dev/docs/get-started/install)
- Dart SDK (comes with Flutter SDK)
- VS Code (recommended for launching the application locally)

Dependencies:

These can be found in the pubspec.yaml file.

- cupertino_icons: ^1.0.2
- get_storage: ^2.0.3
- http: ^0.13.5
- carbon_icons: ^0.0.1+2
- url_launcher: ^6.1.6
- flutter_phoenix: ^1.1.0
- flutter_spinkit: ^5.1.0
- youtube_player_flutter: ^8.1.1
- shared_preferences: ^2.0.15
- flutter_styled_toast: ^2.1.3
- lecle_yoyo_player: ^0.0.4+1


## Project structure:

All the code is inside the lib folder.   
The app is launched from the main.dart file.  
The app is split into 3 main parts:

- The pages folder: contains all the pages of the application
- The routing folder: contains a route generator which handles the routing of the application
- The data folder: contains all the data models and datafetcher.dart which interacts with the MarsWin API.

## Running locally:

1. Install the flutter sdk (https://flutter.dev/docs/get-started/install)
2. Clone the repository
3. Run `flutter pub get` in the root of the project, this will download all the dependencies
4. If you are using VS Code, you can open the project and press F5 to run the application otherwise run `flutter run` in the root of the project and select the `chrome` option.

Note:   
When running the application with VS Code you might have to uncheck "Uncaught Exceptions" in the debug tab of VS Code. Otherwise the ui will block whilst running. This is since some packages that are used are throwing errors that can not be caught.

## Releases:
The project has been built for the following sources using <a href="https://codemagic.io/start/">codemagic.io</a>

- Web
- Linux
- Windows
- MacOS
- Android
- iOS

You can find them <a href="https://github.com/nicolasloontjens/MarsWin-Flutter/releases/tag/'v1'">here</a>.

## Project deployment:

The application is available at <a href="https://marswin.nicolasloontjens.com">marswin.nicolasloontjens.com</a>.  
This project is using GitHub action deploys and is being hosted on Firebase.   
<a href="https://github.com/nicolasloontjens/MarsWin-Flutter">Project link on GitHub</a>
