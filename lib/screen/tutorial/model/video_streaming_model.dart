import 'dart:convert';

List<VideoStreamingModel> videoStreamingModelFromMap(String str) =>
    List<VideoStreamingModel>.from(
        json.decode(str).map((x) => VideoStreamingModel.fromMap(x)));

String videoStreamingModelToMap(List<VideoStreamingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class VideoStreamingModel {
  VideoStreamingModel({
    this.vId,
    required this.adminId,
    required this.vTitle,
    required this.vDescription,
    required this.videoUrl,
    required this.thumbImg,
  });

  String? vId;
  String adminId;
  String vTitle;
  String vDescription;
  String videoUrl;
  String thumbImg;

  factory VideoStreamingModel.fromMap(Map<String, dynamic> json) =>
      VideoStreamingModel(
        vId: json["v_id"],
        adminId: json["admin_id"],
        vTitle: json["v_title"],
        vDescription: json["v_description"],
        videoUrl: json["video_url"],
        thumbImg: json["thumb_img"],
      );

  Map<String, dynamic> toMap() => {
        "v_id": vId,
        "admin_id": adminId,
        "v_title": vTitle,
        "v_description": vDescription,
        "video_url": videoUrl,
        "thumb_img": thumbImg,
      };
}
