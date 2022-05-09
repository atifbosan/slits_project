class AdminSuggestionModel {
  String? s_id;
  String? user_id;
  String? admin_id;
  String? name;
  String? s_title;
  String? s_description;
  String? is_view;
  String? user_type;
  String? category;

  AdminSuggestionModel(
      {required this.user_id,
      required this.admin_id,
      this.name = "Admin",
      required this.s_title,
      this.user_type = "Admin",
      this.category = "insert"});

  AdminSuggestionModel.fromJson(Map<String, dynamic> json) {
    this.s_id = json['s_id'];
    this.user_id = json['user_id'];
    this.name = json['name'];
    this.s_title = json['s_title'];
    this.s_description = json['s_description'];
    this.is_view = json['is_view'];
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['user_id'] = user_id;
    map['admin_id'] = admin_id;
    map['name'] = name;
    map['s_title'] = s_title;
    map['user_type'] = user_type;
    map['category'] = category;
    return map;
  }
}
