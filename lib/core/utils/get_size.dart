
import '../exports.dart';

double getWidthSize(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

double getHeightSize(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}

double getHorizontalPadding(BuildContext context) {
  return 20.w;
}

double getSize(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
double getheightSize(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
double getVerticalPadding(BuildContext context) {
  return 20.h;
}
