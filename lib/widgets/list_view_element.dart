import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/builder_helper.dart";

class ListViewElement<T> extends StatefulWidget {
  const ListViewElement({
    required this.builderHelper,
    required this.data,
    required this.isEven,

    super.key,
  });
  final BuilderHelper<T> builderHelper;
  final T data;
  final bool isEven;
  @override
  State<ListViewElement<T>> createState() => _ListViewElementState<T>();
}

class _ListViewElementState<T> extends State<ListViewElement<T>> {
  var _isHovered = false;
  late final _bh = widget.builderHelper;
  late final _e = widget.data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () => _bh.onTap(_e),
        borderRadius: BorderRadius.circular(10),
        onHover: (x) => setState(() => _isHovered = x),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              stops: const [0, .5, 1],
              colors: [
                if (_isHovered) Colors.red else Colors.transparent,
                Colors.transparent,
                if (_isHovered) Colors.blue else Colors.transparent,
              ],
              begin: widget.isEven ? Alignment.topRight : Alignment.bottomLeft,
              end: widget.isEven ? Alignment.bottomLeft : Alignment.topRight,
            ),
          ),
          padding: EdgeInsets.all(_isHovered ? 10 : 0),
          child: Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xEE121212),
            ),
            child: Row(
              children: [
                _bh.icon(_e),
                const SizedBox(width: 30),
                Text("${_bh.title(_e)}\n${_bh.subTitle(_e)}"),
                const Spacer(),
                _bh.favIcon(_e),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
