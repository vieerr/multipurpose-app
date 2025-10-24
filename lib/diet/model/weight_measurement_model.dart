class WeightMeasurementModel {
  int id;
  DateTime date;
  List<double> weights;
  double averageWeight;
  double? difference;
  String? state;

  WeightMeasurementModel({
    required this.id,
    required this.date,
    required this.weights,
    required this.averageWeight,
    this.difference,
    this.state,
  });

}