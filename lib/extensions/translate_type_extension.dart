extension TranslateType on String {
  String translateType() {
    switch (this) {
      case "grocery":
        return "alimentare";
      case "transportation":
        return "trasporto";
      case "entertainment":
        return "intrattenimento";
      case "education":
        return "educazione";
      case "health":
        return "salute";
      default:
        return "altro";
    }
  }
}
