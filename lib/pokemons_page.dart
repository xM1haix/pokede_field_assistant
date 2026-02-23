import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/builder_helper.dart";
import "package:pokede_field_assistant/classes/coords.dart";
import "package:pokede_field_assistant/classes/fav_icon_helper.dart";
import "package:pokede_field_assistant/classes/open_metro.dart";
import "package:pokede_field_assistant/classes/pokemon.dart";
import "package:pokede_field_assistant/classes/pokemon_type.dart";
import "package:pokede_field_assistant/classes/switch_view_helper.dart";
import "package:pokede_field_assistant/details_page.dart";
import "package:pokede_field_assistant/extensions/build_context.dart";
import "package:pokede_field_assistant/extensions/string.dart";
import "package:pokede_field_assistant/others/popup.dart";
import "package:pokede_field_assistant/widgets/bookmark_icon_button.dart";
import "package:pokede_field_assistant/widgets/custom_hero.dart";
import "package:pokede_field_assistant/widgets/list_builder.dart";

class PokemonsPage extends StatefulWidget {
  const PokemonsPage({super.key});

  @override
  State<PokemonsPage> createState() => _PokemonsPageState();
}

class _PokemonsPageState extends State<PokemonsPage> {
  var _isListMode = true;
  final _coords = Coords(0, 0);
  var _searchedName = "";
  var _page = 0;
  var _limit = 100;
  late Future<List<Pokemon>> _future;
  final _numOfPages = 1;
  var _showOnlyFav = false;
  var _isWeather = false;
  PokemonType? _pokemonType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (_showOnlyFav || _isWeather)
            ? null
            : TextField(
                onSubmitted: _onSubmitted,
                decoration: const InputDecoration(hintText: "Search ..."),
              ),
        actions: [
          if (!_showOnlyFav)
            IconButton(
              onPressed: _setCoords,
              onLongPress: _disableWeather,
              icon: Icon(
                _isWeather ? Icons.cloud_outlined : Icons.cloud_off_outlined,
              ),
            ),
          BookmarkIconButton(isFav: _showOnlyFav, onTap: _showBookmarks),
          IconButton(onPressed: _changeTheNumOnPage, icon: Text("$_limit")),
          SwitchViewHelper(
            isList: _isListMode,
            onTap: _switchViewMode,
          ).toWidget(),
          if (_page >= 1)
            IconButton(
              tooltip: "Go to back page",
              disabledColor: Colors.transparent,
              onPressed: () => _goToPage(_page - 1),
              icon: const Icon(Icons.arrow_back_rounded),
            ),
          if (_page + 2 <= _numOfPages) Text("$_page"),
          IconButton(
            tooltip: "Go to next page",
            disabledColor: Colors.transparent,
            onPressed: () => _goToPage(_page + 1),
            icon: const Icon(Icons.arrow_forward_rounded),
          ),
        ],
      ),
      body: ListBuilder(
        switchViewHelper: SwitchViewHelper(
          isList: _isListMode,
          onTap: _switchViewMode,
        ),
        onRefresh: () async => _init(),
        future: _future,
        builderHelper: BuilderHelper<Pokemon>(
          onTap: _navToDetails,
          title: (x) => x.name.capitalizeFirst,
          subTitle: (x) => x.types.join(", ").toUpperCase(),
          icon: (x) => CustomHero(tag: x.id, url: x.sprites.first),
          favIconHelper: FavIconHelper(
            isFav: (x) => x.isFav,
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

  Future<void> _changeTheNumOnPage() async {
    final newValue = await changeNumOnPage(
      context: context,
      initialValue: _limit,
    );
    if (newValue == null) {
      return;
    }
    setState(() {
      _limit = newValue;
      _page = 0;
      _init();
    });
  }

  Future<void> _disableWeather() async {
    _pokemonType = _isWeather ? null : await OpenMetro.getPokemoType(_coords);
    _isWeather = !_isWeather;
    _page = 0;
    _init();
    setState(() {});
  }

  void _goToPage(int i) {
    _page = i;
    _init();
    setState(() {});
  }

  void _init() {
    print("called");
    _future = Pokemon.read(
      coords: _coords,
      onlyBookmarks: _showOnlyFav,
      pokemonType: _pokemonType,
      searchedName: _searchedName,
      page: _page,
      limit: _limit,
    );
  }

  Future<void> _navToDetails(Pokemon pokemon) async {
    await context.nav(DetailsPage(pokemon));
    setState(() {});
  }

  void _onSubmitted(String value) {
    setState(() {
      _page = 0;
      _searchedName = value;
      _init();
    });
  }

  Future<void> _saveToBookmarks(Pokemon x) async {
    final changed = await x.switchBookmark();
    if (changed) {
      setState(() {
        x.isFav = !x.isFav;
      });
    }
  }

  Future<void> _setCoords() async {
    final newCoods = await Coords.popupCoords(context, _coords);
    setState(() {
      _coords.reset(newCoods);
    });
  }

  void _showBookmarks() {
    setState(() {
      _page = 0;
      _showOnlyFav = !_showOnlyFav;
      _init();
    });
  }

  void _switchViewMode() {
    setState(() {
      _isListMode = !_isListMode;
    });
  }
}
