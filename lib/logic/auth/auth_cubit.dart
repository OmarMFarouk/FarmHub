import 'package:farm_hub/shared/models/user_model.dart';
import 'package:farm_hub/shared/network/remote/auth_api.dart';
import 'package:farm_hub/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  TextEditingController pinCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController nameCont = TextEditingController();
  TextEditingController orgNameCont = TextEditingController();
  TextEditingController locationCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  var pinForm = GlobalKey<FormState>();
  var forgetForm = GlobalKey<FormState>();
  var loginForm = GlobalKey<FormState>();
  var registerForm = GlobalKey<FormState>();

  User? user;
  bool isVisible = true;
  loginUser() async {
    emit(AuthLoading());
    user = User(credential: credentialCont.text, password: passwordCont.text);
    await AuthApi().loginUser(user: user!).then((res) async {
      if (res == null || res == 'error') {
        emit(AuthError(msg: 'Check Internet Connection'));
      } else if (res['success'] == false) {
        emit(AuthError(msg: res['message']));
      } else {
        emit(AuthSuccess(msg: res['message']));
        saveAndClear(res['user_id']);
      }
    });
  }

  registerUser() async {
    emit(AuthLoading());
    user = User(
        fullName: nameCont.text.trim(),
        password: passwordCont.text,
        email: emailCont.text,
        location: locationCont.text.trim(),
        orgName: orgNameCont.text.trim(),
        phone: phoneCont.text.trim());
    await AuthApi().registerUser(user: user!).then((res) {
      if (res == null || res == 'error') {
        emit(AuthError(msg: 'Check Internet Connection'));
      } else if (res['success'] == false) {
        emit(AuthError(msg: res['message']));
      } else {
        saveAndClear(res['user_id'].toString());
        emit(AuthSuccess(msg: res['message']));
      }
    });
  }

  handleOTP() async {
    emit(AuthLoading());

    await AuthApi().handleOTP(email: credentialCont.text.trim()).then((res) {
      if (res == null || res == 'error') {
        emit(AuthError(msg: 'Check Internet Connection'));
      } else if (res['success'] == false) {
        emit(AuthError(msg: res['message']));
      } else {
        otp = res['otp_code'];
        print(otp);
        emit(AuthSuccess(msg: res['message']));
      }
    });
  }

  checkOTP() async {
    emit(AuthLoading());
    if (otp == null) {
      emit(AuthError(msg: 'Check Internet Connection'));
    } else if (otp == pinCont.text) {
      emit(AuthSuccess(msg: 'Successfully confirmed pin code!'));
    } else {
      emit(AuthError(msg: 'Pin code mismatch.'));
    }
  }

  changePassword({required String password}) async {
    emit(AuthLoading());

    await AuthApi()
        .changePassword(password: password, email: credentialCont.text.trim())
        .then((res) {
      if (res == null || res == 'error') {
        emit(AuthError(msg: 'Check Internet Connection'));
      } else if (res['success'] == false) {
        emit(AuthError(msg: res['message']));
      } else {
        emit(AuthSuccess(msg: res['message']));
      }
    });
  }

  saveAndClear(uid) async {
    passwordCont.clear();
    emailCont.clear();
    locationCont.clear();
    phoneCont.clear();
    credentialCont.clear();
    orgNameCont.clear();
    nameCont.clear();
    CacheHelper.saveData(key: 'active', value: true);
    CacheHelper.saveData(key: 'user_id', value: uid);
  }

  togglePassword() {
    isVisible = !isVisible;
    refreshState();
  }

  refreshState() {
    emit(AuthRefresh());
  }
}

String? otp;
TextEditingController credentialCont = TextEditingController();
