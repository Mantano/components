// Copyright (c) 2021 Mantano. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:intl/intl.dart';
import 'package:mno_shared_dart/i18n/localizations_repository.dart';

class UserException implements Exception {
  final String userMessageId;
  final List<dynamic> args;
  final int quantity;
  final Object cause;

  const UserException(this.userMessageId,
      {this.args = const [], this.quantity, this.cause});

  /// Gets the localized user-facing message for this exception.
  ///
  /// @param includesCauses Includes nested [UserException] causes in the user message when true.
  String getUserMessage(LocalizationsRepository localizationsRepository,
      {bool includesCauses = true}) {
    // Convert complex objects to strings, such as Date, to be interpolated.
    List<dynamic> _args = args.map((arg) {
      if (arg is DateTime) {
        return DateFormat.d().add_MMM().add_y().format(arg);
      } else {
        return arg;
      }
    }).toList();

    return localizationsRepository.getMessage(userMessageId, _args);
  }

  @override
  String toString() =>
      'UserException{userMessageId: $userMessageId, args: $args, '
      'quantity: $quantity, cause: $cause}';
}
