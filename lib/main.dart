import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/shared_pref_helper.dart";
import "package:pokede_field_assistant/pages/home_page.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsService.instance.init();
  const MyApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pokede Field Assistant",
      theme: ThemeData(appBarTheme: const AppBarTheme(centerTitle: true)),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(centerTitle: true),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomePage(),
    );
  }
}
