extension TranslateTypeExtension on String {
  String translateType() {
    if (this == "gain") return "guadagno";
    return "perdita";
  }
}
