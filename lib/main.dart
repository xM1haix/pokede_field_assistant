import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/major_data.dart";
import "package:pokede_field_assistant/classes/shared_pref_helper.dart";
import "package:pokede_field_assistant/pages/home_page.dart";
import "package:provider/provider.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsService.instance.init();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MajorData())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pokede Field Assistant",
      theme: ThemeData(),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomePage(),
    );
  }
}
