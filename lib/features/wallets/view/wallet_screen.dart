import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/features/wallets/view/widgets/points_view.dart';
import 'package:creen/features/wallets/view/widgets/wallets_view.dart';
import 'package:creen/features/wallets/viewModel/wallets/wallets_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/responsive/sizes.dart';
import '../../../core/utils/widgets/custom_appbar.dart';
import '../viewModel/points/points_cubit.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  // String chargeType = 'whole';

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    context.read<WalletsCubit>()
      ..initListeners()
      ..getWallets();
    context.read<PointsCubit>()
      ..initListeners()
      ..getPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
        child: const CustomAppBar(
          title: 'wallet',
          back: true,
        ),
      ),
      body: Column(
        children: [
          TabBar(
            padding: const EdgeInsets.all(10),
            labelColor: Colors.white,
            indicator: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.black45],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    tileMode: TileMode.clamp)),
            unselectedLabelColor: Colors.black,
            tabs: [
              Text('balance'.translate),
              Text('points'.translate),
            ],
            controller: tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                WalletsView(),
                PointsView(),
              ],
            ),
          )
        ],
      ),
    );
  }
}


// class RadioTile<T> extends StatelessWidget {
//   const RadioTile({
//     Key? key,
//     required this.groupValue,
//     required this.title,
//     required this.onChanged,
//     required this.value,
//   }) : super(key: key);

//   final T groupValue, value;
//   final void Function(T?) onChanged;
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Radio<T>(
//           activeColor: Colors.black,
//           value: value,
//           groupValue: groupValue,
//           onChanged: onChanged,
//         ),
//         Text(title.translate),
//       ],
//     );
//   }
// }

