import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/builder_helper.dart";
import "package:pokede_field_assistant/classes/fav_icon_helper.dart";
import "package:pokede_field_assistant/classes/navigator_helper.dart";
import "package:pokede_field_assistant/classes/parameters.dart";
import "package:pokede_field_assistant/classes/pokemon/simple_pokemon.dart";
import "package:pokede_field_assistant/classes/switch_view_helper.dart";
import "package:pokede_field_assistant/extensions/build_context.dart";
import "package:pokede_field_assistant/pages/details_page.dart";
import "package:pokede_field_assistant/widgets/custom_hero.dart";
import "package:pokede_field_assistant/widgets/list_builder.dart";

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  var _isListMode = true;
  final _parameters = Parameters(page: 0, limit: 100);
  late Future<List<SimplePokemon>> _future;
  var _showTools = true;
  var _numOfPages = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokemons")),
      body: ListBuilder(
        navigatorHelper: NavigatorHelper(
          currentPage: _parameters.page!,
          numOfPages: _numOfPages,
          navigateToPage: _goToPage,
          numOnPage: _parameters.limit!,
          changeTheNumOnPage: _changeTheNumOnPage,
        ),
        switchViewHelper: SwitchViewHelper(
          isList: _isListMode,
          onTap: _switchViewMode,
        ),
        onNotification: _onNotification,
        showTools: _showTools,
        onRefresh: () async => _init(),
        future: _future,
        builderHelper: BuilderHelper<SimplePokemon>(
          onTap: (x) => context.nav(DetailsPage(x)),
          title: (x) => x.name,
          subTitle: (x) => x.type,
          icon: (x) => CustomHero(tag: x.id, url: x.imageUrl),
          favIconHelper: FavIconHelper(
            isFav: (x) => x.isBookmarked,
            onFavTap: _saveToBookmarks,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void onSubmitted(String value) {
    if (value.isEmpty) {
      if (_parameters.name == null) {
        //DO NOTHING
      } else {
        _parameters.name = value;
        _parameters.page = 0;
      }
    } else {
      if (_parameters.name == value) {
        //DO NOTHING
      } else {
        _parameters.name = value;
        _parameters.page = 0;
      }
    }
  }

  void _changeTheNumOnPage(int newValue) {
    setState(() {
      _parameters.limit = newValue;
      _parameters.page = 0;
      _init();
    });
  }

  void _goToPage(int i) {
    _parameters.page = i;
    _init();
    setState(() {});
  }

  void _init() {
    _future = SimplePokemon.readAll(_parameters).then((x) {
      setState(() {
        _numOfPages = SimplePokemon.counter ~/ _parameters.limit!;
      });
      return x;
    });
  }

  bool _onNotification(ScrollUpdateNotification e) {
    setState(() => _showTools = e.scrollDelta! < 0);
    return true;
  }

  Future<void> _saveToBookmarks(SimplePokemon x) async {
    final changed = await x.switchBookmark();
    if (changed) {
      setState(() {
        x.isBookmarked = !x.isBookmarked;
      });
    }
  }

  void _switchViewMode() {
    setState(() {
      _isListMode = !_isListMode;
    });
  }
}
