// Copyright (c) 2013, Google Inc. Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library git_clone_test;

import 'package:unittest/unittest.dart';

import 'package:hetimagit/src/git/commands/clone.dart';
import 'package:hetimagit/src/git/objectstore.dart';
import 'utils.dart';
import 'dart:html';

main() {
  defineTests();
}
defineTests() {
  group('git.commands.clone', () {
    GitLocation location;

    setUp(() {
      location = new GitLocation();
      return location.init();
    });

    tearDown(() {
     // return location.dispose();
    });

    test('simple clone', () {
      print("##${location.name}");
      ObjectStore store = new ObjectStore(location.entry);
      Clone clone = new Clone(new GitOptions(
          repoUrl: sampleRepoUrl,
          root: location.entry,
          depth: 1,
          store: store));
      return clone.clone().then((_) {
        (location.entry as DirectoryEntry).createReader().readEntries()
        .then((List<Entry> l){
          for(Entry e in l) {
            print("#${e.fullPath}");
          }
        });
      });
    });
  });
}
