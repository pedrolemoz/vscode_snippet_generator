import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart';

Future<void> main(List<String> args) async {
  final parser = ArgParser();
  final encoder = JsonEncoder.withIndent('  ');

  parser.addOption('path');
  parser.addOption('name');
  parser.addOption('description');
  parser.addOption('prefix');

  final results = parser.parse(args);

  final path = results['path'];
  final name = results['name'];
  final description = results['description'];
  final prefix = results['prefix'];

  if (path == null || name == null || description == null || prefix == null) {
    exit(1);
  }

  final lines = await readLinesFromFile(path);
  final optimizedLines = optimizeSnippet(lines);

  final snippet = {
    name: {
      'prefix': prefix,
      'description': description,
      'body': optimizedLines,
    }
  };

  final snippetAsJSON = encoder.convert(snippet);

  print(snippetAsJSON);
}

Future<List<String>> readLinesFromFile(String path) async {
  final file = File(normalize(path));
  return await file.readAsLines();
}

List<String> optimizeSnippet(List<String> lines) {
  for (var index = 0; index < lines.length; index++) {
    if (lines[index].isEmpty) {
      lines[index - 1] += '\n';
      lines.removeAt(index);
      index--;
    }
  }

  return lines;
}
