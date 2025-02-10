import 'package:farm_hub/shared/models/insights_model.dart';
import 'package:farm_hub/shared/models/listings_model.dart';
import 'package:farm_hub/shared/models/user_model.dart';

class ProfilesModel {
  bool? success;
  String? message;
  User? userdata;
  List<Listing?>? listings;
  List<Insight?>? insights;

  ProfilesModel(
      {this.success,
      this.message,
      this.userdata,
      this.listings,
      this.insights});

  ProfilesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    userdata =
        json['user_data'] != null ? User?.fromJson(json['user_data']) : null;
    if (json['listings'] != null) {
      listings = <Listing>[];
      json['listings'].forEach((v) {
        listings!.add(Listing.fromJson(v));
      });
    }
    if (json['insights'] != null) {
      insights = <Insight>[];
      json['insights'].forEach((v) {
        insights!.add(Insight.fromJson(v));
      });
    }
  }
}
