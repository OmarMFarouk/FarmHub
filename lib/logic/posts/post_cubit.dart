import 'dart:math';

import 'package:farm_hub/logic/posts/post_states.dart';
import 'package:farm_hub/shared/models/insights_model.dart';
import 'package:farm_hub/shared/models/listings_model.dart';
import 'package:farm_hub/shared/network/remote/posts_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_file/platform_file.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(PostInitial());
  static PostCubit get(context) => BlocProvider.of(context);
  var insightForm = GlobalKey<FormState>();
  var listingForm = GlobalKey<FormState>();
  List<PlatformFile> pickedFiles = [];
  int random = Random().nextInt(10);
  InsightModel? insightsModel;
  ListingsModel? listingsModel;
  ListingsModel? searchModel;
  List<dynamic> feedList = [];
  TextEditingController searchCont = TextEditingController();
  TextEditingController titleCont = TextEditingController();
  TextEditingController bodyCont = TextEditingController();
  TextEditingController minimumCont = TextEditingController();
  TextEditingController maximumCont = TextEditingController();
  Future<void> fetchInsights() async {
    emit(PostLoading());
    await PostsApi().fetchInsights().then((res) {
      if (res == null || res == 'error') {
        emit(PostFailure(msg: 'Check Internet Connection'));
      } else if (res['success'] == false) {
        emit(PostFailure(msg: res['message']));
      } else {
        insightsModel = InsightModel.fromJson(res);
        emit(PostInitial());
      }
    });
  }

  pickImage() async {
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      pickedFiles.add(PlatformFile(
          name: file.name,
          path: file.path,
          size: await file.length(),
          bytes: await file.readAsBytes()));
    }
    refreshState();
  }

  Future<void> createInsight() async {
    emit(PostLoading());
    if (pickedFiles.isEmpty) {
      emit(PostFailure(msg: 'No attachements are added.'));
    } else {
      await PostsApi()
          .createInsight(
              body: bodyCont.text.trim(),
              title: titleCont.text.trim(),
              filesData: pickedFiles)
          .then((res) async {
        if (res == null || res == 'error') {
          emit(PostFailure(msg: 'Check Internet Connection'));
        } else if (res['success'] == false) {
          emit(PostFailure(msg: res['message']));
        } else {
          clearConts();
          emit(PostSuccess(msg: res['message']));
          await fetchInsights();
          generateFeedList();
        }
      });
    }
  }

  Future<void> searchListings() async {
    emit(PostLoading());
    await PostsApi()
        .searchListings(keyWord: searchCont.text.trim())
        .then((res) {
      if (res == null || res == 'error') {
        emit(PostFailure(msg: 'Check Internet Connection'));
      } else if (res['success'] == false) {
        emit(PostFailure(msg: res['message']));
      } else {
        searchModel = ListingsModel.fromJson(res);
        emit(PostInitial());
      }
    });
  }

  Future<void> fetchListings() async {
    emit(PostLoading());
    await PostsApi().fetchListings().then((res) {
      if (res == null || res == 'error') {
        emit(PostFailure(msg: 'Check Internet Connection'));
      } else if (res['success'] == false) {
        emit(PostFailure(msg: res['message']));
      } else {
        listingsModel = ListingsModel.fromJson(res);
        emit(PostInitial());
      }
    });
  }

  Future<void> createListing() async {
    emit(PostLoading());
    if (pickedFiles.isEmpty) {
      emit(PostFailure(msg: 'No attachements are added.'));
    } else {
      await PostsApi()
          .createListing(
              body: bodyCont.text.trim(),
              title: titleCont.text.trim(),
              price: '${minimumCont.text}-${maximumCont.text}',
              filesData: pickedFiles)
          .then((res) async {
        if (res == null || res == 'error') {
          emit(PostFailure(msg: 'Check Internet Connection'));
        } else if (res['success'] == false) {
          emit(PostFailure(msg: res['message']));
        } else {
          clearConts();
          emit(PostSuccess(msg: res['message']));
          await fetchListings();
          generateFeedList();
        }
      });
    }
  }

  void generateFeedList() {
    feedList.clear();
    List<dynamic> combinedList = [
      ...insightsModel!.insights!,
      ...listingsModel!.listings!
    ];
    combinedList.shuffle(Random(random));
    feedList = combinedList;
  }

  clearConts() {
    pickedFiles.clear();
    searchModel = null;
    titleCont.clear();
    bodyCont.clear();
    searchCont.clear();
    maximumCont.clear();
    minimumCont.clear();
    refreshState();
  }

  refreshState() {
    emit(PostInitial());
  }
}
