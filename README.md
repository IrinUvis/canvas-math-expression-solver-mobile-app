# Canvas math expression solver

Equation solver app which uses AI to accomplish its task.
The app runs on both Android and iOS.

## Installing
In order to run the app run this command in root folder of the project:
````
flutter run
````
This will install it on your Android/iOS device assuming that you have connected it to your computer via USB and enabled USB debugging.
Alternatively, you can use Android Studio IDE, which should narrow the installation process to pressing one button. 
Other than that, if you are using Android you can run this command:
````
flutter build apk
````
This command will build android package, which if downloaded on Android device will allow you to install it directly.

Whichever method is chosen, you will need to have Flutter SDK installed.

## Functionalities
The app allows the user to draw digits (0-9), basic math operators (+, -, *, /) and left and right brackets ([, ]).

The AI model, which we have trained ourselves recognizes drawn symbols, and forms a math expression out of them.
This expression can be modified by deleting these symbols or swapping their positions by pressing and dragging.

At the bottom of the screen, the user can see either a result of math expression or a message explaining what is not okay with the formed expression.

The top bar contains four actions:
* Open app's drawer (hamburger icon)
* Add drawn symbol to the expression (calculator icon)
* Share the expression's result (share icon)
* Clear canvas and retry (repeat icon)

Use those to use the app to its fullest.
