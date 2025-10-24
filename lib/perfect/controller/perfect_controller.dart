import '../model/perfect_model.dart';

class PerfectController {
  PerfectNumber? checkNumber(int number) {
    if (number <= 0) {
      return null;
    }

    return PerfectNumber(number: number);
  }
}
