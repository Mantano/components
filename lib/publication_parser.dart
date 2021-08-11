// Copyright (c) 2021 Mantano. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mno_shared_dart/fetcher.dart';
import 'package:mno_shared_dart/publication.dart';
import 'package:path/path.dart';

import 'src/container/container.dart' as c;

///  Parses a Publication from a file.
abstract class PublicationParser {
  Future<PubBox> parse(String fileAtPath) =>
      parseWithFallbackTitle(fileAtPath, basename(fileAtPath));

  Future<PubBox> parseWithFallbackTitle(
      String fileAtPath, String fallbackTitle);
}

abstract class StreamPublicationParser {
  /// Constructs a [Publication.Builder] to build a [Publication] from a publication file.
  ///
  /// @param asset Digital medium (e.g. a file) used to access the publication.
  /// @param fetcher Initial leaf fetcher which should be used to read the publication's resources.
  /// This can be used to:
  /// - support content protection technologies
  /// - parse exploded archives or in archiving formats unknown to the parser, e.g. RAR
  /// If the file is not an archive, it will be reachable at the HREF /<file.name>,
  /// e.g. with a PDF.
  /// @param warnings Used to report non-fatal parsing warnings, such as publication authoring
  /// mistakes. This is useful to warn users of potential rendering issues or help authors
  /// debug their publications.
  Future<PublicationBuilder> parseFile(PublicationAsset asset, Fetcher fetcher);
}

class PubBox {
  final Publication publication;
  final c.Container container;

  PubBox(this.publication, this.container);
}
