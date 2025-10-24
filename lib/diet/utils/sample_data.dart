import 'package:flutter/material.dart';
import '../model/person_model.dart';
import '../model/weight_measurement_model.dart';

class SampleData {
  static List<PersonModel> getSamplePersons() {
    return [
      PersonModel(
        id: 1,
        name: "María González",
        initialWeight: 68.5,
        measurements: [
          WeightMeasurementModel(
            id: 1,
            date: DateTime(2024, 1, 15),
            weights: [67.8, 67.9, 67.7],
            averageWeight: 67.8,
            difference: -0.7,
            state: "BAJO",
          ),
          WeightMeasurementModel(
            id: 2,
            date: DateTime(2024, 1, 22),
            weights: [67.5, 67.3, 67.6],
            averageWeight: 67.47,
            difference: -0.33,
            state: "BAJO",
          ),
          WeightMeasurementModel(
            id: 3,
            date: DateTime(2024, 1, 29),
            weights: [67.8, 67.9, 68.0],
            averageWeight: 67.9,
            difference: 0.43,
            state: "SUBIO",
          ),
        ],
      ),
      PersonModel(
        id: 2,
        name: "Carlos Rodríguez",
        initialWeight: 82.0,
        measurements: [
          WeightMeasurementModel(
            id: 1,
            date: DateTime(2024, 1, 10),
            weights: [80.5, 80.7, 80.6],
            averageWeight: 80.6,
            difference: -1.4,
            state: "BAJO",
          ),
          WeightMeasurementModel(
            id: 2,
            date: DateTime(2024, 1, 17),
            weights: [80.2, 80.1, 80.3],
            averageWeight: 80.2,
            difference: -0.4,
            state: "BAJO",
          ),
          WeightMeasurementModel(
            id: 3,
            date: DateTime(2024, 1, 24),
            weights: [80.5, 80.6, 80.5],
            averageWeight: 80.53,
            difference: 0.33,
            state: "SUBIO",
          ),
          WeightMeasurementModel(
            id: 4,
            date: DateTime(2024, 1, 31),
            weights: [80.0, 79.9, 80.1],
            averageWeight: 80.0,
            difference: -0.53,
            state: "BAJO",
          ),
        ],
      ),
      PersonModel(
        id: 3,
        name: "Ana Martínez",
        initialWeight: 59.0,
        measurements: [
          WeightMeasurementModel(
            id: 1,
            date: DateTime(2024, 1, 12),
            weights: [58.2, 58.3, 58.1],
            averageWeight: 58.2,
            difference: -0.8,
            state: "BAJO",
          ),
          WeightMeasurementModel(
            id: 2,
            date: DateTime(2024, 1, 19),
            weights: [58.5, 58.6, 58.4],
            averageWeight: 58.5,
            difference: 0.3,
            state: "SUBIO",
          ),
        ],
      ),
    ];
  }
}