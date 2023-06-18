class AraeModel {
  final String shotImg;
  final String nickName;
  final String interest;
  final int enterCnt;
  final String location;
  final AreaPosition position;

  AraeModel({
    required this.shotImg,
    required this.nickName,
    required this.interest,
    required this.enterCnt,
    required this.location,
    required this.position,
  });

  AraeModel.fromJson(Map<String, dynamic> json)
      : shotImg = json['shotImg'],
        nickName = json['nickName'],
        interest = json['interest'],
        enterCnt = json['enterCnt'],
        location = json['location'],
        position = AreaPosition.fromJson(
          json['position'],
        );
}

class AreaPosition {
  final double lat;
  final double lng;

  AreaPosition({
    required this.lat,
    required this.lng,
  });

  AreaPosition.fromJson(Map<String, dynamic> json)
      : lat = json['lat'],
        lng = json['lng'];
}
