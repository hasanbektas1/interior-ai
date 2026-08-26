enum ExteriorStep {
  addPhoto,
  buildingType,
  style,
  colorPalette,
  processing,
  result,
  error,
}

extension ExteriorStepX on ExteriorStep {
  int get progressIndex => switch (this) {
    ExteriorStep.addPhoto => 0,
    ExteriorStep.buildingType => 1,
    ExteriorStep.style => 2,
    ExteriorStep.colorPalette => 3,
    ExteriorStep.processing => 3,
    ExteriorStep.result => 3,
    ExteriorStep.error => 3,
  };
}
