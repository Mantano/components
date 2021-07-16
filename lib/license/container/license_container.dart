// Copyright (c) 2021 Mantano. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:typed_data';

import 'package:mno_lcp_dart/lcp.dart';
import 'package:mno_shared_dart/mediatype.dart';
import 'package:universal_io/io.dart';

import 'epub_license_container.dart';
import 'lcpl_license_container.dart';
import 'web_pub_license_container.dart';

/// Encapsulates the read/write access to the packaged License Document (eg. in an EPUB container,
/// or a standalone LCPL file).
abstract class LicenseContainer {
  Future<ByteData> read();
  Future<void> write(LicenseDocument license);

  static Future<LicenseContainer> createLicenseContainer(String filepath,
      {List<String> mediaTypes = const []}) async {
    MediaType mediaType = await MediaType.ofFile(File(filepath),
        mediaTypes: mediaTypes, fileExtensions: []);
    if (mediaType == null) {
      throw LcpException.container.openFailed;
    }
    return createLicenseContainerForMediaType(filepath, mediaType);
  }

  static LicenseContainer createLicenseContainerForMediaType(
      String filepath, MediaType mediaType) {
    if (mediaType == MediaType.epub) {
      return EpubLicenseContainer(filepath);
    }
    if (mediaType == MediaType.lcpLicenseDocument) {
      return LcplLicenseContainer(filepath);
    }
    // Assuming it's a Readium WebPub package (e.g. audiobook, LCPDF, etc.) as a fallback
    return WebPubLicenseContainer(filepath);
  }
}
