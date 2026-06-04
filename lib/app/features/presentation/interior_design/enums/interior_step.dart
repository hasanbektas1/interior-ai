enum InteriorStep {
  addPhoto,
  roomType,
  style,
  colorPalette,
  processing,
  result,
  error,
}

extension InteriorStepX on InteriorStep {
  bool get isWizard =>
      this == InteriorStep.addPhoto ||
      this == InteriorStep.roomType ||
      this == InteriorStep.style ||
      this == InteriorStep.colorPalette;

  int get progressIndex => switch (this) {
        InteriorStep.addPhoto => 0,
        InteriorStep.roomType => 1,
        InteriorStep.style => 2,
        InteriorStep.colorPalette => 3,
        InteriorStep.processing => 3,
        InteriorStep.result => 3,
        InteriorStep.error => 3,
      };
}
