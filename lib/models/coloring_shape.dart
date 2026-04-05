class ColoringShape {
  final String id;
  final String nameKey;
  final String imageUrl;
  final String category;

  ColoringShape({
    required this.id,
    required this.nameKey,
    required this.imageUrl,
    required this.category,
  });
}

// Get image URL based on design type - now using local assets
String _getImageUrl(String id) {
  if (id.startsWith('animal')) {
    final index = int.parse(id.split('_')[1]);
    final designIndex = index % 25;
    return 'assets/designs/animals_$designIndex.svg';
  } else if (id.startsWith('vehicle')) {
    final index = int.parse(id.split('_')[1]);
    final designIndex = index % 25;
    return 'assets/designs/vehicles_$designIndex.svg';
  } else if (id.startsWith('space')) {
    final index = int.parse(id.split('_')[1]);
    final designIndex = index % 25;
    return 'assets/designs/space_$designIndex.svg';
  } else if (id.startsWith('shape')) {
    final index = int.parse(id.split('_')[1]);
    final designIndex = index % 25;
    return 'assets/designs/shapes_$designIndex.svg';
  }
  return 'assets/designs/shapes_0.svg';
}

final List<ColoringShape> sampleShapes = [
  // Animals - 25 designs
  ...List.generate(25, (index) {
    final animalNames = [
      'dog',
      'cat',
      'bird',
      'rabbit',
      'elephant',
      'lion',
      'tiger',
      'bear',
      'fox',
      'wolf',
      'deer',
      'zebra',
      'giraffe',
      'monkey',
      'panda',
      'koala',
      'penguin',
      'dolphin',
      'whale',
      'shark',
      'turtle',
      'snake',
      'frog',
      'butterfly',
      'bee',
    ];
    final name = animalNames[index];
    return ColoringShape(
      id: 'animal_$index',
      nameKey: name,
      imageUrl: _getImageUrl('animal_$index'),
      category: 'animals',
    );
  }),

  // Vehicles - 25 designs
  ...List.generate(25, (index) {
    final vehicleNames = [
      'car',
      'truck',
      'bus',
      'motorbike',
      'bicycle',
      'train',
      'airplane',
      'helicopter',
      'boat',
      'ship',
      'submarine',
      'rocket',
      'ambulance',
      'police_car',
      'fire_truck',
      'taxi',
      'van',
      'jeep',
      'scooter',
      'skateboard',
      'motorcycle',
      'tractor',
      'excavator',
      'bulldozer',
      'crane',
    ];
    final name = vehicleNames[index];
    return ColoringShape(
      id: 'vehicle_$index',
      nameKey: name,
      imageUrl: _getImageUrl('vehicle_$index'),
      category: 'vehicles',
    );
  }),

  // Space - 25 designs
  ...List.generate(25, (index) {
    final spaceNames = [
      'rocket',
      'ufo',
      'alien',
      'astronaut',
      'planet_earth',
      'planet_mars',
      'planet_jupiter',
      'planet_saturn',
      'sun',
      'moon',
      'star',
      'comet',
      'meteor',
      'asteroid',
      'satellite',
      'space_station',
      'galaxy',
      'black_hole',
      'nebula',
      'constellation',
      'telescope',
      'space_shuttle',
      'lunar_module',
      'rover',
      'spacesuit',
    ];
    final name = spaceNames[index];
    return ColoringShape(
      id: 'space_$index',
      nameKey: name,
      imageUrl: _getImageUrl('space_$index'),
      category: 'space',
    );
  }),

  // Shapes - 25 designs
  ...List.generate(25, (index) {
    final shapeNames = [
      'circle',
      'square',
      'triangle',
      'rectangle',
      'pentagon',
      'hexagon',
      'octagon',
      'star',
      'heart',
      'diamond',
      'oval',
      'ellipse',
      'crescent',
      'cross',
      'spiral',
      'cube',
      'sphere',
      'cylinder',
      'cone',
      'pyramid',
      'prism',
      'trapezoid',
      'parallelogram',
      'rhombus',
      'kite',
    ];
    final name = shapeNames[index];
    return ColoringShape(
      id: 'shape_$index',
      nameKey: name,
      imageUrl: _getImageUrl('shape_$index'),
      category: 'shapes',
    );
  }),
];
