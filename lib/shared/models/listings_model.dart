import 'package:farm_hub/shared/models/insights_model.dart';
import 'package:farm_hub/shared/models/user_model.dart';

class Listing {
  int? id;
  String? title;
  String? body;
  String? price;
  String? status;
  String? views;
  String? shares;
  String? userId;
  String? dateCreated;
  String? dateUpdated;
  List<FileModel?>? files;
  User? authorInfo;

  Listing(
      {this.id,
      this.title,
      this.body,
      this.price,
      this.status,
      this.views,
      this.shares,
      this.userId,
      this.dateCreated,
      this.dateUpdated,
      this.files});

  Listing.fromJson(Map<String, dynamic> json) {
    id = json['listing_id'];
    title = json['listing_title'];
    body = json['listing_body'];
    price = json['listing_price'];
    status = json['listing_status'];
    views = json['listing_views'];
    shares = json['listing_shares'];
    userId = json['listing_userId'];
    dateCreated = json['listing_dateCreated'];
    dateUpdated = json['listing_DateUpdated'];
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
  //   data['listing_id'] = listingid;
  //   data['listing_title'] = listingtitle;
  //   data['listing_body'] = listingbody;
  //   data['listing_price'] = listingprice;
  //   data['listing_status'] = listingstatus;
  //   data['listing_views'] = listingviews;
  //   data['listing_shares'] = listingshares;
  //   data['listing_userId'] = listinguserId;
  //   data['listing_dateCreated'] = listingdateCreated;
  //   data['listing_DateUpdated'] = listingDateUpdated;
  //   data['files'] = files?.map((v) => v?.toJson()).toList();
  //   return data;
  // }
}

class ListingsModel {
  List<Listing?>? listings;
  bool? success;
  String? message;

  ListingsModel({this.listings, this.success, this.message});

  ListingsModel.fromJson(Map<String, dynamic> json) {
    if (json['listings'] != null) {
      listings = <Listing>[];
      json['listings'].forEach((v) {
        listings!.add(Listing.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
  }
}
