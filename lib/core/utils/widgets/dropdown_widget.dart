import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import '../../themes/screen_utitlity.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    Key? key,
    required this.values,
    required this.labelText,
    required this.onChanged,
    this.selectedValueIndex,
    this.leadingIcons,
    this.validator,
    this.textAlignment,
    this.removePadding = false,
    this.thinBorder = true,
  }) : super(key: key);
  final int? selectedValueIndex;
  final List<String?> values;
  final List<String?>? leadingIcons;
  final String? Function(int?)? validator;
  final void Function(int?)? onChanged;
  final String labelText;
  final bool thinBorder;
  final bool removePadding;
  final Alignment? textAlignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: removePadding
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: DropdownButtonFormField(
        validator: validator,
        isExpanded: true,
        items: List.generate(
          values.length,
          (index) => DropdownMenuItem(
            value: index,
            child: Align(
              alignment: textAlignment ?? HelperFunctions.appAlignment,
              child: Text(
                values[index]!,
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          // color:
          //     thinBorder ? MainStyle.lightGreyColor : MainStyle.darkGreyColor,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          fillColor: Colors.white,
          filled: true,
          hintText: labelText.translate,
          labelStyle: TextStyle(
            color:
                thinBorder ? MainStyle.lightGreyColor : MainStyle.darkGreyColor,
          ),
          helperStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color:
                thinBorder ? MainStyle.lightGreyColor : MainStyle.darkGreyColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(thinBorder ? 12 : 25),
            borderSide: BorderSide(
              width: thinBorder ? 1 : 2,
              color: thinBorder
                  ? MainStyle.lightGreyColor
                  : MainStyle.darkGreyColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(thinBorder ? 12 : 25),
            borderSide: BorderSide(
              width: thinBorder ? 1 : 2,
              color: thinBorder
                  ? MainStyle.lightGreyColor
                  : MainStyle.darkGreyColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(thinBorder ? 12 : 25),
            borderSide: BorderSide(
              width: thinBorder ? 1 : 2,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        value: selectedValueIndex,
        onChanged: onChanged,
      ),
    );
  }
}
