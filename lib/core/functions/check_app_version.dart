import 'dart:developer';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:souqalgomlah_app/core/data/repo/app_version/app_version_repo.dart';
import 'package:souqalgomlah_app/core/data/repo/app_version/app_version_repo_impl.dart';

Future<bool> checkAppVersion() async {
  final AppVersionRepo appVersionRepo = AppVersionRepoImpl();
  final result = await appVersionRepo.getAppVersion();
  return result.fold((l) {
    log(l.errMsg, name: 'Check App Version');
    return false;
  }, (r) async {
    final info = await PackageInfo.fromPlatform();
    log(info.version, name: 'App Version');
    return info.version != r;
  });
}
