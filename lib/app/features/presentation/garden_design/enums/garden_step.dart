enum GardenStep { addPhoto, style, processing, result, error }

extension GardenStepX on GardenStep {
  int get progressIndex => switch (this) {
    GardenStep.addPhoto => 0,
    GardenStep.style => 1,
    GardenStep.processing => 1,
    GardenStep.result => 1,
    GardenStep.error => 1,
  };
}
