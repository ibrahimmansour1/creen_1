import '../../../features/localization/manager/app_localization.dart';

extension StringExtension on String {
  String get translate => localization.text(this);
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String get toTitleCase => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
  bool get isLink {
    final matcher = RegExp(
        r"(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)");
    return matcher.hasMatch(this);
  }

  List<String> get linkFromText {
    RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Iterable<RegExpMatch> matches = exp.allMatches(this);
    List<String> links = [];
    for (var i = 0; i < matches.length; i++) {
      var match = matches.toList()[i];
      links.add(substring(match.start, match.end));
    }
    return links;
  }
}
