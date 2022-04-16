import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todo_amplify/views/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Amplify Todo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
            ),
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: Colors.black,
            ),
      ),
      darkTheme: ThemeData(
        backgroundColor: Colors.grey.shade900,
        dialogBackgroundColor: Colors.grey.shade900,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
          shadowColor: Colors.grey,
          centerTitle: true,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade800,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              decorationColor: Colors.white,
            ),
        hintColor: Colors.white60,
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: Colors.white,
            ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.grey.shade900,
        ),
        scaffoldBackgroundColor: Colors.grey.shade900,
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}
