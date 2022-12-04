import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<void> getFileLines() async {
  final data = await rootBundle.load('assets/data/day_2.txt');
  final directory = (await getTemporaryDirectory()).path;
  final file = await writeToFile(data, '$directory/bot.txt');
  var check = await file.readAsLines();

  int totalScore = 0;

  List<String> letters = [];

  // Add lowercase letters a through z to the list
  for (int i = 97; i <= 122; i++) {
    letters.add(String.fromCharCode(i));
  }

  // Add uppercase letters A through Z to the list
  for (int i = 65; i <= 90; i++) {
    letters.add(String.fromCharCode(i));
  }

  // Print the list of letters
  print(letters);


  for (var game in check) {
    var thisGame = game.split(' ');
    var opponentChoice = thisGame[0];
    var outcome = thisGame[1];
    int gameScore = 0;

    switch (outcome) {
      case 'X':
        //THIS IS A LOSS
        switch (opponentChoice) {
          case 'A':
            //THEY CHOOSE ROCK
            //I MUST CHOOSE SCISSOR
            gameScore = gameScore + 3;
            gameScore = gameScore + 0;
            break;
          case 'B':
            //THEY CHOOSE PAPER
            //I MUST CHOOSE ROCK
            gameScore = gameScore +1;
            gameScore = gameScore + 0;
            break;
          case 'C':
            //THEY CHOOSE SCISSORS
            //I MUST CHOOSE PAPER
            gameScore = gameScore +2;
            gameScore = gameScore + 0;
            break;
        }
        break;
      case 'Y':
      //THIS IS A DRAW
        switch (opponentChoice) {
          case 'A':
          //THEY CHOOSE ROCK
          //I MUST CHOOSE ROCK
            gameScore = gameScore + 1;
            gameScore = gameScore + 3;
            break;
          case 'B':
          //THEY CHOOSE PAPER
          //I MUST CHOOSE PAPER
            gameScore = gameScore +2;
            gameScore = gameScore + 3;
            break;
          case 'C':
          //THEY CHOOSE SCISSORS
          //I MUST CHOOSE SCISSORS
            gameScore = gameScore +3;
            gameScore = gameScore + 3;
            break;
        }
        break;
      case 'Z':
      //THIS IS A WIN
        switch (opponentChoice) {
          case 'A':
          //THEY CHOOSE ROCK
          //I MUST CHOOSE PAPER
            gameScore = gameScore + 2;
            gameScore = gameScore + 6;
            break;
          case 'B':
          //THEY CHOOSE PAPER
          //I MUST CHOOSE SCISSOR
            gameScore = gameScore +3;
            gameScore = gameScore + 6;
            break;
          case 'C':
          //THEY CHOOSE SCISSORS
          //I MUST CHOOSE ROCK
            gameScore = gameScore +1;
            gameScore = gameScore + 6;
            break;
        }
        break;
    }
    totalScore = totalScore + gameScore;
  }
print("TOTAL SCORE IS :$totalScore");
}

Future<File> writeToFile(ByteData data, String path) {
  return File(path).writeAsBytes(data.buffer.asUint8List(
    data.offsetInBytes,
    data.lengthInBytes,
  ));
}



//
// Future<void> getFileLines() async {
//   final data = await rootBundle.load('assets/data/day_2.txt');
//   final directory = (await getTemporaryDirectory()).path;
//   final file = await writeToFile(data, '$directory/bot.txt');
//   var check = await file.readAsLines();
//
//   int totalScore = 0;
//
//   for (var game in check) {
//     var thisGame = game.split(' ');
//     var opponentChoice = thisGame[0];
//     var myChoice = thisGame[1];
//     print(opponentChoice);
//     print(myChoice);
//     int gameScore = 0;
//
//     switch (myChoice) {
//       case 'X':
//         switch (opponentChoice) {
//           case 'A':
//             print("this is a tie");
//             gameScore = gameScore +1;
//             gameScore = gameScore + 3;
//             break;
//           case 'B':
//             print("this is a loss");
//             gameScore = gameScore +1;
//             gameScore = gameScore + 0;
//             break;
//           case 'C':
//             print("this is a win");
//             gameScore = gameScore +1;
//             gameScore = gameScore + 6;
//             break;
//         }
//         break;
//       case 'Y':
//         switch (opponentChoice) {
//           case 'A':
//             print("this is a win");
//             gameScore = gameScore +2;
//             gameScore = gameScore + 6;
//             break;
//           case 'B':
//             print("this is a tie");
//             gameScore = gameScore +2;
//             gameScore = gameScore + 3;
//             break;
//           case 'C':
//             print("this is a loss");
//             gameScore = gameScore +2;
//             gameScore = gameScore + 0;
//             break;
//         }
//         break;
//       case 'Z':
//         switch (opponentChoice) {
//           case 'A':
//             print("this is a loss");
//             gameScore = gameScore +3;
//             gameScore = gameScore + 0;
//             break;
//           case 'B':
//             print("this is a win");
//             gameScore = gameScore +3;
//             gameScore = gameScore + 6;
//             break;
//           case 'C':
//             print("this is a tie");
//             gameScore = gameScore +3;
//             gameScore = gameScore + 3;
//             break;
//         }
//         break;
//     }
//     totalScore = totalScore + gameScore;
//   }
//   print("TOTAL SCORE IS :$totalScore");
