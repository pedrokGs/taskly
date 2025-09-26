class IconDataModel {
  final String iconName;
  final int iconCodePoint;
  final String iconFontFamily;
  final String iconFontPackage;

  IconDataModel({
    required this.iconName,
    required this.iconCodePoint,
    required this.iconFontFamily,
    required this.iconFontPackage,
  });

  factory IconDataModel.fromMap(Map<String, dynamic> map) {
    return IconDataModel(
      iconName: map['iconName'] ?? '',
      iconCodePoint: map['iconCodePoint'] ?? 0,
      iconFontFamily: map['iconFontFamily'] ?? '',
      iconFontPackage: map['iconFontPackage'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'iconName': iconName,
      'iconCodePoint': iconCodePoint,
      'iconFontFamily': iconFontFamily,
      'iconFontPackage': iconFontPackage,
    };
  }

  IconDataModel copyWith({
    String? iconName,
    int? iconCodePoint,
    String? iconFontFamily,
    String? iconFontPackage,
  }) {
    return IconDataModel(
      iconName: iconName ?? this.iconName,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      iconFontFamily: iconFontFamily ?? this.iconFontFamily,
      iconFontPackage: iconFontPackage ?? this.iconFontPackage,
    );
  }
}
