import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/features/wallets/viewModel/wallets/wallets_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/themes.dart';
import '../../../../core/utils/widgets/box_helper.dart';
import '../../../../core/utils/widgets/customized_table.dart';
import '../../../../core/utils/widgets/radio_tile.dart';
import '../../../../core/utils/widgets/register_button.dart';
import '../../../../core/utils/widgets/register_text_field.dart';
import '../../../../core/utils/widgets/table_text.dart';
import 'customized_wallet_card.dart';

class WalletsView extends StatelessWidget {
  const WalletsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var walletCubit = context.read<WalletsCubit>();
    return BlocBuilder<WalletsCubit, WalletsState>(
      builder: (context, state) {
        if (state is WalletsLoading) {
          return const LoaderWidget();
        }
        return SingleChildScrollView(
          controller: walletCubit.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.r),
                child: Text(
                  '${'current_balance'.translate} : ${walletCubit.total?.toStringAsFixed(2) ?? 0} ريال سعودي',
                  style: MainTheme.authTextStyle,
                ),
              ),
              CustomizedWalletCard(
                title: 'charging_wallet',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: [
                        'mada.png',
                        'visa.png',
                        'master_card.png',
                        'stc_pay.png'
                      ]
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.all(
                                5.0.r,
                              ),
                              child: Image.asset(
                                'assets/images/$e',
                                height: 70.r,
                                width: 70.r,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const BoxHelper(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const BoxHelper(
                      height: 10,
                    ),
                    Text(
                      'amount'.translate,
                      style: MainTheme.authTextStyle.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: const RegisterTextField(
                        type: TextInputType.phone,
                        label: 'sr',
                      ),
                    ),
                    const BoxHelper(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const BoxHelper(
                      height: 10,
                    ),
                    BoxHelper(
                      width: 100,
                      child: RegisterButton(
                        radius: 10,
                        title: 'charge',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              CustomizedWalletCard(
                title: 'balance_withdrawal',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'choose_withdrawal_method'.translate,
                      style: MainTheme.authTextStyle.copyWith(
                        fontSize: 14.r,
                      ),
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                RadioTile<String>(
                                  groupValue: walletCubit.chargeType,
                                  value: 'whole',
                                  title: 'whole_amount',
                                  onChanged:
                                      walletCubit.onWithdrawMethodChanged,
                                ),
                                RadioTile<String>(
                                  groupValue: walletCubit.chargeType,
                                  value: 'part',
                                  title: 'part_amount',
                                  onChanged:
                                      walletCubit.onWithdrawMethodChanged,
                                ),
                              ],
                            ),
                            Visibility(
                              visible: walletCubit.chargeType == 'part',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'amount'.translate,
                                    style: MainTheme.authTextStyle.copyWith(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0.r),
                                    child: const RegisterTextField(
                                      type: TextInputType.phone,
                                      label: 'sr',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const BoxHelper(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const BoxHelper(
                      height: 10,
                    ),
                    BoxHelper(
                      width: 100,
                      child: RegisterButton(
                        radius: 10,
                        title: 'withdraw',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${'transfer_gift_balance'.translate} ${walletCubit.walletFromPoint} ${'sr'.translate}',
                      style: MainTheme.authTextStyle,
                    ),
                    const BoxHelper(
                      height: 20,
                    ),
                    Text(
                      '${'gift_balance_sent'.translate} ${walletCubit.walletFromGift} ${'sr'.translate}',
                      style: MainTheme.authTextStyle,
                    ),
                    const BoxHelper(
                      height: 40,
                    ),
                    Text(
                      '${'total_balance'.translate} ${walletCubit.total} ${'sr'.translate}',
                      style: MainTheme.authTextStyle,
                    ),
                    const BoxHelper(
                      height: 20,
                    ),
                    CustomizedTable(
                      columnWidths: const {
                        0: FlexColumnWidth(),
                        1: FlexColumnWidth(),
                      },
                      tableRow: [
                         TableRow(children: [
                          TableText(
                            title: 'amount'.translate,
                            fontWeight: FontWeight.bold,
                          ),
                          TableText(
                            title: 'details'.translate,
                            fontWeight: FontWeight.bold,
                          ),
                        ]),
                        ...List.generate(
                          walletCubit.wallets.length,
                          (index) {
                            var wallet = walletCubit.wallets[index];

                            return TableRow(children: [
                              TableText(
                                title:
                                    wallet.balance?.toStringAsFixed(2) ?? '0',
                              ),
                              TableText(
                                title: wallet.description ?? '',
                              ),
                            ]);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const BoxHelper(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
