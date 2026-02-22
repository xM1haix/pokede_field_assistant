class FavIconHelper<T> {
  const FavIconHelper({required this.isFav, required this.onFavTap});
  final bool Function(T) isFav;
  final void Function(T) onFavTap;
}
