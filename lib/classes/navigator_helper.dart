class NavigatorHelper {
  NavigatorHelper({
    required this.currentPage,
    required this.numOfPages,
    required this.navigateToPage,
    required this.numOnPage,
    required this.changeTheNumOnPage,
    required this.onSubmitted,
  });
  final int currentPage;
  final int numOnPage;
  final int numOfPages;
  final void Function(int newPage) navigateToPage;
  final void Function(String value) onSubmitted;
  final void Function(int newValue) changeTheNumOnPage;
}
