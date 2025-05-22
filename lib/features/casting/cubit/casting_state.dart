 class CastingState {}

 class CastingInitial extends CastingState {}
 class AddNewGigStateLoaded extends CastingState {}
 class AddNewGigStateError extends CastingState {
  final String error;
  AddNewGigStateError(this.error);
 }
 class AddNewGigStateLoading extends CastingState {}
 class CategoryStateError extends CastingState {
 final String errorMessage;

  CategoryStateError(this.errorMessage);
 }
 class CategoryStateLoading extends CastingState {}
 class CategoryStateLoaded extends CastingState {}
 class SubCategoryStateError extends CastingState {
 final String errorMessage;

 SubCategoryStateError(this.errorMessage);
 }
 class SubCategoryStateLoading extends CastingState {}
 class SubCategoryStateLoaded extends CastingState {}
