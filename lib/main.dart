import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skillorbit/core/app_theme.dart';

import 'app.dart';
import 'firebase_options.dart';

// Global variable to store detected flavor
String detectedFlavor = 'user';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Detect flavor at startup
  const webFlavor = String.fromEnvironment('FLAVOR');
  if (appFlavor != null && appFlavor!.isNotEmpty) {
    detectedFlavor = appFlavor!;
  } else if (webFlavor.isNotEmpty) {
    detectedFlavor = webFlavor;
  }
  
  // Use print instead of debugPrint to ensure it shows in all terminals
  print('=======================================');
  print('APP STARTING WITH FLAVOR: $detectedFlavor');
  print('Native Flavor: $appFlavor');
  print('Web Flavor: $webFlavor');
  print('=======================================');

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  AppTheme();
  runApp(const App());
}
