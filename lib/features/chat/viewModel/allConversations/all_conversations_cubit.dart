import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/features/chat/repo/create_new_team_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/all_conversations_model.dart';
import '../../repo/all_conversations_repo.dart';

part 'all_conversations_state.dart';

class AllConversationsCubit extends Cubit<AllConversationsState> {
  AllConversationsCubit({
    this.link,
  }) : super(AllConversationsInitial());
  final String? link;
  List<Conversation>? _conversations = [];
  var _page = 1;
  var _hasNext = false;
  List<Conversation> get conversations => [
        ...?_conversations
        // ?.where(
        //     (element) => element.userId != HelperFunctions.currentUser?.id)
        // .toList()
      ];
  var scrollController = ScrollController();

  void initScroller() => scrollController.addListener(_onScroll);

  void _onScroll() {
    if (_hasNext &&
        scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      getAllConversations();
    }
  }

  Future<void> getAllConversations({
    bool init = false,
  }) async {
    if (init) {
      _page = 1;
      _hasNext = false;
      _conversations?.clear();
    }
    emit(_page > 1 ? AllConversationsLoadingMore() : AllConversationsLoading());

    try {
      AllConversationsModel? allConversationsData ;
           AllConversationsRepo.getAllConversations(page: _page).then((value) {
             allConversationsData = value;
             if (allConversationsData == null) {
               emit(AllConversationsError());
               return;
             }
             if (allConversationsData!.status == true) {
               if (_page > 1) {
                 _conversations
                     ?.addAll(allConversationsData!.data!.chats!.data!.map((e) => e));
               } else {
                 _conversations = allConversationsData!.data?.chats?.data;
               }
               _hasNext = allConversationsData!.data?.chats?.nextPageUrl != null;
               if (_hasNext) {
                 _page++;
               }
             }
             emit(AllConversationsDone());

           });


    } catch (e) {
      emit(AllConversationsError());
    }
  }

  Future<void> createNewTeam({required Map<String, dynamic> body}) async {
    emit(CreateTeamLoading());
    try {
      var createNewTeamData = await CreateNewTeamRepo.createNewTeam(body: body);
      if (createNewTeamData == null) {
        emit(AllConversationsError());
        return;
      }
      if (createNewTeamData.status == true) {
        emit(CreateTeamDone());
      } else {
        Fluttertoast.showToast(
          msg: createNewTeamData.message ?? '',
          backgroundColor: Colors.red,
        );
      }
      emit(AllConversationsError());
    } catch (e) {
      emit(AllConversationsError());
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
