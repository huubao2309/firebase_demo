# Firebase

## Guide setup Firebase on Flutter Android:

- Android: https://console.firebase.google.com/

## 1. Create a Firebase project:

https://firebase.google.com/docs/flutter/setup?platform=android#create-firebase-project

**Note**: Get SHA-1 on Android Studio (https://stackoverflow.com/questions/51845559/generate-sha-1-for-flutter-app)

## 2. Register your app with Firebase:

https://firebase.google.com/docs/flutter/setup?platform=android#register-app

## 3. Add a Firebase configguration file:

https://firebase.google.com/docs/flutter/setup?platform=android#add-config-file

## 4. Add FlutterFire plugins:

https://firebase.google.com/docs/flutter/setup?platform=android#add-flutterfire-plugins

```dart
	firebase_analytics: ^6.2.0
	firebase_messaging: ^7.0.3
	firebase_core: ^0.5.2
```

**Reference**: https://github.com/rajayogan/flutter-pushnotifications-basics

## 5. Get Firebase Token:

```dart
	final FirebaseMessaging _messaging = FirebaseMessaging();
	//....
	
	  @override
	void initState() {
		super.initState();

		_messaging.getToken().then((token) {
		  print(token);
		});
	}
```

## 6. Receive message to Firebase (Foreground):

```dart
	_messaging.configure(
      onMessage: (message) async {
        print('onMessage Firebase: $message');
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (message) async {
        print('onLaunch Firebase: $message');
      },
      onResume: (message) async {
        print('onResume Firebase: $message');
      },
    );
```

## 7. Receive message to Firebase (Background)

