import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/widgets/custom_simple_appbar.dart';
import 'package:mawhebtak/features/verification/cubit/verification_cubit.dart';
import 'package:mawhebtak/features/verification/cubit/verification_state.dart';
import 'package:pinput/pinput.dart';

import '../../../core/exports.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<VerificationCubit>();
    return  SafeArea(
      child: Scaffold(
        body: Column(
          children: [
           CustomSimpleAppbar(title: "verification".tr()),
      BlocBuilder<VerificationCubit,VerificationState>(

        builder: (context,state) {
          return Pinput(
            controller: cubit.pinController, // Attach the controller
            length: 6,
            defaultPinTheme: PinTheme(
              width: 40.w,
              height: 40.w,
              textStyle: getMediumStyle(
                fontSize: 14.sp,
                color: AppColors.primary,
              ),
              decoration: BoxDecoration(
                color: AppColors.grayLite,
                shape: BoxShape.rectangle,
                border: Border.all(color: AppColors.primary, width: 2),
              ),
            ),
            focusedPinTheme: PinTheme(
              width: 40.w,
              height: 40.w,
              textStyle: getMediumStyle(
                fontSize: 14.sp,
                color: AppColors.primary,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.rectangle,
                border: Border.all(color: AppColors.primary, width: 2),
              ),
            ),
            showCursor: true,
            validator: (v) {
              if (v!.length < 5) {
                return 'Pin must be 5 digits';
              }
              return null;
            },
            onCompleted: (pin) {
              print("Entered PIN: $pin");
            },
          );
        }
      )
          ],
        ),
      ),
    );
  }
}
