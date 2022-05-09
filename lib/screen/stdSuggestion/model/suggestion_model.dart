class SuggestionModel {
  String? user_id;
  String? name;
  String? s_title;
  String? s_description;
  String? is_view;
  String? category;

  SuggestionModel(
      {required this.user_id,
      required this.name,
      required this.s_title,
      required this.s_description,
      this.is_view = "0",
      this.category = "insert"});
  SuggestionModel.fromJson(Map<String, dynamic> json) {
    this.user_id = json['user_id'];
    this.name = json['name'];
    this.s_title = json['s_title'];
    this.s_description = json['s_description'];
    this.is_view = json['is_view'];
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['user_id'] = this.user_id;
    map['name'] = this.name;
    map['s_title'] = this.s_title;
    map['s_description'] = this.s_description;
    map['is_view'] = this.is_view;
    map['category'] = this.category;
    return map;
  }
}
