import 'user_model.dart';

class FileModel {
  int? fileid;
  String? filelink;
  String? filetype;
  String? filereferenceType;
  String? filereferenceId;
  String? filestatus;
  String? filedateCreated;
  String? filedateUpdated;

  FileModel(
      {this.fileid,
      this.filelink,
      this.filetype,
      this.filereferenceType,
      this.filereferenceId,
      this.filestatus,
      this.filedateCreated,
      this.filedateUpdated});

  FileModel.fromJson(Map<String, dynamic> json) {
    fileid = json['file_id'];
    filelink = json['file_link'];
    filetype = json['file_type'];
    filereferenceType = json['file_referenceType'];
    filereferenceId = json['file_referenceId'];
    filestatus = json['file_status'];
    filedateCreated = json['file_dateCreated'];
    filedateUpdated = json['file_dateUpdated'];
  }
}

class Insight {
  int? insightId;
  String? insightTitle;
  String? insightBody;
  String? insightStatus;
  String? insightLikes;
  String? insightViews;
  String? insightShares;
  String? insightComments;
  String? insightUserId;
  String? insightDateCreated;
  String? insightDateUpdated;
  bool? isLiked;
  User? authorInfo;
  List<FileModel?>? files;

  Insight(
      {this.insightId,
      this.insightTitle,
      this.insightBody,
      this.insightStatus,
      this.insightLikes,
      this.insightViews,
      this.insightShares,
      this.insightComments,
      this.insightUserId,
      this.insightDateCreated,
      this.insightDateUpdated,
      this.authorInfo,
      this.files});

  Insight.fromJson(Map<String, dynamic> json) {
    insightId = json['insight_id'];
    insightTitle = json['insight_title'];
    insightBody = json['insight_body'];
    insightStatus = json['insight_status'];
    insightLikes = json['insight_likes'];
    insightViews = json['insight_views'];
    insightShares = json['insight_shares'];
    insightComments = json['insight_comments'];
    insightUserId = json['insight_userId'];
    insightDateCreated = json['insight_dateCreated'];
    insightDateUpdated = json['insight_dateUpdated'];
    isLiked = bool.parse(json['is_liked']);
    authorInfo = User.fromJson(json['author_info']);
    if (json['files'] != null) {
      files = <FileModel>[];
      json['files'].forEach((v) {
        files!.add(FileModel.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['insight_id'] = insightid;
  //   data['insight_title'] = insighttitle;
  //   data['insight_body'] = insightbody;
  //   data['insight_status'] = insightstatus;
  //   data['insight_likes'] = insightlikes;
  //   data['insight_views'] = insightviews;
  //   data['insight_shares'] = insightshares;
  //   data['insight_comments'] = insightcomments;
  //   data['insight_userId'] = insightuserId;
  //   data['insight_dateCreated'] = insightdateCreated;
  //   data['insight_dateUpdated'] = insightdateUpdated;

  //   return data;
  // }
}

class InsightModel {
  List<Insight?>? insights;
  bool? success;
  String? message;

  InsightModel({this.insights, this.success, this.message});

  InsightModel.fromJson(Map<String, dynamic> json) {
    if (json['insights'] != null) {
      insights = <Insight>[];
      json['insights'].forEach((v) {
        insights!.add(Insight.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }
}
