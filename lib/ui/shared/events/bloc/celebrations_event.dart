abstract class CelebrationEvent{}

class FetchCelebrations extends CelebrationEvent{
  final DateTime dateTime;
  FetchCelebrations( this.dateTime);
 }

 class ShowBirthdaysEvent extends CelebrationEvent{}
class ShowAnniversariesEvent extends CelebrationEvent{}