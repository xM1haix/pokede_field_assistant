import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/builder_helper.dart";
import "package:pokede_field_assistant/classes/fav_icon_helper.dart";
import "package:pokede_field_assistant/classes/parameters.dart";
import "package:pokede_field_assistant/classes/pokemon.dart";
import "package:pokede_field_assistant/classes/viewer_tool_helper.dart";
import "package:pokede_field_assistant/extensions/build_context.dart";
import "package:pokede_field_assistant/pages/details_page.dart";
import "package:pokede_field_assistant/widgets/custom_cache_network_img.dart";
import "package:pokede_field_assistant/widgets/custom_scaffold.dart";
import "package:pokede_field_assistant/widgets/list_builder.dart";

class PokemonsPage extends StatefulWidget {
  const PokemonsPage({super.key});

  @override
  State<PokemonsPage> createState() => _PokemonsPageState();
}

class _PokemonsPageState extends State<PokemonsPage> {
  var _isListMode = true;
  final _parameters = Parameters(page: 0, limit: 100);
  late Future<List<Pokemon>> _future;
  var _showTools = true;
  final _numOfPages = 3;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Pokemons")),
      body: ListBuilder(
        switchView: _switchViewMode,
        goToPage: _goToPage,
        popupToChangeTheNumOnPage: () async {},
        onNotification: _onNotification,
        viewerToolHelper: ViewerToolHelper(
          showTools: _showTools,
          currentPage: _parameters.page!,
          numOfPages: _numOfPages,
          numOnPage: _parameters.limit ?? 0,
        ),
        onRefresh: () async => _init(),
        future: _future,
        isListMode: _isListMode,
        builderHelper: BuilderHelper<Pokemon>(
          onTap: (x) => context.nav(DetailsPage(x)),
          title: (x) => x.name,
          subTitle: (x) => x.type,
          icon: (x) => Hero(
            tag: x.id,
            child: Material(
              color: Colors.transparent,
              child: CustomCacheNetworkImg(x.imageUrl),
            ),
          ),
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

  void _goToPage(int i) {
    _parameters.page = i;
    _init();
    setState(() {});
  }

  void _init() {
    _future = Pokemon.readAll(_parameters);
  }

  bool _onNotification(ScrollUpdateNotification e) {
    setState(() => _showTools = e.scrollDelta! < 0);
    return true;
  }

  Future<void> _saveToBookmarks(Pokemon x) async {
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
