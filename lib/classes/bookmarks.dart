import "package:pokede_field_assistant/classes/shared_pref_helper.dart";

class BookmarkService {
  BookmarkService._();
  static final instance = BookmarkService._();

  final _pokemonBookmarksKey = "pokemonBookmarks";
  List<int> getAll() {
    final list =
        SharedPrefsService.instance.readStringList(_pokemonBookmarksKey) ?? [];
    return list.map(int.tryParse).whereType<int>().toList();
  }

  bool isBookmark(int value) => SharedPrefsService.instance.isInStringList(
    _pokemonBookmarksKey,
    value.toString(),
  );
  Future<bool> removeBookmark(int value) async => SharedPrefsService.instance
      .removeFromStringList(_pokemonBookmarksKey, value.toString());

  Future<bool> saveBookmark(int value) async => SharedPrefsService.instance
      .addToStringList(_pokemonBookmarksKey, value.toString());

  Future<bool> switchBookmark(int value, {required bool isBookmarked}) async =>
      isBookmarked ? await removeBookmark(value) : await saveBookmark(value);
}
