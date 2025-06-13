
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_state.dart';
import 'package:mawhebtak/features/auth/new_account/data/repos/new_account.repo.dart';
import '../../../../config/routes/app_routes.dart';
import '../../verification/cubit/verification_cubit.dart';
import '../data/model/user_types.dart';

class NewAccountCubit extends Cubit<NewAccountState> {
  NewAccountCubit(this.api) : super(NewAccountInitial());
  NewAccount api;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  MainRegisterUserTypesData? selectedUserType;
  MainRegisterUserTypes? userTypeList;
  getDataUserType() async {
    emit(LoadingGetUserTypesState());
    var response = await api.getDataUserType();
    response.fold((l) {
      emit(ErrorGetUserTypesState('error_msg'.tr()));
    }, (r) {
      userTypeList = r;
      emit(LoadedGetUserTypesState(r));
    });
  }

  register(BuildContext context) async {
    emit(LoadingAddNewAccountState());
    var response = await api.register(
      emailAddressController.text,
      fullNameController.text,
      passwordController.text,
      mobileNumberController.text,
      selectedUserType?.id?.toString(),
    );
    response.fold((l) {
      emit(ErrorAddNewAccountState('error_msg'.tr()));
    }, (r) async {
      if (r.status == 200 || r.status == 201) {
        successGetBar(r.msg);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
        await Preferences.instance.setUser(r);
        emailAddressController.clear();
        fullNameController.clear();
        passwordController.clear();
        mobileNumberController.clear();
        context.read<VerificationCubit>().pinController.clear();

        emit(LoadedAddNewAccountState());
      } else {
        emit(ErrorAddNewAccountState('error_msg'.tr()));
      }
    });
  }

}
