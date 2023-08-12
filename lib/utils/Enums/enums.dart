enum SubscriptionType {
  free('free'),
  monthly('monthly'),
  yearly('yearly'),
  cantafford('cantafford');

  final String name;

  const SubscriptionType(this.name);
}

enum LoginType {
  facebook('facebook'),
  google('google'),
  apple('apple'),
  simple('simple'); //with simple email password

  final String name;

  const LoginType(this.name);
}

enum SessionStatus {
  complete('complete'),
  pending('pending'),
  cancel('cancel');

  final String name;

  const SessionStatus(this.name);
}

enum ScheduleStatus {
  success('Success'),
  pending('Pending'),
  failed('Failed');

  final String name;

  const ScheduleStatus(this.name);
}
