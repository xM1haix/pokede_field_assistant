import "package:flutter/material.dart";
import "package:pokede_field_assistant/classes/builder_helper.dart";

class GridViewElement<T> extends StatefulWidget {
  const GridViewElement({
    required this.builderHelper,
    required this.data,
    required this.isEven,
    super.key,
  });
  final BuilderHelper<T> builderHelper;
  final T data;
  final bool isEven;
  @override
  State<GridViewElement<T>> createState() => _GridViewElementState<T>();
}

class _GridViewElementState<T> extends State<GridViewElement<T>> {
  var _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () => widget.builderHelper.onTap(widget.data),
        borderRadius: BorderRadius.circular(10),
        onHover: (x) => setState(() => _isHovered = x),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
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
            width: 100,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xEE121212),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: widget.builderHelper.icon(widget.data)),
                const SizedBox(width: 20),
                Text(
                  widget.builderHelper.title(widget.data),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  widget.builderHelper.subTitle(widget.data),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    const Spacer(),
                    widget.builderHelper.favIcon(widget.data),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
