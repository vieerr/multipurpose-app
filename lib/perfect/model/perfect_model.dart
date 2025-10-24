class PerfectNumber {
  final int number;
  late final bool isPerfect;
  late final List<int> divisors;

  PerfectNumber({required this.number}) {
    _calculateDivisors();
    _checkIfPerfect();
  }

  void _calculateDivisors() {
    divisors = [];
    for (int i = 1; i * i <= number; i++) {
      if (number % i == 0) {
        if (i < number) {
          divisors.add(i);
        }
        int other = number ~/ i;
        if (other != i && other < number) {
          divisors.add(other);
        }
      }
    }
    divisors.sort();
  }

  void _checkIfPerfect() {
    int sum = divisors.fold(0, (prev, curr) => prev + curr);
    isPerfect = sum == number;
  }

  int getDivisorsSum() {
    return divisors.fold(0, (prev, curr) => prev + curr);
  }

  String getDivisorsAsString() {
    return divisors.join(" + ");
  }
}
