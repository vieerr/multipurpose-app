import 'package:flutter/material.dart';
import '../model/weight_measurement_model.dart';
import '../model/person_model.dart';
import '../utils/sample_data.dart';

class PersonController with ChangeNotifier{
  List<PersonModel> _persons = [];
  int _nextPersonId = 1;

  PersonController(){
    _loadSampleData();
  }
  void _loadSampleData() {
    _persons = SampleData.getSamplePersons();
    if (_persons.isNotEmpty) {
      _nextPersonId = _persons.map((p) => p.id).reduce((a, b) => a > b ? a : b) + 1;
    }
    notifyListeners();
  }

  //----------------Auxiliares--------------------------------
  List<PersonModel> get persons => _persons;

  PersonModel? getPersonById(int personId){
    try{
      return _persons.firstWhere((person) => person.id == personId);
    }catch(e){
      return null;
    }
  }

  PersonModel _getPersonById(int personId) {
    final person = getPersonById(personId);
    if (person == null) {
      throw Exception('Persona con ID $personId no encontrada');
    }
    return person;
  }
  bool hasMeasurements(int personId){
    final person = _getPersonById(personId);
    return !person.isFirstMeasurement;
  }

  //------------Metodos para agregar persona-----------------------
  PersonModel addPerson(String name, double initialWeight){
    final person = PersonModel(
      id: _nextPersonId++,
      name: name,
      initialWeight: initialWeight,
      measurements: [],
    );
    _persons.add(person);
    notifyListeners();
    return person;
  }

  void addFirsMeasurement(int personId, List<double> weights){
    final person = _getPersonById(personId);
    if(!person.isFirstMeasurement){
      throw Exception("Esta persona ya tiene mediciones");
    }
    person.addFirstMeasurement(weights);
    notifyListeners();
  }

  void addAnotherMeasurement(int personId, List<double> weights){
    final person = _getPersonById(personId);
    if(person.isFirstMeasurement){
      throw Exception("Esta persona no tiene una primera medicion");
    }
  }

  void addMeasurement(int personId, List<double> weights){
    final person = _getPersonById(personId);
    if(person.isFirstMeasurement){
      person.addFirstMeasurement(weights);
    }else{
      person.addMoreMeasurement(weights);
    }
    notifyListeners();
  }


  //---------------------Visualizaciones-----------------------
  List<Map<String,dynamic>> getPersonSummary(){
    return _persons.map((person){
      final summary = person.getInfoTable();
      return{
        'id':person.id,
        'name': person.name,
        'currentWeight': summary['actualWeight'],
        'lastDifference': summary['lastDifference'],
        'lastState': summary['lastState'],
        'hasMeasurements': summary['hasMeasurements'],
      };
    }).toList();
  }

  List<WeightMeasurementModel> getPersonMeasurements(int personId){
    final person = _getPersonById(personId);
    if(person.measurements.isNotEmpty){
      return person.measurements;
    }else{
      return [];
    }
  }
  //--------------------Formularios-------------------------------
  Map<String, dynamic> getMeasurementFormInfo(int personId) {
    final person = getPersonById(personId);
    if (person == null) {
      return {'needsInitialWeight': false, 'comparisonWeight': 0.0};
    }

    if (person.isFirstMeasurement) {
      return {
        'needsInitialWeight': false,
        'comparisonWeight': person.initialWeight,
        'comparisonType': 'Peso inicial',
      };
    } else {
      return {
        'needsInitialWeight': false,
        'comparisonWeight': person.lastMeasurement!.averageWeight,
        'comparisonType': 'Ultima medicion',
      };
    }
  }

}