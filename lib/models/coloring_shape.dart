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
    final designIndex = index % 35;
    return 'assets/designs/animals/animals_$designIndex.svg';
  } else if (id.startsWith('vehicle')) {
    final index = int.parse(id.split('_')[1]);
    final designIndex = index % 35;
    return 'assets/designs/vehicles/vehicles_$designIndex.svg';
  } else if (id.startsWith('space')) {
    final index = int.parse(id.split('_')[1]);
    final designIndex = index % 25;
    return 'assets/designs/space/space_$designIndex.svg';
  } else if (id.startsWith('shape')) {
    final index = int.parse(id.split('_')[1]);
    final designIndex = index % 25;
    return 'assets/designs/shapes/shapes_$designIndex.svg';
  } else if (id.startsWith('english_letter')) {
    final letter = id.split('_')[2]; // Get the letter (a-z)
    return 'assets/designs/english_alphabet/letter_${letter.toUpperCase()}.svg';
  } else if (id.startsWith('arabic_letter')) {
    final index = int.parse(id.split('_')[2]);
    return 'assets/designs/arabic_alphabet/arabic_letter_$index.svg';
  } else if (id.startsWith('number')) {
    final index = int.parse(id.split('_')[1]);
    return 'assets/designs/numbers/number_$index.svg';
  }
  return 'assets/designs/shapes/shapes_0.svg';
}

final List<ColoringShape> sampleShapes = [
  // Animals - 35 designs
  ...List.generate(35, (index) {
    final animalNames = [
      'dog',
      'cat',
      'owl',
      'rabbit',
      'elephant',
      'lion',
      'tiger',
      'dinoseur',
      'fox',
      'wolf',
      'deer',
      'zebra',
      'giraffe',
      'monkey',
      'panda',
      'beaver',
      'penguin',
      'hippopotamus',
      'seal',
      'raccoon',
      'chimpanzee',
      'squirrel',
      'frog',
      'puppy',
      'jackal',
      'pussycat',
      'tiger',
      'elephant',
      'jagwar',
      'monkey',
      'lioness',
      'fox',
      'bear',
      'raccoon',
      'giraffe',
    ];
    final name = animalNames[index];
    return ColoringShape(
      id: 'animal_$index',
      nameKey: name,
      imageUrl: _getImageUrl('animal_$index'),
      category: 'animals',
    );
  }),

  // Vehicles - 35 designs
  ...List.generate(35, (index) {
    final vehicleNames = [
      'car',
      'truck',
      'bus',
      'motorbike',
      'train',
      'airplane',
      'helicopter',
      'boat',
      'ship',
      'submarine',
      'rocket',
      'roller_skates',
      'ambulance',
      'police_car',
      'fire_truck',
      'taxi',
      'van',
      'jeep',
      'scooter',
      'skateboard',
      'tractor',
      'excavator',
      'bulldozer',
      'crane',
      'rv',
      'sailboat',
      'speedboat',
      'sailship',
      'hot_air_balloon',
      'hang_glider',
      'space_shuttle',
      'bicycle',
      'camper',
      'garbage_truck',
      'dump_truck',
      'speedboat',
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

  // English Alphabet - 26 letters
  ...List.generate(26, (index) {
    final letter = String.fromCharCode(65 + index); // A-Z
    final letterName = letter.toLowerCase();
    return ColoringShape(
      id: 'english_letter_$letterName',
      nameKey: 'letter_$letterName',
      imageUrl: _getImageUrl('english_letter_$letter'),
      category: 'english_alphabet',
    );
  }),

  // Arabic Alphabet - 28 letters
  ...List.generate(28, (index) {
    final arabicLetters = [
      'alif',
      'ba',
      'ta',
      'tha',
      'jim',
      'ha',
      'kha',
      'dal',
      'dhal',
      'ra',
      'zai',
      'sin',
      'shin',
      'sad',
      'dad',
      'ta_emphatic',
      'dha_emphatic',
      'ain',
      'ghain',
      'fa',
      'qaf',
      'kaf',
      'lam',
      'meem',
      'noon',
      'ha_final',
      'waw',
      'ya',
      'hamza',
    ];
    final name = arabicLetters[index];
    return ColoringShape(
      id: 'arabic_letter_$index',
      nameKey: 'arabic_$name',
      imageUrl: _getImageUrl('arabic_letter_$index'),
      category: 'arabic_alphabet',
    );
  }),

  // Numbers - 10 digits (0-9)
  ...List.generate(10, (index) {
    final numberNames = [
      'zero',
      'one',
      'two',
      'three',
      'four',
      'five',
      'six',
      'seven',
      'eight',
      'nine',
    ];
    final name = numberNames[index];
    return ColoringShape(
      id: 'number_$index',
      nameKey: 'number_$name',
      imageUrl: _getImageUrl('number_$index'),
      category: 'numbers',
    );
  }),
];
