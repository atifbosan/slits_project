class FavouriteModel {
  String? v_id;
  String? v_title;
  String? v_description;
  String? thumb_img;
  String? video_url;
  String? user_id;
  String? category;
  FavouriteModel(
      {required this.v_id,
      required this.v_title,
      required this.v_description,
      required this.thumb_img,
      required this.video_url,
      required this.user_id,
      this.category = "insert"});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    this.v_id = json['v_id'];
    this.v_title = json['v_title'];
    this.v_description = json['v_description'];
    this.thumb_img = json['thumb_img'];
    this.video_url = json['video_url'];
    this.user_id = json['user_id'];
  }
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['v_id'] = this.v_id;
    map['v_title'] = this.v_title;
    map['v_description'] = this.v_description;
    map['thumb_img'] = this.thumb_img;
    map['video_url'] = this.video_url;
    map['user_id'] = this.user_id;
    map['category'] = this.category;
    return map;
  }
}
