import 'package:mawhebtak/core/models/default_model.dart';

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

  Future<void> subscribeToPackage({
    required String packageId,
    required BuildContext context,
  }) async {
    try {
      emit(LoadingSubscribeToPackageState());
      final res = await api.subscribeToPackage(
        packageId: packageId,
      );
      res.fold((l) {
        emit(ErrorSubscribeToPackageState());
      }, (r) {
        if (r.status == 200) {
          successGetBar(r.msg ?? "");
          Navigator.pop(context);
        } else {
          errorGetBar(r.msg ?? "");
          Navigator.pop(context);
        }

        emit(LoadedSubscribeToPackageState());
      });
    } catch (e) {
      errorGetBar(e.toString());
    }
  }
}
