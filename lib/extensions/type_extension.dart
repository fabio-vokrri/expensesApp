import 'package:expenses/data/models/expense_model.dart';

extension StringToTypeExtension on String {
  Type toType() {
    if (this == "gain") return Type.gain;
    return Type.loss;
  }
}
