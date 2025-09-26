import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskly/features/theme/domain/entities/theme_entity.dart';

class ThemeLocalDatasource{
  final SharedPreferences sharedPreferences;

  ThemeLocalDatasource({required this.sharedPreferences});

  Future<void> saveTheme(ThemeEntity theme) async{
    var themeValue = theme.themeType == ThemeType.dark ? 'dark' : 'light';
    await sharedPreferences.setString('theme_key', themeValue);
  }

  Future<ThemeEntity> getTheme() async{
    var themeValue = sharedPreferences.getString('theme_key');
      if(themeValue=='dark'){
        return ThemeEntity(themeType: ThemeType.dark);
      }
      return ThemeEntity(themeType: ThemeType.light);
  }
}