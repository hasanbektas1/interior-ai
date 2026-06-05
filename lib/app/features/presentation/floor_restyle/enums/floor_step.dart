enum FloorStep { addPhoto, paint, material, processing, result, error }

extension FloorStepX on FloorStep {
  int get progressIndex => switch (this) {
        FloorStep.addPhoto => 0,
        FloorStep.paint => 1,
        FloorStep.material => 2,
        FloorStep.processing => 2,
        FloorStep.result => 2,
        FloorStep.error => 2,
      };
}
