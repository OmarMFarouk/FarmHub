import 'package:farm_hub/shared/models/user_model.dart';

class InsightComment {
  int? commentid;
  String? commentbody;
  String? commentuserId;
  String? commentlikes;
  String? commentstatus;
  String? commentinsightId;
  String? commentdateCreated;
  String? commentdateUpdated;
  bool? isLiked;
  User? authorinfo;

  InsightComment(
      {this.commentid,
      this.commentbody,
      this.commentuserId,
      this.commentlikes,
      this.commentstatus,
      this.commentinsightId,
      this.commentdateCreated,
      this.commentdateUpdated,
      this.isLiked,
      this.authorinfo});

  InsightComment.fromJson(Map<String, dynamic> json) {
    commentid = json['comment_id'];
    commentbody = json['comment_body'];
    commentuserId = json['comment_userId'];
    commentlikes = json['comment_likes'];
    commentstatus = json['comment_status'];
    commentinsightId = json['comment_insightId'];
    commentdateCreated = json['comment_dateCreated'];
    commentdateUpdated = json['comment_dateUpdated'];
    isLiked = bool.parse(json['is_liked'].toString());
    authorinfo = json['author_info'] != null
        ? User?.fromJson(json['author_info'])
        : null;
  }
}

class CommentsModel {
  List<InsightComment?>? insightComments;
  bool? success;
  String? message;

  CommentsModel({this.insightComments, this.success, this.message});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    if (json['insight_comments'] != null) {
      insightComments = <InsightComment>[];
      json['insight_comments'].forEach((v) {
        insightComments!.add(InsightComment.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }
}
