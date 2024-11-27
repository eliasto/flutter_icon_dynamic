# Flutter Dynamic Icon Plugin

A Flutter plugin for changing the app icon dynamically. Available for both Android and iOS.

## Getting Started

Check out the `example` directory to see the plugin in action.

### Setup
#### Android

1. Add your icons to the `android/app/src/main/res` directory. You can use both mipmap and drawable directories.

2. Add the following to your `AndroidManifest.xml` inside the `<application>` tag, for each icon you added in the previous step:
```xml
<activity-alias
    android:name=".MainActivitySncfConnectGreen"
    android:enabled="false" // Set to true for the default icon
    android:exported="true"
    android:icon="@mipmap/my_icon"
    android:label="My app name"
    android:targetActivity=".MainActivity">
    <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>
</activity-alias>
```

#### iOS

1. Add your icons to the `ios/Runner/Assets.xcassets` directory (right click iOS > New iOS App Icon). Create a new AppIcon set and add the icons to the set.

2. In the Build Settings of your target, search for `Asset Catalog Compiler - Options` and set the `Include All App Icon Assets` to true. Then, in the `Alternate App Icon Sets` list, add the names of the icons you added in the previous step.