import "package:pokede_field_assistant/classes/shared_pref_helper.dart";

class BookmarkService {
  BookmarkService._();
  static final instance = BookmarkService._();
  final _pokemnonBookmarksKey = "pokemon_bookmarks";
  bool isBookmark(String value) =>
      SharedPrefsService.instance.isInStringList(_pokemnonBookmarksKey, value);
  Future<bool> removeBookmark(String value) async => SharedPrefsService.instance
      .removeFromStringList(_pokemnonBookmarksKey, value);
  Future<bool> saveBookmark(String value) async =>
      SharedPrefsService.instance.addToStringList(_pokemnonBookmarksKey, value);
  Future<bool> switchBookmark(
    String value, {
    required bool isBookmarked,
  }) async =>
      isBookmarked ? await removeBookmark(value) : await saveBookmark(value);
}
