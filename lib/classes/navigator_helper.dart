class NavigatorHelper {
  NavigatorHelper({
    required this.currentPage,
    required this.numOfPages,
    required this.navigateToPage,
    required this.numOnPage,
    required this.changeTheNumOnPage,
  });
  final int currentPage;
  final int numOnPage;
  final int numOfPages;
  final void Function(int newPage) navigateToPage;
  final void Function(int newValue) changeTheNumOnPage;
}
