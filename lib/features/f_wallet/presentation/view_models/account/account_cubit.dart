
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/constants.dart';
import 'account_states.dart';

class AccountCubit extends Cubit<AccountStates> {
  AccountCubit() : super(AccountInitState());

  static AccountCubit get(context) => BlocProvider.of(context);

  void switchTimer1(bool val) {
    timerSwitch1 = val;
    emit(SwitchState());
  }
  void switchTimer2(bool val) {
    timerSwitch2 = val;
    emit(SwitchState());
  }
  void switchLanguage(int i) {
    if(selectedLang=="ar"&&i==2)
      {
        selectedLang="en";
      }else if(selectedLang=="en"&&i==1)
        {
          selectedLang="ar";
        }
    emit(SwitchLanguageState());
  }
  void switchQuestionColor(bool val,int index) {
    stateColors[index]=val;
    emit(SwitchQuestionColorState());
  }


}
