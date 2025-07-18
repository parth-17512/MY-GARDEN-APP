import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_garden_app/screens/add_plant_screen.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/plant_provider.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'firebase_options.dart';
import 'package:go_router/go_router.dart';

final GoRouter _route = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => AuthWrapper()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/auth', builder: (context, state) => AuthScreen()),
    GoRoute(path: '/add-plant', builder: (context, state) => AddPlantScreen()),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PlantProvider()),
      ],
      child: MaterialApp.router(
        title: 'My Garden',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routerConfig: _route,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (authProvider.user != null) {
          return HomeScreen();
        }

        return AuthScreen();
      },
    );
  }
}
