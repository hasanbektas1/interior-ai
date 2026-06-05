enum StyleReferenceStep {
  yourPhoto,
  referencePhoto,
  processing,
  result,
  error,
}

extension StyleReferenceStepX on StyleReferenceStep {
  int get progressIndex => switch (this) {
        StyleReferenceStep.yourPhoto => 0,
        StyleReferenceStep.referencePhoto => 1,
        StyleReferenceStep.processing => 1,
        StyleReferenceStep.result => 1,
        StyleReferenceStep.error => 1,
      };
}
