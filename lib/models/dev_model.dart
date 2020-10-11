class DevProfile {
  final List<String> techs;
  final String sId;
  final String githubUsername;
  final String name;
  final String avatarUrl;
  final String bio;
  final Location location;

  DevProfile(
      {this.techs,
      this.sId,
      this.githubUsername,
      this.name,
      this.avatarUrl,
      this.bio,
      this.location});

  factory DevProfile.fromJson(Map<String, dynamic> json) {
    return DevProfile(
      techs: json['techs'].cast<String>(),
      sId: json['_id'],
      githubUsername: json['github_username'],
      name: json['name'],
      avatarUrl: json['avatar_url'],
      bio: json['bio'],
      location: json['location'] != null ? new Location.fromJson(json['location']) : null,
    );
  }
}

class Location {
  List<double> coordinates;
  String sId;
  String type;

  Location({this.coordinates, this.sId, this.type});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: json['coordinates'].cast<double>(),
      sId: json['_id'],
      type: json['type'],
    );
  }
}
