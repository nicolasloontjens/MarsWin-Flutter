# MarsWin

A Flutter application for the MarsWin betting site.

[![Deploy to Firebase Hosting](https://github.com/nicolasloontjens/MarsWin-Flutter/actions/workflows/firebase-hosting-merge.yml/badge.svg)](https://github.com/nicolasloontjens/MarsWin-Flutter/actions/workflows/firebase-hosting-merge.yml)

## Info:

The application is available at <a href="https://marswin.nicolasloontjens.com">here</a>.  
This project is using GitHub action deploys and is being hosted on Firebase.   
<a href="https://github.com/nicolasloontjens/MarsWin-Flutter">GitHub</a>

## Running locally:

1. Clone the repository
2. Install the flutter sdk (https://flutter.dev/docs/get-started/install)
3. Run `flutter pub get` in the root of the project
4. If you are using VS Code, you can open the project and press F5 to run the application otherwise run `flutter run` in the root of the project and select the `chrome` option.

When running the application with VS Code you might have to uncheck "Uncaught Exceptions" in the debug tab of VS Code. Otherwise the ui will block whilst running. This is since some packages that are used are throwing errors that can not be caught.