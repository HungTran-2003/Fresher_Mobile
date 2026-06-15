import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val devKeystorePropertiesFile = File(rootDir, "dev_key.properties")

val devKeystoreProperties = Properties()
if (devKeystorePropertiesFile.exists()) {
    devKeystoreProperties.load(devKeystorePropertiesFile.inputStream())
}

android {
    namespace = "com.example.finance"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion


    signingConfigs {
        create("dev") {
            keyAlias = devKeystoreProperties["keyAlias"] as String
            keyPassword = devKeystoreProperties["keyPassword"] as String
            storeFile = file("${devKeystoreProperties["storeFile"]}")
            storePassword = devKeystoreProperties["storePassword"] as String
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.finance"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        getByName("debug") {
            signingConfig = signingConfigs.getByName("dev")
        }
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("dev")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    "coreLibraryDesugaring"("com.android.tools:desugar_jdk_libs:2.1.4")
}

