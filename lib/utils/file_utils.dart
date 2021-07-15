// Copyright (c) 2021 Mantano. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:universal_io/io.dart';

class FileUtils {
  static Future<Directory> ensureFolderExists(String directory) {
    Directory folder = Directory(directory);
    return folder
        .exists()
        .then((exists) => (exists) ? folder : folder.create());
  }

  static Future deleteDirectory(String directory, {bool recursive}) {
    Directory folder = Directory(directory);
    return folder.exists().then(
        (exists) => (exists) ? folder.delete(recursive: recursive) : null);
  }

  static Future emptyDirectory(String directory, {bool recursive}) {
    Directory folder = Directory(directory);
    return folder.exists().then((exists) => (exists)
        ? folder.list(recursive: recursive).listen((file) => file.delete())
        : null);
  }
}
