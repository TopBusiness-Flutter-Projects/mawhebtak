import '../../../core/exports.dart';
import '../data/model/package_model.dart';
import '../data/repo/packages_repo.dart';
import 'state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  PackagesCubit(this.api) : super(PackagesStateInitial());
  PackagesRepo api;

  PackagesModel? packagesModel;
  Future<void> getPackagesData() async {
    emit(LoadingGetPackagesState());
    final res = await api.getPackagesData();
    res.fold((l) {
      emit(ErrorGetPackagesState());
    }, (r) {
      packagesModel = r;
      emit(LoadedGetPackagesState());
    });
  }

  // AddAdOfferPackageToLawyerModel? addAdOfferPackageToLawyerModel;
  // Future<void> addAdOfferPackageToLawyer({
  //   required String packageId,
  // }) async {
  //   emit(LoadingAddAdOfferPackageToLawyerState());
  //   final res = await api.addAdOfferPackagesToLawyer(
  //     packageId: packageId,
  //   );
  //   res.fold((l) {
  //     emit(ErrorAddAdOfferPackageToLawyerState());
  //   }, (r) {
  //     if (r.status == 200) {
  //       successGetBar(r.msg ?? "");
  //     } else {
  //       errorGetBar(r.msg ?? "");
  //     }
  //     addAdOfferPackageToLawyerModel = r;
  //     emit(LoadedAddAdOfferPackageToLawyersState());
  //   });
  // }
}
