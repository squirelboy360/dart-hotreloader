/**
 * Copyright 2020-2021 by Vegard IT GmbH (https://vegardit.com) and contributors.
 * SPDX-License-Identifier: Apache-2.0
 *
 * @author Sebastian Thomschke, Vegard IT GmbH
 */
import 'dart:io' as io;
import 'dart:isolate' as isolate;
import 'package:path/path.dart' as p;

Future<io.File> _getPackagesFile() async {
  final path = (await isolate.Isolate.packageConfig)?.toFilePath() ?? '.packages';
  return new io.File(path).absolute;
}
late final Future<io.File> packagesFile = _getPackagesFile();

io.Directory _getPubCacheDir() {
  final env = io.Platform.environment;
  final path = env['PUB_CACHE'] ??
      (io.Platform.isWindows //
          ? '${env['APPDATA']}\\Pub\\Cache' //
          : '${env['HOME']}/.pub-cache' //
      );
  return new io.Directory(p.normalize(path)).absolute;
}
late final io.Directory pubCacheDir = _getPubCacheDir();