// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import '../../../common/constants.dart';
import '../../../enums/text_size_state.dart';
import '../../../locator.dart';
import '../../../services/storage_service.dart';
import '../../viewmodels/base_model.dart';

class OptionContainerViewModel extends BaseModel {
  TextSizeState _textSizeState = TextSizeState.medium;

  bool _lightMode = true;

  TextSizeState get textSizeState => _textSizeState;

  bool get lightMode => _lightMode;

  StorageService _storageService = locator<StorageService>();

  double fontSize() {
    if (_textSizeState == TextSizeState.small) {
      return 14.0;
    } else if (_textSizeState == TextSizeState.large) {
      return 18.0;
    } else {
      return 16.0;
    }
  }

  int fontSizeInteger() {
    if (_textSizeState == TextSizeState.small) {
      return 14;
    } else if (_textSizeState == TextSizeState.large) {
      return 18;
    } else {
      return 16;
    }
  }

  Future<void> initialize() async {
    String textSize =
        await _storageService.getDataFromSharedPrefs(key: CACHE_TEXTSIZE_KEY);

    bool lightMode = await _storageService.getBoolFromSharedPrefs(
        key: CACHE_LIGHT_DARK_MODE_KEY);

    if (lightMode != null) {
      _lightMode = lightMode;
    }

    if (textSize == null) {
      _textSizeState = TextSizeState.medium;
    } else if (textSize == 'small') {
      _textSizeState = TextSizeState.small;
    } else if (textSize == 'medium') {
      _textSizeState = TextSizeState.medium;
    } else if (textSize == 'large') {
      _textSizeState = TextSizeState.large;
    } else {
      _textSizeState = TextSizeState.medium;
    }
    notifyListeners();
  }

  Future<void> setMode({bool mode = true}) async {
    bool success = await _storageService.setBoolToSharedPrefs(
        data: mode, key: CACHE_LIGHT_DARK_MODE_KEY);

    _lightMode = mode;
    // print(mode);
    notifyListeners();
  }

  Future<void> setTextSize({TextSizeState? textSizeState}) async {
    String textSizeString = _enumValueToString(textSizeState: textSizeState!);

    bool success = await _storageService.saveDataToSharedPrefs(
        data: textSizeString, key: CACHE_TEXTSIZE_KEY);

    _textSizeState = textSizeState;
    notifyListeners();
  }

  String _enumValueToString({TextSizeState? textSizeState}) {
    if (textSizeState == TextSizeState.small) {
      return 'small';
    } else if (textSizeState == TextSizeState.large) {
      return 'large';
    } else {
      return 'medium';
    }
  }
}
