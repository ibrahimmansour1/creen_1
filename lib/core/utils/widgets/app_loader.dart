import 'package:flutter/material.dart' hide NavigationDrawer;

class AppLoader extends StatefulWidget {
  final String? title;

  const AppLoader({Key? key, this.title}) : super(key: key);
  @override
  _AppLoaderState createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(widget.title ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 17, color: Colors.grey)),
        Container(
          padding: const EdgeInsets.all(50),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    backgroundColor: Theme.of(context).primaryColor,
                    // valueColor: An,
                  ),
                ),
                Image.asset(
                  'assets/images/Group3.png',
                  height: 95,
                  width: 95,
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const SizedBox(height: 20),
      ],
    );
  }
}
