import 'dart:developer';

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_state.dart';
import 'package:mawhebtak/features/auth/new_account/data/repos/new_account.repo.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../profile/cubit/profile_cubit.dart';
import '../../verification/cubit/verification_cubit.dart';
import '../data/model/user_types.dart';

class NewAccountCubit extends Cubit<NewAccountState> {
  NewAccountCubit(this.api) : super(NewAccountInitial());
  NewAccount api;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  GetCountriesMainModelData? selectedUserType;
  GetCountriesMainModelData? selectedUserSubType;
  MainRegisterUserTypes? userTypeList;
  MainRegisterUserTypes? userSubTypeList;
  String countryCode = '+20';

  getDataUserType(BuildContext context,
      {GetCountriesMainModelData? userTypeModel, bool? isEditProfile}) async {
    emit(LoadingGetUserTypesState());
    var response = await api.getDataUserType();
    response.fold((l) {
      emit(ErrorGetUserTypesState('error_msg'.tr()));
    }, (r) {
      userTypeList = r;
      selectedUserSubType = null;
      if (userTypeModel != null) {
        for (int i = 0; i < (userTypeList?.data?.length ?? 0); i++) {
          if (userTypeList?.data?[i].id?.toString() ==
              userTypeModel?.id?.toString()) {
            selectedUserType = userTypeList?.data?[i];
          }
          // else{
          //   selectedUserType = null;
          // }
        }
      }

      if (isEditProfile == true) {
        getDataUserSubType(
            userTypeId: selectedUserType?.id?.toString() ?? '',
            currentSubCategory:
                context.read<ProfileCubit>().profileModel?.data?.userSubType);
      }
      emit(LoadedGetUserTypesState(r));
    });
  }

  getDataUserSubType({
    required String userTypeId,
    GetCountriesMainModelData? currentSubCategory,
  }) async {
    emit(LoadingGetUserSubTypesState());
    var response = await api.getDataUserSubType(userTypeId: userTypeId);
    response.fold((l) {
      emit(ErrorGetUserSubTypesState('error_msg'.tr()));
    }, (r) {
      userSubTypeList = r;
      if (currentSubCategory != null) {
        for (int i = 0; i < (userSubTypeList?.data?.length ?? 0); i++) {
          if (userSubTypeList?.data?[i].id?.toString() ==
              currentSubCategory.id?.toString()) {
            selectedUserSubType = userSubTypeList?.data?[i];
          }
        }
      }
      emit(LoadedGetUserSubTypesState(r));
    });
  }

  register(BuildContext context) async {
    emit(LoadingAddNewAccountState());
    var response = await api.register(
        emailAddressController.text,
        fullNameController.text,
        passwordController.text,
        countryCode + mobileNumberController.text,
        selectedUserType?.id?.toString(),
        selectedUserSubType?.id?.toString());
    response.fold((l) {
      emit(ErrorAddNewAccountState('error_msg'.tr()));
    }, (r) async {
      if (r.status == 200 || r.status == 201) {
        successGetBar(r.msg);
        Navigator.pop(context);
        if (r.data?.isRegister == 1) {
          log(" Register");
          Navigator.pushReplacementNamed(context, Routes.addReferralCodeRoute);
        } else {
          Navigator.pushReplacementNamed(context, Routes.mainRoute);
        }
        await Preferences.instance.setUser(r);
        emailAddressController.clear();
        fullNameController.clear();
        passwordController.clear();
        mobileNumberController.clear();
        context.read<VerificationCubit>().pinController.clear();

        emit(LoadedAddNewAccountState());
      } else {
        errorGetBar(r.msg ?? '');

        emit(ErrorAddNewAccountState('error_msg'.tr()));
      }
    });
  }
}
