extension TranslateCategoryExtension on String {
  String translateCategory() {
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
      case "gift":
        return "regalo";
      case "home":
        return "casa";
      case "clothing":
        return "abbigliamento";
      case "salary":
        return "stipendio";
      case "sale":
        return "vendita";
      case "loan":
        return "prestito";
      default:
        return "altro";
    }
  }
}
