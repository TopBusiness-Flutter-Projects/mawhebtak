abstract class PackagesState {}

class PackagesStateInitial extends PackagesState {}

class LoadingGetPackagesState extends PackagesState {}

class LoadedGetPackagesState extends PackagesState {}

class ErrorGetPackagesState extends PackagesState {}
class LoadedSubscribeToPackageState extends PackagesState {}
class ErrorSubscribeToPackageState extends PackagesState {}
class LoadingSubscribeToPackageState extends PackagesState {}
