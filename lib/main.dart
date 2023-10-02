import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pitarata_job/Screen/splash/Splash.dart';
import 'package:pitarata_job/class/notification.dart';
import 'package:pitarata_job/provider/get_Job.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

import 'Screen/home/about_us/single.php.dart';
import 'Screen/home/single_job/single_job.dart';
import 'providers/all_provider.dart';
import 'providers/google_sign_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // final fcmToken = await FirebaseMessaging.instance.getToken();
  await notify().initNotifications();
  // print(fcmToken);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => getJobId()),
      ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
      ChangeNotifierProvider(create: (_) => AppProvider()),
      // ChangeNotifierProvider(create: (_) => imgload()),
    ],
    child: const MyApp(),
  ));
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return SplashPage();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'single',
          path: 'single:id',
          builder: (context, state) {
            String id = state.uri.toString();
            const String removePart = '/single.php?id=';
            final String myId = id.replaceAll(removePart, '').trim();
            print('Street name: $myId');
            print(state.uri);

            return SingleJob(
              addId: myId,
              update: () {},
              x: true,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/single.php?id=6560',
      builder: (context, state) {
        print(state.pathParameters);
        return SingleJob(
          addId: '652',
          update: () {},
          x: true,
        );
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
        // initialRoute: "/",
        // home: SplashPage(),
        routerConfig: _router,
      );
    });
  }
}
