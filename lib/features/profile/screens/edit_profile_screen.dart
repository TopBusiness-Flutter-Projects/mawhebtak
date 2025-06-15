import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/core/widgets/dropdown_button_form_field.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_cubit.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_state.dart';
import 'package:mawhebtak/features/location/cubit/location_cubit.dart';
import 'package:mawhebtak/features/location/cubit/location_state.dart';
import 'package:mawhebtak/features/location/screens/full_screen_map.dart';
import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';
import 'package:mawhebtak/features/profile/screens/widgets/about_widgets/custom_row_section.dart';
import 'package:mawhebtak/features/profile/screens/widgets/profile_app_bar.dart';
import '../../../core/exports.dart';
import '../../events/screens/details_event_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.model});
  final DeepLinkDataModel model;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    context.read<ProfileCubit>().loadUserFromPreferences();
    context.read<NewAccountCubit>().getDataUserType(context,
        isEditProfile: true,
        userTypeModel:
            context.read<ProfileCubit>().profileModel?.data?.userType);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (BuildContext context, state) {
        var cubit = context.read<ProfileCubit>();

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            body: (state is GetProfileStateLoading &&
                    cubit.profileModel == null)
                ? const Center(
                    child: CustomLoadingIndicator(),
                  )
                : Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileAppBar(
                            isEdit: true,
                            id: widget.model.id,
                            avatar: cubit.profileModel?.data?.avatar ?? "",
                            byCaver: cubit.profileModel?.data?.bgCover ?? "",
                          ),
                          SizedBox(height: 20.h),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: cubit.nameController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  style: getRegularStyle(),
                                ),
                                TextField(
                                  controller: cubit.headlineController,
                                  style: getRegularStyle(),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                                TextField(
                                  controller: cubit.locationController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  style: getRegularStyle(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Container(height: 8.h, color: AppColors.grayLite),
                          Container(height: 20.h, color: AppColors.white),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              CustomRowSection(
                                title: "bio".tr(),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.w, right: 10.w),
                                child: TextField(
                                  controller: cubit.bioController,
                                  canRequestFocus: false,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: getRegularStyle(),
                                ),
                              )
                            ],
                          ),
                          Container(
                              height: 8.h,
                              color: AppColors.grayLite,
                              width: double.infinity),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20.w, top: 10.h, right: 20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      "personal_info".tr(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.darkGray,
                                          fontSize: 18.sp),
                                    ),
                                    Text(
                                      "email_address".tr(),
                                      style: TextStyle(
                                          color: AppColors.darkGray,
                                          fontSize: 16.sp),
                                    ),
                                    CustomTextField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please_enter_email'.tr();
                                        }
                                        return null;
                                      },
                                      controller: cubit.emailController,
                                      hintTextSize: 16.sp,
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.all(10.0.h),
                                        child: SvgPicture.asset(
                                          AppIcons.emailIcon,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "phone".tr(),
                                      style: TextStyle(
                                          color: AppColors.darkGray,
                                          fontSize: 16.sp),
                                    ),
                                    CustomTextField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please_enter_phone'.tr();
                                        }
                                        return null;
                                      },
                                      controller: cubit.phoneController,
                                      hintTextSize: 16.sp,
                                    ),
                                    Text(
                                      "age".tr(),
                                      style: TextStyle(
                                          color: AppColors.darkGray,
                                          fontSize: 16.sp),
                                    ),
                                    CustomTextField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please_enter_age'.tr();
                                        }
                                        return null;
                                      },
                                      controller: cubit.ageController,
                                      hintTextSize: 16.sp,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.h, bottom: 10.h),
                                      child: Text(
                                        "gender".tr(),
                                        style: TextStyle(
                                            color: AppColors.darkGray,
                                            fontSize: 16.sp),
                                      ),
                                    ),
                                    GeneralCustomDropdownButtonFormField(
                                      itemBuilder: (item) {
                                        return item ?? '';
                                      },
                                      value: cubit.selectedGender,
                                      items: cubit.gender ?? [],
                                      onChanged: (value) {
                                        cubit.selectedGender = value;
                                      },
                                    ),
                                    BlocBuilder<NewAccountCubit,
                                            NewAccountState>(
                                        builder: (context, state) {
                                      var newAccountCubit =
                                          context.read<NewAccountCubit>();
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 10.h, bottom: 10.h),
                                            child: Text(
                                              "user_type".tr(),
                                              style: TextStyle(
                                                  color: AppColors.darkGray,
                                                  fontSize: 16.sp),
                                            ),
                                          ),
                                          GeneralCustomDropdownButtonFormField(
                                            itemBuilder: (item) =>
                                                item.name ?? '',
                                            value: newAccountCubit
                                                .selectedUserType,
                                            items: newAccountCubit
                                                    .userTypeList?.data ??
                                                [],
                                            onChanged: (value) {
                                              newAccountCubit.selectedUserType =
                                                  value;

                                              newAccountCubit.getDataUserSubType(
                                                  userTypeId: newAccountCubit
                                                          .selectedUserType?.id
                                                          .toString() ??
                                                      '');
                                            },
                                          ),
                                          if ((newAccountCubit.userSubTypeList
                                                  ?.data?.isNotEmpty ??
                                              false))
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10.h, bottom: 10.h),
                                              child: Text(
                                                "user_sub_type".tr(),
                                                style: TextStyle(
                                                    color: AppColors.darkGray,
                                                    fontSize: 16.sp),
                                              ),
                                            ),
                                          if ((newAccountCubit.userSubTypeList
                                                  ?.data?.isNotEmpty ??
                                              false))
                                            GeneralCustomDropdownButtonFormField(
                                              itemBuilder: (item) =>
                                                  item.name ?? '',
                                              value: newAccountCubit
                                                  .selectedUserSubType,
                                              items: newAccountCubit
                                                      .userSubTypeList?.data ??
                                                  [],
                                              onChanged: (value) {
                                                newAccountCubit
                                                        .selectedUserSubType =
                                                    value;
                                              },
                                            ),
                                        ],
                                      );
                                    }),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.h, bottom: 10.h),
                                      child: Text(
                                        "location".tr(),
                                        style: TextStyle(
                                            color: AppColors.darkGray,
                                            fontSize: 16.sp),
                                      ),
                                    ),
                                    BlocBuilder<LocationCubit, LocationState>(
                                      builder: (context, state) {
                                        return CustomTextField(
                                          hintTextSize: 18.sp,
                                          controller: cubit.locationController,
                                          validator: (p0) {
                                            if (p0!.isEmpty) {
                                              return 'select_location'.tr();
                                            }
                                            return null;
                                          },
                                          hintText: "select_location".tr(),
                                        );
                                      },
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FullScreenMap(
                                                        type: 'edit_profile',
                                                      )));
                                        },
                                        child: Text(
                                          "open_map".tr(),
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primary,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "syndicate".tr(),
                                      style: TextStyle(
                                          color: AppColors.darkGray,
                                          fontSize: 16.sp),
                                    ),
                                    CustomTextField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please_enter_syndicate'.tr();
                                        }
                                        return null;
                                      },
                                      controller: cubit.syndicateController,
                                      hintText: "1772426664",
                                      hintTextSize: 16.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 20.w,
                                left: 20.w,
                                top: 20.h,
                                bottom: 10.h),
                            child: CustomButton(
                              title: "save".tr(),
                              onTap: () {
                                cubit.updateProfileData(
                                    context: context,
                                    profileId: widget.model.id);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
