import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Persists whether the intro has been completed, as a marker file in the
/// app documents directory (avoids adding a preferences dependency).
class OnboardingStorage {
  const OnboardingStorage();

  static const _fileName = '.onboarding_complete';

  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File(p.join(dir.path, _fileName));
  }

  Future<bool> isCompleted() async => (await _file()).exists();

  Future<void> setCompleted(bool completed) async {
    final file = await _file();
    if (completed) {
      await file.create(recursive: true);
    } else if (await file.exists()) {
      await file.delete();
    }
  }
}
