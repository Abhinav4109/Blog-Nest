
import 'package:reading_time/reading_time.dart';

String calculateReadingTime ({required String content}){
  var reader = readingTime(content, lessMsg: 'Less than a minute');
  return reader.msg;
}