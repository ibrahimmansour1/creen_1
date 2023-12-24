part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class SendLoading extends ChatState {}

class RecordStatusStateChanged extends ChatState {
  const RecordStatusStateChanged({required this.recordStatus});

  final RecordingStatus recordStatus;

  @override
  List<Object?> get props => [recordStatus];
}

class CanRecordStateChanged extends ChatState {
  const CanRecordStateChanged({required this.canRecord});

  final bool canRecord;

  @override
  List<Object?> get props => [canRecord];
}

class FileStateChanged extends ChatState {
  const FileStateChanged({required this.file});
  final File? file;
  @override
  List<Object?> get props => [
        file,
      ];
}

class ChatDone extends ChatState {
  const ChatDone({required this.messages});
  final List<Message> messages;

  @override
  List<Object?> get props => [messages];
}

class ChatError extends ChatState {}
class ChatMessageEdit extends ChatState {}
