import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
      methodCount: 0, // set it 2 if u want to see wheres method implement
      errorMethodCount: 5,
      lineLength: 50, //
      colors: true, // to set color for msg
      printEmojis: true, // add emoji
      printTime: false // show time
  ),
);