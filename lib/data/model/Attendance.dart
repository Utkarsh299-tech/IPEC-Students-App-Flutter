class Attendance {
  String body;
  double presentPercent;
  String totalLectures;
  String presentLecture;
  Attendance(
      {this.body,
      this.presentPercent,
      this.presentLecture,
      this.totalLectures});

  String getBody() => this.body;
  double getPresentPercent() => this.presentPercent;
  double getAbsentPercent() =>
      double.parse((100 - this.presentPercent).toStringAsFixed(2));
  String getTotalLectures() => this.totalLectures;
  String getPresentLectures() => this.presentLecture;
  String getAttendanceMessage() {
    double attendance = this.presentPercent;
    if (attendance == 100) {
      return "God Level! 🙏👑👏";
    }
    if (90 <= attendance) {
      return "I know you love attending classes 😌";
    }
    if (80 <= attendance) {
      return "Safezone! Keep on maintaining\nit! 🌠🌈";
    }
    if (75 <= attendance) {
      return "Pheww...You are Safe ! 👏😁";
    }
    if (65 <= attendance) {
      return "Oh!no...Short Attendance! 😱";
    }
    if (50 <= attendance) {
      return "Daredevil Attend more Classes 😈";
    }
    if (attendance < 50 && attendance != 0) {
      return "Classes are calling attend them 🐱🔥";
    }
    if (attendance == 0) {
      return "Zero-zero is a big score! 🌸";
    }
    return "Attendance Loaded :)";
  }
}
