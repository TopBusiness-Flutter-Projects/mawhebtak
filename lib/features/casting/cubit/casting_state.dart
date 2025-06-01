 import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
import 'package:mawhebtak/features/casting/data/model/get_datails_gigs_model.dart';
import 'package:mawhebtak/features/casting/data/model/get_gigs_from_sub_category_model.dart';

class CastingState {}

 class CastingInitial extends CastingState {}
 class AddNewGigStateLoaded extends CastingState {}
 class AddNewGigStateError extends CastingState {
  final String error;
  AddNewGigStateError(this.error);
 }
 class AddNewGigStateLoading extends CastingState {}
 class CategoryFromGigsStateError extends CastingState {
 final String errorMessage;

  CategoryFromGigsStateError(this.errorMessage);
 }
 class CategoryFromGigsStateLoading extends CastingState {}
 class CategoryFromGigsStateLoaded extends CastingState {
 final GetCountriesMainModel? getCountriesMainModel;

  CategoryFromGigsStateLoaded(this.getCountriesMainModel);

 }
 class SubCategoryStateError extends CastingState {
 final String errorMessage;

 SubCategoryStateError(this.errorMessage);
 }
 class SubCategoryStateLoading extends CastingState {}
 class SubCategoryStateLoaded extends CastingState {
  final GetCountriesMainModel? getCountriesMainModel;

  SubCategoryStateLoaded(this.getCountriesMainModel);

 }
 class GigsFromCategoryStateLoading extends CastingState {}
 class GigsFromCategoryStateLoaded extends CastingState {
  final GetGigsFromSubCategoryModel? gigsFromSubCategoryModel;

  GigsFromCategoryStateLoaded(this.gigsFromSubCategoryModel);

 }
 class GigsFromCategoryStateError extends CastingState {
  final String errorMessage;

  GigsFromCategoryStateError(this.errorMessage);
 }
 class DetailsGigsStateLoading extends CastingState {}
 class ActionGigStateLoading extends CastingState {}
 class ActionGigStateLoaded extends CastingState {}
 class ActionGigStateError extends CastingState {
 final String errorMessage;
  ActionGigStateError(this.errorMessage);
 }
 class DetailsGigsStateLoaded extends CastingState {
  final GetDetailsGigsModel? getDetailsGigsModel;
  DetailsGigsStateLoaded(this.getDetailsGigsModel);

 }
 class DetailsGigsStateError extends CastingState {
  final String errorMessage;

  DetailsGigsStateError(this.errorMessage);
 }
 class RequestGigStateError extends CastingState {final String errorMessage;RequestGigStateError(this.errorMessage); }
 class RequestGigStateLoaded extends CastingState {}
 class RequestGigStateLoading extends CastingState {}
 class FollowAndUnFollowStateError extends CastingState {
 final String errorMessage;
 FollowAndUnFollowStateError(this.errorMessage); }
 class FollowAndUnFollowStateLoaded extends CastingState {}
 class FollowAndUnFollowStateLoading extends CastingState {}