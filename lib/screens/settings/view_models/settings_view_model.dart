import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:historycollection/screens/settings/models/settigs_model.dart';
import 'package:historycollection/screens/settings/repos/settings_repository.dart';

class SettingsViewModel extends Notifier<SettingsModel> {
  final SettingsRepository _repository = SettingsRepository();

  /// Notification만 처리 하도록 설정 기존객체 Immutable
  void setNotification(bool isNotification) {
    final settingsModel = _repository.getSettings.toMap();
    settingsModel['notification'] = isNotification;

    final model = SettingsModel.fromMap(settingsModel);
    _repository.setSettings(model);

    state = SettingsModel(
      notification: isNotification,
    );
  }

  @override
  SettingsModel build() {
    // TODO: implement build
    // throw UnimplementedError();
    return _repository.getSettings;
  }
}

final settingsProvider = NotifierProvider<SettingsViewModel, SettingsModel>(
  () {
    return SettingsViewModel();
  },
);
