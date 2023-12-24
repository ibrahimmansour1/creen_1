part of 'wallets_cubit.dart';

abstract class WalletsState extends Equatable {
  const WalletsState();

  @override
  List<Object> get props => [];
}

class WalletsInitial extends WalletsState {}

class WalletsLoading extends WalletsState {}

class WalletsLoadingMore extends WalletsState {}

class WalletsDone extends WalletsState {}

class WalletsError extends WalletsState {}

class WithdrawMethodStateChanged extends WalletsState {
  const WithdrawMethodStateChanged({
    required this.withdrawType,
  });
  final String withdrawType;

  @override
  List<Object> get props => [
        withdrawType,
      ];
}
