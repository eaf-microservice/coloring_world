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
  // Animals - 100 designs
  ...List.generate(100, (index) {
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
      'ant',
      'ladybug',
      'spider',
      'dragon',
      'unicorn',
      'horse',
      'sheep',
      'pig',
      'cow',
      'chicken',
      'duck',
      'goose',
      'eagle',
      'owl',
      'parrot',
      'fish',
      'octopus',
      'crab',
      'starfish',
      'jellyfish',
      'seahorse',
      'hamster',
      'rabbit',
      'squirrel',
      'hedgehog',
    ];
    final name = animalNames[index % animalNames.length];
    return ColoringShape(
      id: 'animal_$index',
      nameKey: name,
      imageUrl: _getImageUrl('animal_$index'),
      category: 'animals',
    );
  }),

  // Vehicles - 100 designs
  ...List.generate(100, (index) {
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
      'roller_skates',
      'motorcycle',
      'tractor',
      'excavator',
      'bulldozer',
      'crane',
      'dump_truck',
      'garbage_truck',
      'camper',
      'rv',
      'sailboat',
      'speedboat',
      'ferry',
      'yacht',
      'sailship',
      'hot_air_balloon',
      'blimp',
      'hang_glider',
      'glider',
      'parachute',
      'space_shuttle',
      'fighter_jet',
      'cargo_plane',
      'private_plane',
      'seaplane',
      'hovercraft',
      'jet_ski',
      'canoe',
      'surfboard',
      'skateboard',
    ];
    final name = vehicleNames[index % vehicleNames.length];
    return ColoringShape(
      id: 'vehicle_$index',
      nameKey: name,
      imageUrl: _getImageUrl('vehicle_$index'),
      category: 'vehicles',
    );
  }),

  // Space - 100 designs
  ...List.generate(100, (index) {
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
      'helmet',
      'oxygen_tank',
      'landing_pod',
      'cargo_ship',
      'fighter_spacecraft',
      'asteroid_belt',
      'meteor_shower',
      'solar_flare',
      'eclipse',
      'milky_way',
      'orion',
      'venus',
      'mercury',
      'neptune',
      'uranus',
      'comet_halley',
      'space_probe',
      'space_telescope',
      'solar_panel',
      'antenna',
      'communication_satellite',
      'asteroid_mining_ship',
      'space_colony',
      'moon_base',
      'mars_rover',
    ];
    final name = spaceNames[index % spaceNames.length];
    return ColoringShape(
      id: 'space_$index',
      nameKey: name,
      imageUrl: _getImageUrl('space_$index'),
      category: 'space',
    );
  }),

  // Shapes - 100 designs
  ...List.generate(100, (index) {
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
      'semicircle',
      'quarter_circle',
      'arc',
      'leaf',
      'flower',
      'snowflake',
      'sun_shape',
      'cloud',
      'raindrop',
      'wave',
      'zigzag',
      'checkerboard',
      'houndstooth',
      'honeycomb',
      'mandala',
      'starburst',
      'target',
      'concentric_circles',
      'interlocking_rings',
      'yin_yang',
      'trefoil',
      'celtic_knot',
      'kaleidoscope',
      'tessellation',
      'fractal',
    ];
    final name = shapeNames[index % shapeNames.length];
    return ColoringShape(
      id: 'shape_$index',
      nameKey: name,
      imageUrl: _getImageUrl('shape_$index'),
      category: 'shapes',
    );
  }),
];
