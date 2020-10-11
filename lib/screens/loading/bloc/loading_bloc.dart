import 'package:ipecstudents/data/base_bloc/base_bloc.dart';
import 'package:ipecstudents/data/base_bloc/base_event.dart';
import 'package:ipecstudents/data/base_bloc/base_state.dart';
import 'package:ipecstudents/data/model/GeneralResponse.dart';
import 'package:ipecstudents/data/model/User.dart';
import 'package:ipecstudents/data/repo/auth.dart';
import 'package:ipecstudents/util/SugarParse.dart';

import 'loading_event.dart';
import 'loading_state.dart';

class LoadingBloc extends BaseBloc {
  @override
  BaseState get initialState => LoadingInitState();

  @override
  Stream<BaseState> mapBaseEventToBaseState(BaseEvent event) async* {
    if (event is ResetState) yield LoadingInitState();

    if (event is CheckCredentials) {
      try {
        GeneralResponse response =
            await event.auth.login(event.cred.username, event.cred.password);
        if (response.status) {
          event.auth.user =
              SugarParser().user(response.data.data, event.cred.username);

          yield AuthenticatedState();
        } else {
          // Invalid Cred
          yield LoginFailState();
          await Future.delayed(Duration(seconds: 2));
          yield CloseLoadingState();
        }
      } on Exception catch (e) {
        yield ShowDialogErrorState(e?.toString() ?? "Fatal Error");

        yield CloseLoadingState();
      }
    }
  }
}
