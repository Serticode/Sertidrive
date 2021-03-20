# Sertidrive

A Flutter project built as a means to learn Firebase.

## Sertidrive Folders

    Screens - This contains different app screens that can be navigated to.
        The screens folder is subdivided into 3. Authenticate, Home, Others.

        Authenticate - This contains 3 files. Authenticate, Register, SignIn.

            Authenticate.dart - the class that toggles between the SignIn.dart and Register.dart pages.

            Register.dart - as the name implies, the register screen.

            SignIn.dart - the SignIn screen.

        Home - This contains 3 files. Home, userFoldersList, wrapper.

             Home.dart - The HomeScreen, after Logging in or Registering successfully.

             userFoldersList.dart - contains the class and methods, written, to retrieve the firebase storage root directory, subdirectories and files in the logged in users account.

             Wrapper.dart - this toggles between the Authenticate screen { when no user is logged in } and the Home screen { when there is an active user or a logged in user} .

        Others - Contains other important screens. example [
            "audioList screen",
            "uploads screen",
        ]

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
