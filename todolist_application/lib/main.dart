import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/theme/app_colors.dart';
import 'package:namer_app/screens/home_page.dart';
import 'package:namer_app/providers/task_provider.dart';


void main() {
   runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyAppState()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.melon),
        ),
        home: MyHomePage(),
    );
  }
}

class MyAppState extends ChangeNotifier {

  var selectedIndex = 0;
  void setSelectedIndex(int index)
  {
    selectedIndex = index;
    notifyListeners();
  }
}



