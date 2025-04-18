import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/features/home/cubit/home_cubit.dart';
import 'package:mawhebtak/features/home/cubit/home_state.dart';
import '../../../../core/exports.dart';




class TalentList extends StatelessWidget {
  const TalentList({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        return Stack(

          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Image and Remove Button (now positioned top-right)
                    ClipOval(
                      child: Container(
                        width: 50.w, // Adjust size as needed
                        height: 50.h, // Adjust size as needed
                        decoration: BoxDecoration(
                          color: AppColors.grayLite, // Placeholder color
                          image: const DecorationImage(
                            image: AssetImage(ImageAssets.profileImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Talent Name
                    Text(
                      "Ahmd Mokhtar",
                      style: getSemiBoldStyle(
                        color: AppColors.black,
                        fontSize: 12.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 4.h),

                    // Talent Role
                    Text(
                      "Talent / Actor Expert",
                      style: getRegularStyle(
                        color: AppColors.grayText,
                        fontSize: 12.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 10.h),

                    // Followers Count
                    Text(
                      "20 K followers",
                      style: getMediumStyle(
                        color: AppColors.green,
                        fontSize: 12.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 5.h),

                    // Follow Button with improved styling
                    FollowButton(
                      isFollowing: false,
                      onChanged: (isFollowing) {
                        // Handle follow state change
                        // context.read<HomeCubit>().toggleFollowStatus(index, isFollowing);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20, // Adjust position as needed
              right: 20, // Adjust position as needed
              child: InkWell(
                onTap: () => cubit.removeImage(index),
                child: Container(

                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppColors.grayLite,
                    shape: BoxShape.circle,

                  ),
                  child: SvgPicture.asset(
                    AppIcons.removeIcon,
                    width: 16.w,
                    height: 16.h,
                  ),
                ),
              ),
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
      child: Container(
        width: 100.w, // Fixed width for consistent sizing
        padding: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
          color: _isFollowing ? AppColors.primary : AppColors.white, // Reverse colors
          borderRadius: BorderRadius.circular(8.r), // Rounded corners
          border: Border.all(
            color: _isFollowing ? Colors.transparent : AppColors.primary, // Reverse border color
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
              color: _isFollowing ? AppColors.white : AppColors.primary, // Reverse text color
              fontSize: 12.sp,
              fontWeight: FontWeight.w600, // Slightly bolder
            ),
          ),
        ),
      ),
    );
  }
}