# --- Razorpay SDK fix ---
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }

# --- Keep Razorpay classes ---
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# --- Flutter and other essentials ---
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }
-dontwarn io.flutter.embedding.**

# Optional: keep your model classes if you use reflection/JSON
-keep class com.example.vistacall.** { *; }
