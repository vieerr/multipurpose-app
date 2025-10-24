import 'weight_measurement_model.dart';
class PersonModel{
  int id;
  String name;
  double initialWeight;
  List<WeightMeasurementModel> measurements;

  //Constructor normal
  PersonModel({
    required this.id,
    required this.name,
    required this.initialWeight,
    required this.measurements,
  });

  //-------------------Funciones Auxiliares---------------------------

  WeightMeasurementModel? get lastMeasurement{
    if(measurements.isEmpty) return null;
    return measurements.last;
  }

  double? get currentWeight => lastMeasurement?.averageWeight;
  bool get isFirstMeasurement => measurements.isEmpty;

  double _getAverage(List<double> weights){
    double total = 0.0;
    if(weights.isEmpty) return total;
    for(int i=0;i<weights.length;i++){
      total += weights[i];
    }
    return total/weights.length;
  }

  void _setStateBasedOnDifference(WeightMeasurementModel measurement) {
    if (measurement.difference! > 0) {
      measurement.state = "SUBIO";
    } else if (measurement.difference! < 0) {
      measurement.state = "BAJO";
    } else {
      measurement.state = "IGUAL";
    }
  }
  //------------NUEVAS MEDIDAS--------------------------------------
  void addFirstMeasurement(List<double> weights){
    final average = _getAverage(weights);
    final newMeasurement = WeightMeasurementModel(
      id: 1,
      date: DateTime.now(),
      weights: weights,
      averageWeight: average,
    );
    newMeasurement.difference = average - initialWeight;
    _setStateBasedOnDifference(newMeasurement);
    measurements.add(newMeasurement);
  }

  void addMoreMeasurement(List<double> weights){
    if(measurements.isEmpty){
      throw Exception('Debe ingresar la primera medicion antes');
    }
    final average = _getAverage(weights);
    final previousAverage =  lastMeasurement!.averageWeight;

    final newMeasurement = WeightMeasurementModel(
        id: measurements.length + 1,
        date: DateTime.now(),
        weights: weights,
        averageWeight: average,
    );
    newMeasurement.difference = average - previousAverage;
    _setStateBasedOnDifference(newMeasurement);
    measurements.add(newMeasurement);
  }

  //------------------Visualizaciones------------------------------
  Map<String, dynamic> getInfoTable(){
    if(measurements.isEmpty){
      return{
        'actualWeight':null,
        'lastDifference': null,
        'lastState': 'Sin Datos',
        'hasMeasurements': false,
      };
    }
    final last = lastMeasurement!;
    return{
      'actualWeight':last.averageWeight,
      'lastDifference': last.difference,
      'lastState': last.state,
      'hasMeasurements': true,
    };
  }
}
