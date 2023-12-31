import 'package:creen/core/utils/extensions/string.dart';
import 'package:flutter/material.dart';

class MainStartLiveSelectItem extends StatelessWidget {
  const MainStartLiveSelectItem({super.key, required this.selectIcon, required this.selectLabel, required this.selectTap});
final IconData selectIcon;
final String selectLabel;
final void Function() selectTap;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: selectTap,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration:  BoxDecoration(
              border: Border.all(color: Colors.white),
              shape: BoxShape.circle,

            ),
            child: Icon(selectIcon,size: 50,color: Colors.white,),
          ),
          Text(selectLabel.translate,style: const TextStyle(fontSize: 25,color: Colors.white),),
        ],
      ),
    );
  }
}
