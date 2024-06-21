class Activity{
  String userId;
  double totalDistance;
  double avgSpeed;
  double activeTime;
  int activeDateOfWeek;
  Activity({
    required this.userId,
    required this.totalDistance,
    required this.avgSpeed,
    required this.activeTime,
    required this.activeDateOfWeek
  });
  // Phương thức toJson để chuyển đổi đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'totalDistance': totalDistance,
      'avgSpeed': avgSpeed,
      'activeTime': activeTime,
    };
  }

  // Phương thức fromJson để chuyển đổi JSON thành đối tượng
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      userId: json['userId'],
      totalDistance: (json['totalDistance'] as num).toDouble(),
      avgSpeed: (json['avgSpeed'] as num).toDouble(),
      activeTime: (json['activeTime'] as num).toDouble(),
      activeDateOfWeek: (json['activeDateOfWeek'] as num).toInt()
    );
  }
}