import 'package:creen/core/utils/extensions/string.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/utils/responsive/sizes.dart';

class ProductItem extends StatelessWidget {
  final String? text, content;
  final bool? isMessage;
  final bool? mobile;
  final Widget? widget;
  final void Function(String)? onChanged, onFieldSubmitted;
  final void Function()? onTap;
  final TextEditingController? controller;
  const ProductItem(
      {Key? key,
      this.text,
      this.isMessage,
      this.content,
      this.mobile,
      this.onChanged,
      this.widget,
      this.onTap,
      this.controller,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.only(right: 30.0),
          child: Text(
            text!,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: Sizes.screenWidth() * 0.7,
                padding: const EdgeInsets.only(right: 10, left: 10),
                //margin: const EdgeInsets.fromLTRB(10, 10, 10, 18),
                decoration: BoxDecoration(
                    border: Border.all(color: MainStyle.navigationColor),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: widget ??
                    TextFormField(
                      controller: controller,
                      onChanged: onChanged,
                      onFieldSubmitted: onFieldSubmitted,
                      maxLines: isMessage! ? 10 : 1,
                      minLines: isMessage! ? 4 : 1,
                      textDirection: TextDirection.rtl,
                      cursorColor: Colors.black,
                      keyboardType: mobile == true
                          ? TextInputType.phone
                          : TextInputType.text,
                      textAlign: TextAlign.right,
                      textInputAction: TextInputAction.search,
                      // style: const TextStyle(color: MainStyle.navigationColor),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this field is required";
                        }
                        if (text == 'Email' && !value.contains('@')) {
                          return "not_valid_email".translate;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: content,
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.only(left: 15, bottom: 15, top: 15),
                      ),
                      // initialValue: content,
                    ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: onTap,
                child: Container(
                  width: Sizes.screenWidth() * 0.2,
                  height: Sizes.screenHeight() * 0.08,
                  decoration: BoxDecoration(
                      border: Border.all(color: MainStyle.primaryColor),
                      color: MainStyle.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
