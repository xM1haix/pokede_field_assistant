import "package:flutter/material.dart";
import "package:pokede_field_assistant/extensions/build_context.dart";
import "package:pokede_field_assistant/pages/pokemons_page.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PokeDe Field Assistant"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const Center(child: Text("Welcome to PokeDe Field Assistant!")),
          ListTile(
            title: const Text("Pokemons"),
            onTap: () => context.nav(const PokemonsPage()),
          ),
        ],
      ),
    );
  }
}
