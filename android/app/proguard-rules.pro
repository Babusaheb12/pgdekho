## Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

## Flutter Play Store Split Compatibility
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks**

## Google ML Kit Text Recognition
-keep class com.google.mlkit.vision.text.** { *; }
-keep class com.google.android.gms.mlkit.vision.text.** { *; }

## Keep Chinese text recognizer options
-keep class com.google.mlkit.vision.text.chinese.** { *; }
-dontwarn com.google.mlkit.vision.text.chinese.**

## Keep Devanagari text recognizer options
-keep class com.google.mlkit.vision.text.devanagari.** { *; }
-dontwarn com.google.mlkit.vision.text.devanagari.**

## Keep Japanese text recognizer options
-keep class com.google.mlkit.vision.text.japanese.** { *; }
-dontwarn com.google.mlkit.vision.text.japanese.**

## Keep Korean text recognizer options
-keep class com.google.mlkit.vision.text.korean.** { *; }
-dontwarn com.google.mlkit.vision.text.korean.**

## Gson
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

## Models
-keepclassmembers,allowobfuscation class * implements com.google.gson.TypeAdapterFactory
-keepclassmembers,allowobfuscation class * implements com.google.gson.JsonSerializer
-keepclassmembers,allowobfuscation class * implements com.google.gson.JsonDeserializer
