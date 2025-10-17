import 'package:equatable/equatable.dart';

class IconDataEntity extends Equatable{
  final String iconName;
  final int iconCodePoint;
  final String iconFontFamily;
  final String iconFontPackage;

  const IconDataEntity({required this.iconName, required this.iconCodePoint, required this.iconFontFamily, required this.iconFontPackage});

  @override
  List<Object?> get props => [iconName, iconCodePoint, iconFontFamily, iconFontPackage];

}