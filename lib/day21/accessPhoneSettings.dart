import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';

class AccessAppSettings extends StatelessWidget {
  const AccessAppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    AppSettings.openAppSettings(
                        type: AppSettingsType.internalStorage);
                  },
                  child: const Text("Open Settings")),
              TextButton(
                  onPressed: () {
                    AppSettings.openAppSettings(
                        type: AppSettingsType.bluetooth);
                  },
                  child: const Text("Open bluetooth Settings")),
              TextButton(
                  onPressed: () {
                    AppSettings.openAppSettings(type: AppSettingsType.wifi);
                  },
                  child: const Text("Open wifi Settings")),
              TextButton(
                  onPressed: () {
                    AppSettings.openAppSettingsPanel(
                        AppSettingsPanelType.volume);
                  },
                  child: const Text("Open volume Settings pannel")),
              TextButton(
                  onPressed: () {
                    AppSettings.openAppSettings(type: AppSettingsType.wireless);
                  },
                  child: const Text("Open wireless Settings pannel")),
            ],
          ),
        ),
      ),
    );
  }
}
