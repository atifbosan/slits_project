class VideoAddModel {
  String? admin_id;
  String? v_title;
  String? v_description;
  String? thumb_img;

  VideoAddModel(
      {required this.admin_id,
      required this.v_title,
      required this.v_description,
      required this.thumb_img});

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['admin_id'] = this.admin_id;
    map['v_title'] = this.v_title;
    map['v_description'] = this.v_description;
    map['thumb_img'] = this.thumb_img;
    return map;
  }
}
