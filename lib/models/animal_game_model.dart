class AnimalGameProvider {
  Map<String, Map<String, dynamic>> _listZodiac = {
    'ti': {'name': 'Chuột', 'score': 1},
    'suu': {'name': 'Trâu', 'score': 2},
    'dan': {'name': 'Cọp', 'score': 3},
    'mao': {'name': 'Mèo', 'score': 4},
    'thin': {'name': 'Rồng', 'score': 5},
    'ty': {'name': 'Rắn', 'score': 6},
    'ngo': {'name': 'Ngựa', 'score': 7},
    'mui': {'name': 'Dê', 'score': 8},
    'than': {'name': 'Khỉ', 'score': 9},
    'dau': {'name': 'Gà', 'score': 10},
    'tuat': {'name': 'Chó', 'score': 11},
    'hoi': {'name': 'Heo', 'score': 12},
  };

  Map<String, Map<String, dynamic>> get listZodiac {
    return _listZodiac;
  }
}
