import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:pokede_field_assistant/others/popup.dart";

class Coords {
  Coords(this.longitude, this.latitude);
  double longitude;
  double latitude;
  void reset(Coords coords) {
    latitude = coords.latitude;
    longitude = coords.longitude;
  }

  static Future<Coords> popupCoords(
    BuildContext context, [
    Coords? oldValues,
  ]) async {
    final latCtrl = TextEditingController(text: "${oldValues?.latitude}");
    final lonCtrl = TextEditingController(text: "${oldValues?.longitude}");
    final latFN = FocusNode();
    final lonFN = FocusNode();
    latFN.requestFocus();
    await popup(
      context,
      "Set the coords",
      actions: [PopupAction("Cancel!", false), PopupAction("Create!", true)],
      content: StatefulBuilder(
        builder: (context, setState) => SizedBox(
          height: 100,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,

                  focusNode: latFN,
                  controller: latCtrl,
                  decoration: const InputDecoration(
                    hintText:
                        "Insert the value for latitude, default value is 0",
                  ),
                ),
                TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,

                  focusNode: lonFN,
                  controller: lonCtrl,
                  decoration: const InputDecoration(
                    hintText:
                        "Insert the value for longitude, default value is 0",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return Coords(
      double.tryParse(lonCtrl.text) ?? 0,
      double.tryParse(latCtrl.text) ?? 0,
    );
  }
}
