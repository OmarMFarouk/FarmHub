import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_hub/logic/user/user_states.dart';
import 'package:farm_hub/shared/models/user_model.dart';
import 'package:farm_hub/shared/network/remote/user_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_file/platform_file.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);
  TextEditingController fullNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController orgNameCont = TextEditingController();
  PlatformFile? pickedImage;
  Future<void> fetchUserData() async {
    emit(UserLoading());
    await UserApi().fetchUserData().then((res) {
      if (res == null || res == 'error') {
        emit(UserFailure(msg: 'Check Internet Connection'));
      } else if (res['success'] == false) {
        emit(UserFailure(msg: res['message']));
      } else {
        currentUser = UserModel.fromJson(res);

        emit(UserInitial());
      }
    });
  }

  Future<void> editUserProfile() async {
    emit(UserLoading());
    if (emailCont.text.isEmpty) {
      emailCont.text = currentUser!.user!.email!;
    }
    if (phoneCont.text.isEmpty) {
      phoneCont.text = currentUser!.user!.phone!;
    }
    if (orgNameCont.text.isEmpty) {
      orgNameCont.text = currentUser!.user!.orgName!;
    }
    if (fullNameCont.text.isEmpty) {
      fullNameCont.text = currentUser!.user!.fullName!;
    }
    await UserApi()
        .editUserProfile(
            email: emailCont.text.trim(),
            phone: phoneCont.text.trim(),
            orgName: orgNameCont.text.trim(),
            fullName: fullNameCont.text.trim())
        .then((res) {
      if (res == null || res == 'error') {
        emit(UserFailure(msg: 'Check Internet Connection'));
      } else if (res['success'] == false) {
        emit(UserFailure(msg: res['message']));
      } else {
        fetchUserData();
        clearConts();
        emit(UserSuccess(msg: res['message']));
      }
    });
  }

  pickImage() async {
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      pickedImage = PlatformFile(
          name: file.name,
          size: 0,
          bytes: await file.readAsBytes(),
          path: file.path);
      editUserAvatar();
    }
  }

  Future<void> editUserAvatar() async {
    emit(UserLoading());
    await UserApi().editUserAvatar(file: pickedImage!).then((res) {
      if (res == null || res == 'error') {
        emit(UserFailure(msg: 'Check Internet Connection'));
      } else if (res['success'] == false) {
        emit(UserFailure(msg: res['message']));
      } else {
        if (currentUser!.user!.avatar!.isNotEmpty) {
          CachedNetworkImage.evictFromCache(currentUser!.user!.avatar!);
        }
        fetchUserData();
        emit(UserSuccess(msg: res['message']));
      }
    });
  }

  clearConts() {
    pickedImage = null;
    fullNameCont.clear();
    emailCont.clear();
    orgNameCont.clear();
    phoneCont.clear();
  }

  refreshState() {
    emit(UserInitial());
  }
}

UserModel? currentUser;
