import 'package:table_calendar/table_calendar.dart';
int swipeDown = 2;

extension FormatExtention on CalendarFormat {
  CalendarFormat findNextCalendarFormatBySwipeDirection(int direction){
    if(direction == swipeDown){
      if(CalendarFormat.values.length-1>CalendarFormat.values.indexOf(this)){
        return CalendarFormat.values.elementAt(CalendarFormat.values.indexOf(this)+1);
      }
      return this;
    }else {
      if(CalendarFormat.values.indexOf(this)>0){
        return  CalendarFormat.values.elementAt(CalendarFormat.values.indexOf(this)-1);
      }
      return this;
    }
  }
}