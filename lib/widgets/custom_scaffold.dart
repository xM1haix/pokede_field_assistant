import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/endpoint.dart";

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({required this.body, this.appBar, this.fab, super.key});

  final AppBar? appBar;
  final Widget body;
  final Widget? fab;
  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  late final Future<List<Endpoint>> _future;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: widget.fab,
      appBar: widget.appBar,
      body: widget.body,
      // drawer: Drawer(
      //   child: CustomFutureBuilder(
      //     future: _future,
      //     success: (context, listOfData) {
      //       return CustomListView(
      //         listOfData: listOfData,
      //         builderHelper: BuilderHelper<Endpoint>(
      //           title: (element) => element.name,
      //           icon: (element) => const Icon(Icons.api),
      //           onTap: (element) {},
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }

  @override
  void initState() {
    super.initState();
    _future = Endpoint.getEndpoints();
  }
}
