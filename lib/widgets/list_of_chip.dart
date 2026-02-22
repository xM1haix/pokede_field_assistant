import "package:flutter/material.dart";

class ListOfChip<T> extends StatelessWidget {
  const ListOfChip({
    required this.data,
    required this.builder,
    required this.text,
    super.key,
  });
  final List<T> data;
  final Widget Function(T) builder;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsetsGeometry.only(left: 30),
              child: Text("$text:", style: const TextStyle(color: Colors.blue)),
            ),
          ),
          SizedBox(
            height: 75,
            child: data.isEmpty
                ? Center(child: Text("There are no $text!"))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsetsGeometry.symmetric(
                        horizontal: 10,
                      ),
                      child: builder(data[i]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
