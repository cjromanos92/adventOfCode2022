import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<void> getFileLines() async {
  final data = await rootBundle.load('assets/data/day_4.txt');
  final directory = (await getTemporaryDirectory()).path;
  final file = await writeToFile(data, '$directory/bot.txt');
  var rucksack = await file.readAsLines();
  int part1TotalScore = 0;
  int part2TotalScore = 0;

  for (var line in rucksack) {
    var elfPair = line.split(',');
    var elf1 = elfPair[0].split('-');
    var elf2 = elfPair[1].split('-');
    var elf1StartNum = int.parse(elf1[0]);
    int elf1EndNum = int.parse(elf1[1]);

    var elf2StartNum = int.parse(elf2[0]);
    int elf2EndNum = int.parse(elf2[1]);

//PART 1
    if ((elf1StartNum <= elf2StartNum && elf1EndNum >= elf2EndNum) ||
        (elf2StartNum <= elf1StartNum && elf2EndNum >= elf1EndNum)) {
      part1TotalScore++;
    }

//PART 2
    if ((elf1StartNum <= elf2StartNum && elf1EndNum >= elf2StartNum) ||
        (elf2StartNum <= elf1StartNum && elf2EndNum >= elf1StartNum)) {
      part2TotalScore++;
    }
  }
  print("Part 1 TOTAL SCORE = $part1TotalScore");
  print("Part 2 TOTAL SCORE = $part2TotalScore");
}

Future<File> writeToFile(ByteData data, String path) {
  return File(path).writeAsBytes(data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  ));
}
