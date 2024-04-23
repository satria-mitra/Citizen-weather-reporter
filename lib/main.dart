import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weathershare/features/bindings/initial_bindings.dart';
import 'package:weathershare/features/screens/on_boarding/on_boarding_view.dart';
import 'package:weathershare/features/screens/user_profile/user_screen.dart';
import 'package:weathershare/repository/auth_repo.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
//import 'package:weathershare/firebase_options.dart';
// import 'package:weathershare/splash/onboard.dart';
//import 'package:weathershare/splash/splash_screen.dart';
//import 'package:weathershare/screens/homescreen.dart';
import 'package:weathershare/utils/themes/theme.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // display splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await GetStorage.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (FirebaseApp value) => Get.put(AuthenticationRepo()),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/user-profile',
          page: () => const UserProfileScreen(),
        )
      ],
      home: const OnBoardingView(),
    );
  }
}
