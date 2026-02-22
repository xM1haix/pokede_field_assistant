import "package:flutter/widgets.dart";
import "package:pokede_field_assistant/classes/fav_icon_helper.dart";
import "package:pokede_field_assistant/widgets/fav_icon.dart";

class BuilderHelper<T> {
  BuilderHelper({
    required this.onTap,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.favIconHelper,
  });
  final String Function(T) title;
  final String Function(T) subTitle;
  final void Function(T) onTap;
  final Widget Function(T) icon;
  final FavIconHelper<T>? favIconHelper;
  Widget favIcon(T data) {
    if (favIconHelper == null) {
      return const SizedBox.shrink();
    }
    return FavIcon(
      isFav: favIconHelper!.isFav(data),
      onTap: () => favIconHelper!.onFavTap(data),
    );
  }
}
