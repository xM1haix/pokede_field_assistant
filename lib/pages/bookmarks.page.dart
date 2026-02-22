// import "dart:math";

// import "package:flutter/material.dart";
// import "package:pokede_field_assistant/classes/builder_helper.dart";
// import "package:pokede_field_assistant/classes/fav_icon_helper.dart";
// import "package:pokede_field_assistant/classes/pokemon.dart";
// import "package:pokede_field_assistant/widgets/custom_app_bar.dart";
// import "package:pokede_field_assistant/widgets/custom_scaffold.dart";
// import "package:pokede_field_assistant/widgets/list_builder.dart";

// class BookmarksPage extends StatefulWidget {
//   const BookmarksPage({super.key});
//   @override
//   State<BookmarksPage> createState() => _BookmarksPageState();
// }

// class _BookmarksPageState extends State<BookmarksPage> {
//   final _controller = TextEditingController();
//   late final Future<List<Pokemon>> _future;
//   var _isList = true;
//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       appBar: customAppBar(
//         controller: _controller,
//         isList: _isList,
//         onTap: () => setState(() => _isList = !_isList),
//       ),
//       body: ListBuilder(
//         future: _future,
//         isListMode: _isList,
//         builderHelper: BuilderHelper<Pokemon>(
//           title: (x) => x.name,
//           subTitle: (x) => x.type,
//           icon: (x) => SizedBox(
//             height: 250,
//             width: 250,
//             child: Center(child: Text(x.name)),
//           ),
//           onTap: (x) => _navigateToPokemonDetails(x.url),
//           favIconHelper: FavIconHelper(
//             isFav: (x) => Random().nextBool(),
//             onFavTap: (x) {},
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _init();
//   }

//   void _init() {
//     // _future = Pokemon.getAll();
//   }

//   Future<void> _navigateToPokemonDetails(String url) async {}
// }
