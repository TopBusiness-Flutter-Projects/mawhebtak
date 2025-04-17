import 'package:mawhebtak/core/exports.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const StepIndicator({
    Key? key,
    required this.currentStep,
    required this.steps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: _buildStepCircles(),
          ),
          SizedBox(height: 8.h),
          Row(
            children: _buildStepLabels(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStepCircles() {
    List<Widget> stepCircles = [];

    for (int i = 0; i < steps.length; i++) {
      // Add step circle
      stepCircles.add(
        Expanded(
          child: Center(
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i < currentStep ? AppColors.green : const Color(0xFFDDDDDD),
              ),
              child: Center(
                child: Text(
                  (i + 1).toString().padLeft(2, '0'),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      if (i < steps.length - 1) {
        stepCircles.add(
          Expanded(
            child: Container(
              height: 1.h,
              color: Colors.grey.shade300,
            ),
          ),
        );
      }
    }

    return stepCircles;
  }

  List<Widget> _buildStepLabels() {
    List<Widget> stepLabels = [];

    for (int i = 0; i < steps.length; i++) {
      // Add step label
      stepLabels.add(
        Expanded(
          child: Center(
            child: Text(
              steps[i],
              style: TextStyle(
                color: i < currentStep ? Colors.black87 : Colors.grey.shade600,
                fontWeight: i < currentStep ? FontWeight.w500 : FontWeight.normal,
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

      // Add empty space for alignment with lines above (except after the last one)
      if (i < steps.length - 1) {
        stepLabels.add(
          const Expanded(
            child: SizedBox(),
          ),
        );
      }
    }

    return stepLabels;
  }
}

// Arabic version if needed
class StepIndicatorArabic extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const StepIndicatorArabic({
    Key? key,
    required this.currentStep,
    required this.steps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: _buildStepCircles(),
            ),
            SizedBox(height: 8.h),
            Row(
              children: _buildStepLabels(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStepCircles() {
    List<Widget> stepCircles = [];

    for (int i = 0; i < steps.length; i++) {
      // Add step circle
      stepCircles.add(
        Expanded(
          child: Center(
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i < currentStep ? AppColors.green : const Color(0xFFDDDDDD),
              ),
              child: Center(
                child: Text(
                  (i + 1).toString().padLeft(2, '0'),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // Add connecting line between circles (except after the last one)
      if (i < steps.length - 1) {
        stepCircles.add(
          Expanded(
            child: Container(
              height: 1.h,
              color: Colors.grey.shade300,
            ),
          ),
        );
      }
    }

    return stepCircles;
  }

  List<Widget> _buildStepLabels() {
    List<Widget> stepLabels = [];

    for (int i = 0; i < steps.length; i++) {
      // Add step label
      stepLabels.add(
        Expanded(
          child: Center(
            child: Text(
              steps[i],
              style: TextStyle(
                color: i < currentStep ? Colors.black87 : Colors.grey.shade600,
                fontWeight: i < currentStep ? FontWeight.w500 : FontWeight.normal,
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

      // Add empty space for alignment with lines above (except after the last one)
      if (i < steps.length - 1) {
        stepLabels.add(
          const Expanded(
            child: SizedBox(),
          ),
        );
      }
    }

    return stepLabels;
  }
}