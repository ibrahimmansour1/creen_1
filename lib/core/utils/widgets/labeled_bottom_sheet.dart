import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;


class LabeledBottomSheet extends StatefulWidget {
  final List? data;
  final ValueChanged? onChange;
  final String? label;
  final bool? ontap;
  final bool? serviceCtegory;

  const LabeledBottomSheet({
    Key? key,
    this.data,
    this.onChange,
    this.label,
    @required this.serviceCtegory,
    this.ontap,
  }) : super(key: key);

  @override
  _LabeledBottomSheetState createState() => _LabeledBottomSheetState();
}

class _LabeledBottomSheetState extends State<LabeledBottomSheet> {
  String? _title;

  @override
  void initState() {
    super.initState();
    _title = widget.label;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: SizedBox(
        width: Sizes.screenWidth() * 0.9,
        child: InkWell(
          onTap: () {
            if (widget.ontap == null || widget.ontap == true) {
              showModalBottomSheet(
                  backgroundColor: Colors.black12,
                  context: context,
                  builder: (_) {
                    return Container(
                      height: 350,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          color: Colors.white),
                      child: widget.data!.isEmpty
                          ? const Center(
                              child: Text("noResults"),
                            )
                          : ListView.builder(
                              itemCount: widget.data!.length,
                              itemBuilder: (_, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          setState(() {
                                            _title =  widget.data![index].name;
                                            widget.onChange!(
                                              widget.data![index].id.toString(),
                                            );
                                          });
                                        },
                                        child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: widget.serviceCtegory!
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        height: Sizes.screenHeight() *
                                                            0.1,
                                                        child: ListView.builder(
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            itemCount: widget
                                                                .data![index]
                                                                .images
                                                                .length,
                                                            itemBuilder:
                                                                (context, i) {
                                                              return FadeInImage
                                                                  .assetNetwork(
                                                                height: Sizes.screenHeight() *
                                                                    0.1,
                                                                width: Sizes.screenWidth() *
                                                                    0.1,
                                                                image: widget
                                                                    .data![index]
                                                                    .images[i]
                                                                    .link,
                                                                imageCacheHeight:
                                                                    500,
                                                                imageCacheWidth:
                                                                    500,
                                                                placeholder:
                                                                    'assets/images/ic_launcher.png',
                                                              );
                                                            }),
                                                      ),
                                                      Text(( widget
                                                                  .data![index]
                                                                  .name) ??
                                                          ""),
                                                    ],
                                                  )
                                                : Text((widget.data![index]
                                                            .name) ??
                                                    "")),
                                      ),
                                    ),
                                    const Divider(
                                      indent: 10.0,
                                      endIndent: 10.0,
                                    ),
                                  ],
                                );
                              },
                            ),
                    );
                  });
            } else {
              
            }
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white)),
            padding: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Icon(Icons.arrow_drop_down),
                  Text(_title!.length > 25 ? _title!.substring(0, 20) : _title!)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomSheetModel {
  int? id;
  String? name;
  String? realID;
  String? lat;
  String? long;

  BottomSheetModel({
    this.id,
    this.name,
    this.realID,
    this.lat,
    this.long,
  });
}
