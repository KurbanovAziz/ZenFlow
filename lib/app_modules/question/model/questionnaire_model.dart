class Questionnaire {
  Questionnaire({
    this.userId,
    this.age,
    this.gender,
    this.fitnessLevel,
    this.weightLossGoal,
    this.dailyTime,
  });

  String? userId;
  String? age;
  String? gender;
  String? fitnessLevel;
  String? weightLossGoal;
  String? dailyTime;

  factory Questionnaire.fromJson(Map<String, dynamic> json) => Questionnaire(
        userId: json["user_id"] ?? '',
        age: json["age"] ?? '',
        gender: json["gender"] ?? '',
        fitnessLevel: json["fitnessLevel"] ?? '',
        weightLossGoal: json["weightLossGoal"] ?? '',
        dailyTime: json["dailyTime"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "age": age,
        "gender": gender,
        "fitnessLevel": fitnessLevel,
        "weightLossGoal": weightLossGoal,
        "dailyTime": dailyTime,
      };
}
