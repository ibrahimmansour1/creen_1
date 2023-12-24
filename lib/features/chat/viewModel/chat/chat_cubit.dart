import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/core/utils/widgets/text_button.dart';
import 'package:creen/features/chat/viewModel/allConversations/all_conversations_cubit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_audio_recorder3/flutter_audio_recorder3.dart';

import 'package:creen/features/chat/repo/send_message_repo.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;

// import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

// import 'package:whatsapp_camera/camera/camera_whatsapp.dart';
import '../../../../core/utils/permission_handler.dart';
import '../../model/all_chats_model.dart';
import '../../repo/all_chats_repo.dart';
import '../../repo/chat_repo.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.isGroup,
    required this.conversationId,
    this.recieverId,
  }) : super(ChatInitial()) {
    log('constructer invoked');
    if (conversationId != null || recieverId != null) {
      initTimer();
    }
    _initializedRecorder();
    sendMessageController.addListener(_onTypeChanged);
  }

  FocusNode focusNode = FocusNode();

 static ChatCubit get(context) => BlocProvider.of(context);
  final int? recieverId;
  int? conversationId;
  final bool isGroup;
  FlutterAudioRecorder3? _recorder;
  bool _canRecord = true;
  RecordingStatus recordStatus = RecordingStatus.Unset;
  int? messageID;

  List<bool> selected = [];

  File? _pickedFile;
  File? _pickedPdfFile;

  File? get pickedFile => _pickedFile;

  File? get pickedPdfFile => _pickedPdfFile;

  bool get canRecord => _canRecord;

  List<Message>? _messages = [];

  List<Message> get messages => [...?_messages?.reversed.toList()];
  Recieverm? _user;

  Recieverm? get user => _user;

  Recieverm? _recieverm;

  Recieverm? get recieverm => _recieverm;

  List<String> get chatSentImages => _messages!
      .where((element) => element.image != null)
      .map(
        (e) => e.image.toString(),
      )
      .toList();
  bool edited = false;

  int imageIndex({required String? image}) =>
      chatSentImages.indexWhere((element) => element == image);

  TextEditingController sendMessageController = TextEditingController();

  // Future<bool> isAudioPermissionGranted() async =>
  //     await _localUsecases.isAudioPermissionGranted();
  Timer? _timer;

  void initTimer() {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      getChatsByRecieverId(
        // conversationId: conversationId,
        showLoader: false,
      );
      _timer = timer;
    });
  }

  Future<void> getChatsByRecieverId({
    // required int? conversationId,
    bool showLoader = true,
  }) async {
    if (recieverId == null) {
      return;
    }
    if (showLoader) {
      emit(ChatLoading());
    }

    try {
      var chatsData;
      await AllChatsRepo.getAllChats(
        recieverId: recieverId,
        conversationId: conversationId,
      ).then((value) {
        chatsData = value;
        if (chatsData == null) {
          emit(ChatError());
          return;
        }
        if (chatsData.status == true) {
          var messages2 = chatsData.data?.messages;
          print("messages2           =========> ${messages2}\n\n\n\n\n");
          _messages = messages2;
          _user = chatsData.data?.user;
          var recieverm2 = chatsData.data?.recieverm;
          _recieverm = recieverm2;
          _messages = chatsData.data?.messages;
          log('message ${_messages?.length};');
        }
        emit(ChatDone(messages: _messages ?? []));
      });
    } catch (r) {
      emit(ChatError());
    }
  }

  Future<void> senMessage({String? recordPath, String? pdfPath}) async {
    try {
      Map<String, dynamic> body2 = {
        if (edited) ...{
          'message_id': messageID,
        } else
          (isGroup ? 'chat_id' : 'reciever_id'): recieverId,
        'text': sendMessageController.text,
        if (_pickedFile != null) ...{
          'image': await MultipartFile.fromFile(_pickedFile!.path),
        },
        if (recordPath != null) ...{
          'record': await MultipartFile.fromFile(recordPath),
        },
        if (pdfPath != null) ...{
          'pdf': await MultipartFile.fromFile(pdfPath),
        },
      };
      sendMessageController.clear();
      _pickedFile = null;
      emit(SendLoading());

      var chatsData;
      print("edited =======> ${edited}");
      if (edited) {
        edited = false;
        print("edited message ${{
          'message_id': messageID,
          'text': sendMessageController.text,
          if (_pickedFile != null) ...{
            'image': await MultipartFile.fromFile(_pickedFile!.path),
          },
          if (recordPath != null) ...{
            'record': await MultipartFile.fromFile(recordPath),
          },
          if (pdfPath != null) ...{
            'pdf': await MultipartFile.fromFile(pdfPath),
          },
        }}");
        await SendMessageRepo.sendMessage(
          body: body2,
          isGroup: isGroup,
          edtied: true,
        ).then((value) {
          chatsData = value;
          if (chatsData == null) {
            emit(ChatError());
            return;
          }
          if (chatsData.status == true) {
            // _messages?.add(chatsData.data!.messages!.last);
            var messages2 = chatsData.data?.messages;
            _messages = messages2;
            _user = chatsData.data?.user;
            var recieverm2 = chatsData.data?.recieverm;
            _recieverm = recieverm2;
            log('messageFROMCUBIT $messages2 $recieverm2');
            if (conversationId == null && recieverId == null) {
              conversationId = messages.first.chatId;
              initTimer();
            }
            // FlutterRingtonePlayer.play(
            //   // android: AndroidSounds.notification,
            //   fromAsset: 'assets/audio/recieve_messaage.wav',
            //   asAlarm: true,
            //   // looping: true, // Android only - API >= 28
            //   // volume: 10, // Android only - API >= 28
            //   // asAlarm: false, // Android only - all APIs
            // );
            emit(ChatDone(messages: _messages ?? []));

            var audioPlayer = AudioPlayer();
            audioPlayer.positionStream.listen((event) {
              log('event is $event');
            });
            audioPlayer
                .setAsset('audio/recieve_messaage.mp3')
                .then((value) => audioPlayer.play());

            // AudioPlayer()..setAsset('assets/audio/recieve_messaage.mp3')
            // ..play();

            // FlutterRingtonePlayer.playNotification();
            //.then((value) {
            //   log('done');
            // }).onError((error, stackTrace) {
            //   log('errror $error');
            // });
            // log('errror .');
          } else {
            emit(ChatDone(messages: _messages ?? []));
          }
        });
      } else {
        await SendMessageRepo.sendMessage(
          body: body2,
          isGroup: isGroup,
        ).then((value) {
          chatsData = value;
          if (chatsData == null) {
            emit(ChatError());
            return;
          }
          if (chatsData.status == true) {
            // _messages?.add(chatsData.data!.messages!.last);
            var messages2 = chatsData.data?.messages;
            _messages = messages2;
            _user = chatsData.data?.user;
            var recieverm2 = chatsData.data?.recieverm;
            _recieverm = recieverm2;
            log('messageFROMCUBIT $messages2 $recieverm2');
            if (conversationId == null && recieverId == null) {
              conversationId = messages.first.chatId;
              initTimer();
            }
            // FlutterRingtonePlayer.play(
            //   // android: AndroidSounds.notification,
            //   fromAsset: 'assets/audio/recieve_messaage.wav',
            //   asAlarm: true,
            //   // looping: true, // Android only - API >= 28
            //   // volume: 10, // Android only - API >= 28
            //   // asAlarm: false, // Android only - all APIs
            // );
            emit(ChatDone(messages: _messages ?? []));

            var audioPlayer = AudioPlayer();
            audioPlayer.positionStream.listen((event) {
              log('event is $event');
            });
            audioPlayer
                .setAsset('audio/recieve_messaage.mp3')
                .then((value) => audioPlayer.play());

            // AudioPlayer()..setAsset('assets/audio/recieve_messaage.mp3')
            // ..play();

            // FlutterRingtonePlayer.playNotification();
            //.then((value) {
            //   log('done');
            // }).onError((error, stackTrace) {
            //   log('errror $error');
            // });
            // log('errror .');
          } else {
            emit(ChatDone(messages: _messages ?? []));
          }
        });
      }
    } catch (r) {
      emit(ChatError());
    }
  }

  Future<void> deleteMessage({required int id,bool message = true}) async {
    await ChatRepo.deleteChatMessage(messageId: id,message:message );
  }

  Future<void> blockAccount({required int id}) async {
    // await ChatRepo.deleteChatMessage(messageId: id);
  }

  Future<void> updateMessage(
      {required int receiverId,
      String? text,
      dynamic image,
      dynamic record,
      dynamic pdf,
      dynamic video,
      String? message_id}) async {
    await ChatRepo.editChatMessage(
      receiverId: receiverId,
      text: text,
      image: image,
      record: record,
      pdf: pdf,
      video: video,
      message_id: message_id,
    )
        .then((value) => print(
            "update message response titled: $text   ====> successfull /*value*/"))
        .catchError((e) =>
            print("update message response titled: $text   ====> failed $e"));
  }

  @override
  Future<void> close() {
    sendMessageController.dispose();
    _timer?.cancel();

    return super.close();
  }

  void pickFile({required BuildContext context}) async {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const WhatsappCamera(
    //       multiple: false,
    //     ),
    //   ),
    // ).then((value) {
    //   if (value != null) {
    //     _pickedFile = value[0];
    //     _canRecord = false;
    //     emit(FileStateChanged(
    //       file: pickedFile,
    //     ));
    //   }
    // });
  }

  void pickPdfFile({required BuildContext context}) async {
    var pickFiles = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: [
        'pdf',
      ],
    );
    if (pickFiles == null || pickFiles.files.isEmpty) {
      return;
    }
    _pickedPdfFile = File(pickFiles.files.first.path ?? '');
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: this,
        child: ConfirmSendDialog(
          onConfirm: () {
            senMessage(
              pdfPath: _pickedPdfFile?.path,
            );
          },
          onCancel: () {
            _pickedPdfFile = null;
          },
        ),
      ),
    );
  }

  /// Initializing the recorder if not initialzed
  Future<void> _initializedRecorder() async {
    var recordingPath = '/sencorder_';
    Directory? appDocDirectory;
    if (Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    } else {
      appDocDirectory = await getExternalStorageDirectory();
    }
    recordingPath = (appDocDirectory?.path ?? '') +
        recordingPath +
        DateTime.now().millisecondsSinceEpoch.toString();
    _recorder = FlutterAudioRecorder3(
      recordingPath,
      audioFormat: AudioFormat.WAV,
    );
    log('initialized');
    await _recorder?.initialized;
  }

  /// Cancel the recoring
  void cancelRecording(PointerMoveEvent event) async {
    if (event.position.dx < (ScreenUtil().screenWidth / 1.5)) {
      if (_recorder != null) {
        await _recorder?.stop();
      }
      updateRecordingStatus(RecordingStatus.Stopped);
      // if (event != null ) {
      //   }
    }
  }

  /// Update the recording status with [currentStatus]
  void updateRecordingStatus(RecordingStatus currentStatus) {
    recordStatus = currentStatus;
    emit(RecordStatusStateChanged(recordStatus: recordStatus));
  }

  /// Start the recorder
  void startRecorder() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (await PermissionHandler.isAllowedToRecord()) {
      await _initializedRecorder();
      // if (await _homePresenter.isAudioPermissionGranted()) {
      _pauseAllRecordings();
      await _recorder?.start();
      updateRecordingStatus(RecordingStatus.Recording);
      // }
    }
  }

  /// End the current recording. And if there is any recording then save it
  void endRecorder(DraggableDetails details) async {
    log('ended');
    if (recordStatus == RecordingStatus.Recording) {
      var result = await _recorder?.stop();
      // var recordings = <dynamic>[];
      result?.path;
      log('result is result ${result?.path}');
      if (result != null) {
        senMessage(recordPath: result.path);
      }
      // var saveRecordings = _homePresenter.getRecodingList() ?? recordings;
      // recordings.addAll(saveRecordings);
      // if (recordings != null) {
      //   recordings.add(
      //     <String, String>{
      //       result.path: result.duration.inSeconds.toString(),
      //     },
      //   );
      //   _homePresenter.saveRecordings(recordings);
      // }
      updateRecordingStatus(RecordingStatus.Stopped);
      // _getListOfRecordings();
    }
  }

  /// Pause all the recordings
  void _pauseAllRecordings() async {
    // await audioPlayer.stop();
    // for (var recording in savedRecordings) {
    //   if (recording.isPlaying) {
    //     recording.isPlaying = false;
    //   }
    // }
    // update();
  }

  void removePickedImage() {
    _pickedFile = null;
    emit(FileStateChanged(file: _pickedFile));
  }

  void _onTypeChanged() {
    if ((_canRecord && sendMessageController.text.isNotEmpty) ||
        (!_canRecord && sendMessageController.text.isEmpty)) {
      _canRecord = !_canRecord;
      emit(CanRecordStateChanged(canRecord: _canRecord));
    }
  }

  void initLink({required BuildContext context}) {
    var allConversationsCubit = context.read<AllConversationsCubit>();
    var link = allConversationsCubit.link;
    if (link != null) {
      sendMessageController.text = link;
    }
  }
}

class ConfirmSendDialog extends StatelessWidget {
  const ConfirmSendDialog({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);
  final void Function() onConfirm;
  final void Function() onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Send PDF',
      ),
      content: const Text(
        'Do You Want To Send Pdf File?',
      ),
      actions: [
        CustomTextButton(
          backgroundColor: Theme.of(context).primaryColor,
          title: 'Ok',
          function: onConfirm,
        ),
        CustomTextButton(
          backgroundColor: Colors.red,
          title: 'Cancel',
          function: onCancel,
        )
      ],
    );
  }
}
