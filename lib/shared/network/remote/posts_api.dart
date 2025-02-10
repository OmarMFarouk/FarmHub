import 'dart:convert';
import 'dart:developer';
import 'package:farm_hub/logic/user/user_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:platform_file/platform_file.dart';

import 'end_points.dart';

class PostsApi {
  Future fetchInsights() async {
    try {
      http.Response request = await http.get(Uri.parse(EndPoints.showInsights));
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      }
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }

  Future fetchInsightComments({required String insightId}) async {
    try {
      http.Response request = await http.post(Uri.parse(EndPoints.showComments),
          body: {
            "insight_id": insightId,
            'user_id': currentUser!.user!.id.toString()
          });
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      }
      print('a7a $insightId');
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }

  Future createInsight(
      {required title,
      required body,
      required List<PlatformFile> filesData}) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(EndPoints.createInsight),
      );

      Map<String, String> data = {
        'insight_title': title,
        'insight_body': body,
        'insight_userId': currentUser!.user!.id!.toString()
      };
      request.fields.addAll(data);
      for (var fileData in filesData) {
        request.files.add(http.MultipartFile.fromBytes(
            "file", fileData.bytes as List<int>,
            filename: fileData.name));
      }
      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      var jsonData = await jsonDecode(respStr);
      if (response.statusCode < 300) {
        return jsonData;
      } else {
        return 'error';
      }
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }

  Future searchListings({required String keyWord}) async {
    try {
      http.Response request = await http.post(
          Uri.parse(EndPoints.searchListings),
          body: {'search_keyword': keyWord});
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      }
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }

  Future fetchListings() async {
    try {
      http.Response request = await http.get(Uri.parse(EndPoints.showListings));
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);

        return response;
      }
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }

  Future createListing(
      {required title,
      required body,
      required price,
      required List<PlatformFile> filesData}) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(EndPoints.createListing),
      );
      Map<String, String> data = {
        'listing_title': title,
        'listing_body': body,
        'listing_price': price,
        'listing_userId': currentUser!.user!.id!.toString()
      };
      request.fields.addAll(data);
      for (var fileData in filesData) {
        request.files.add(http.MultipartFile.fromBytes(
            "file", fileData.bytes as List<int>,
            filename: fileData.name));
      }
      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      var jsonData = await jsonDecode(respStr);
      if (response.statusCode < 300) {
        return jsonData;
      } else {
        return 'error';
      }
    } catch (e) {
      log(e.toString());
      return 'error';
    }
  }

  Future incrementViews(
      {required String postId, required String postType}) async {
    try {
      http.Response request = await http.post(
          Uri.parse(EndPoints.incrementViews),
          body: {'post_id': postId, 'post_type': postType});
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      }
    } catch (e) {}
  }

  Future incrementShares(
      {required String postId, required String postType}) async {
    try {
      http.Response request = await http.post(
          Uri.parse(EndPoints.incrementShares),
          body: {'post_id': postId, 'post_type': postType});
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      }
    } catch (e) {}
  }

  Future likeInsight({required String insightId, required bool isLiked}) async {
    try {
      http.Response request =
          await http.post(Uri.parse(EndPoints.likeInsight), body: {
        'insight_id': insightId,
        'is_liked': isLiked.toString(),
        'user_id': currentUser!.user!.id.toString()
      });
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future commentLike({required String commentId, required bool isLiked}) async {
    try {
      http.Response request =
          await http.post(Uri.parse(EndPoints.likeComment), body: {
        'comment_id': commentId,
        'is_liked': isLiked.toString(),
        'user_id': currentUser!.user!.id.toString()
      });
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);
        return response;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future addComment({required String insightId, required commentBody}) async {
    try {
      http.Response request =
          await http.post(Uri.parse(EndPoints.addComment), body: {
        'insight_id': insightId,
        'comment_body': commentBody,
        'user_id': currentUser!.user!.id.toString()
      });
      if (request.statusCode < 300) {
        var response = jsonDecode(request.body);

        return response;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
