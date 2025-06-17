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
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/events/screens/details_event_screen.dart';

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
    context.read<NewAccountCubit>().getDataUserType(
      context,
      isEditProfile: true,
      userTypeModel: context.read<ProfileCubit>().profileModel?.data?.userType,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            var cubit = context.read<ProfileCubit>();
            return (state is GetProfileStateLoading && cubit.profileModel == null) ?
               const Center(child: CustomLoadingIndicator())
            :
             _buildProfileContent(context);
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    final newAccountCubit = context.read<NewAccountCubit>();

    return Column( // Removed Stack
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileAppBar(
          isEdit: true,
          id: widget.model.id,
          avatar: cubit.profileModel?.data?.avatar ?? "",
          byCaver: cubit.profileModel?.data?.bgCover ?? "",
        ),
        SizedBox(height: 20.h),
        _buildNameField(cubit),
        Container(height: 8.h, color: AppColors.grayLite),
        Container(height: 20.h, color: AppColors.white),
        _buildHeadlineSection(cubit),
        Container(height: 8.h, color: AppColors.grayLite),
        Container(height: 20.h, color: AppColors.white),
        _buildBioSection(cubit),
        Container(height: 8.h, color: AppColors.grayLite),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, top: 10.h, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildPersonalInfoHeader(),
                  _buildEmailField(cubit),
                  _buildPhoneField(cubit),
                  _buildAgeField(cubit),
                  _buildGenderDropdown(cubit),
                  _buildUserTypeDropdown(newAccountCubit),
                  if ((newAccountCubit.userSubTypeList?.data?.isNotEmpty ?? false))
                    _buildUserSubTypeDropdown(newAccountCubit),
                  _buildLocationSection(cubit),
                  _buildSyndicateField(cubit),
                ],
              ),
            ),
          ),
        ),
        _buildSaveButton(context, cubit),
      ],
    );
  }



  Widget _buildNameField(ProfileCubit cubit) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: TextField(
        controller: cubit.nameController,
        decoration: const InputDecoration(
          hintText: "write your name",
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        style: getRegularStyle(),
      ),
    );
  }

  Widget _buildHeadlineSection(ProfileCubit cubit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.h),
        CustomRowSection(title: "headline".tr()),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: TextField(
            controller: cubit.headlineController,
            style: getRegularStyle(),
            decoration: const InputDecoration(
              hintText: "write your headline",
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBioSection(ProfileCubit cubit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.h),
        CustomRowSection(title: "bio".tr()),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: TextField(
            controller: cubit.bioController,
            decoration: const InputDecoration(
              hintText: "write your bio",
              border: InputBorder.none,
            ),
            style: getRegularStyle(),
          ),
        )
      ],
    );
  }

  Widget _buildPersonalInfoHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Text(
          "personal_info".tr(),
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.darkGray,
              fontSize: 18.sp),
        ),
      ],
    );
  }

  Widget _buildEmailField(ProfileCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "email_address".tr(),
          style: TextStyle(color: AppColors.darkGray, fontSize: 16.sp),
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
            child: SvgPicture.asset(AppIcons.emailIcon),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField(ProfileCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "phone".tr(),
          style: TextStyle(color: AppColors.darkGray, fontSize: 16.sp),
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
      ],
    );
  }

  Widget _buildAgeField(ProfileCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "age".tr(),
          style: TextStyle(color: AppColors.darkGray, fontSize: 16.sp),
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
      ],
    );
  }

  Widget _buildGenderDropdown(ProfileCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
          child: Text(
            "gender".tr(),
            style: TextStyle(color: AppColors.darkGray, fontSize: 16.sp),
          ),
        ),
        GeneralCustomDropdownButtonFormField(
          itemBuilder: (item) => item ?? '',
          value: cubit.selectedGender,
          items: cubit.gender ?? [],
          onChanged: (value) {
            cubit.selectedGender = value;
          },
        ),
      ],
    );
  }

  Widget _buildUserTypeDropdown(NewAccountCubit cubit) {
    return BlocBuilder<NewAccountCubit, NewAccountState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
              child: Text(
                "user_type".tr(),
                style: TextStyle(color: AppColors.darkGray, fontSize: 16.sp),
              ),
            ),
            GeneralCustomDropdownButtonFormField(
              itemBuilder: (item) => item.name ?? '',
              value: cubit.selectedUserType,
              items: cubit.userTypeList?.data ?? [],
              onChanged: (value) {
                cubit.selectedUserType = value;
                cubit.getDataUserSubType(
                    userTypeId: cubit.selectedUserType?.id.toString() ?? '');
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildUserSubTypeDropdown(NewAccountCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
          child: Text(
            "user_sub_type".tr(),
            style: TextStyle(color: AppColors.darkGray, fontSize: 16.sp),
          ),
        ),
        GeneralCustomDropdownButtonFormField(
          itemBuilder: (item) => item.name ?? '',
          value: cubit.selectedUserSubType,
          items: cubit.userSubTypeList?.data ?? [],
          onChanged: (value) {
            cubit.selectedUserSubType = value;
          },
        ),
      ],
    );
  }

  Widget _buildLocationSection(ProfileCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
          child: Text(
            "location".tr(),
            style: TextStyle(color: AppColors.darkGray, fontSize: 16.sp),
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
                  builder: (context) =>  FullScreenMap(type: 'edit_profile'),
                ),
              );
            },
            child: Text(
              "open_map".tr(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSyndicateField(ProfileCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "syndicate".tr(),
          style: TextStyle(color: AppColors.darkGray, fontSize: 16.sp),
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
    );
  }

  Widget _buildSaveButton(BuildContext context, ProfileCubit cubit) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 20.h, bottom: 10.h),
      child: CustomButton(
        title: "save".tr(),
        onTap: () {
          cubit.updateProfileData(context: context, profileId: widget.model.id);
        },
      ),
    );
  }
}