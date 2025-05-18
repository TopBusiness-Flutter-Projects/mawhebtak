import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/widgets/custom_container_with_shadow.dart';
import 'package:mawhebtak/features/home/cubits/home_cubit/home_cubit.dart';
import 'package:mawhebtak/features/home/cubits/home_cubit/home_state.dart';
import '../../../../core/exports.dart';

class TalentList extends StatelessWidget {
  const TalentList({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        return Stack(
          children: [
            CustomContainerWithShadow(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.h, top: 30.h),
                      child: SizedBox(
                          height: 50.h,
                          width: 50.w,
                          child: Image.asset(
                            ImageAssets.profileImage,
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.w),
                    child: AutoSizeText(
                      "Ahmad Mokhtar",
                      style: getMediumStyle(
                        color: AppColors.black,
                        fontSize: 15.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.w),
                    child: AutoSizeText(
                      "Talent / Actor Expert",
                      style: getRegularStyle(
                        color: AppColors.grayText,
                        fontSize: 15.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.w),
                    child: AutoSizeText(
                      "20 K followers",
                      style: getMediumStyle(
                        color: AppColors.lbny,
                        fontSize: 15.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: FollowButton(
                      isFollowing: true,
                      onChanged: (p0) {},
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 10.sp, // Adjust position as needed
              right: 15.sp, // Adjust position as needed
              child: InkWell(
                  //  onTap: () => cubit.removeImage(index),
                  child: SvgPicture.asset(AppIcons.xIcon)),
            ),
          ],
        );
      },
    );
  }
}

class FollowButton extends StatefulWidget {
  final bool isFollowing;
  final Function(bool)? onChanged;

  const FollowButton({
    super.key,
    this.isFollowing = false,
    this.onChanged,
  });

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late bool _isFollowing;

  @override
  void initState() {
    super.initState();
    _isFollowing = widget.isFollowing;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFollowing = !_isFollowing; // Toggle the follow state
        });
        widget.onChanged?.call(_isFollowing); // Notify parent of the change
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Container(
          height: 40.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
          decoration: BoxDecoration(
            color: _isFollowing
                ? AppColors.primary
                : AppColors.white, // Reverse colors
            borderRadius: BorderRadius.circular(8.r), // Rounded corners
            border: Border.all(
              color: _isFollowing
                  ? Colors.transparent
                  : AppColors.primary, // Reverse border color
              width: 1.5, // Slightly thicker border
            ),
            boxShadow: _isFollowing
                ? null // No shadow when following
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Center(
            child: Text(
              _isFollowing ? "Follow" : "Following", // Reverse text
              style: TextStyle(
                color: _isFollowing
                    ? AppColors.white
                    : AppColors.primary, // Reverse text color
                fontSize: 15.sp,
                fontWeight: FontWeight.w600, // Slightly bolder
              ),
            ),
          ),
        ),
      ),
    );
  }
}
