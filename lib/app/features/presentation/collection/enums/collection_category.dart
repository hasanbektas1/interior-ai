enum CollectionCategory {
  interiorDesign('Interior'),
  exteriorDesign('Exterior'),
  gardenDesign('Garden'),
  floorRestyle('Floor'),
  replaceObject('Replace'),
  styleReference('Style Reference');

  final String label;
  const CollectionCategory(this.label);

  static CollectionCategory fromName(String name) => values.firstWhere(
    (category) => category.name == name,
    orElse: () => CollectionCategory.interiorDesign,
  );
}
