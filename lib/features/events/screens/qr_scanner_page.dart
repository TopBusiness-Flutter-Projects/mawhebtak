import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/events/cubit/event_cubit.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool hasScanned = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EventCubit>();

    return Scaffold(
      appBar: AppBar(title: Text('scan_qR_code'.tr())),
      body: AiBarcodeScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          facing: CameraFacing.back,
        ),

        onDispose: () => debugPrint("QR Scanner disposed"),

          onDetect: (capture) async {
            if (hasScanned) return;


            if (capture.barcodes.isEmpty) return;

            final String? code = capture.barcodes.first.rawValue;
            if (code == null || code.isEmpty) return;

            debugPrint('QR Scanned: $code');

            String? id;
            String? userName;
            String? image;
            String? eventTitle;
            int? paymentMethod;
            int? hasUserPaid;


            try {
              final data = json.decode(code);
              if (data is Map && data.containsKey('id')) {
                id = data['id'].toString();
                userName = data['user_name'].toString();
                image = data['image'].toString();
                paymentMethod = data['payment_method'];
                hasUserPaid = data['has_user_paid'];
                eventTitle = data['event_title'];
                print("dataaaaaaaaaaaa${data}");
              }
            } catch (_) {
              final match = RegExp(r'.*/(\d+)$').firstMatch(code);
              if (match != null) {
                id = match.group(1);
              } else if (int.tryParse(code) != null) {
                id = code;
              }
            }

            if (id == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('invalid_qr_code'.tr())),
              );
              return;
            }

            setState(() => hasScanned = true);
            await Future.delayed(const Duration(milliseconds: 200));
            if (!context.mounted) return;

            await showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: "QR Info",
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (context, animation, secondaryAnimation) {
                return Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                              child: Icon(Icons.cancel, color:AppColors.red, size: 24.sp),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 35.r,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage: image == null
                                    ? const AssetImage(ImageAssets.profileImage) as ImageProvider
                                    : CachedNetworkImageProvider(image),
                              ),
                              SizedBox(width: 10.w,),
                              Flexible(
                                child: Text(

                                  userName ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(

                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16.h),

                          Text(
                            cubit.eventDetails?.data?.title.toString() ?? "",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Divider(thickness: 1, color: Colors.grey.shade300),

                          /// Payment status
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                hasUserPaid == 1 ? Icons.verified : Icons.warning_amber_rounded,
                                color: hasUserPaid == 1 ? Colors.green : Colors.red,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      "${"payment_status".tr()}: ",
                                      style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: Text(
                                        hasUserPaid == 1 ? "paid".tr() : "not_paid".tr(),
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 16.sp,color:hasUserPaid == 1?AppColors.green:AppColors.red ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          /// Payment method
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.account_balance_wallet, color: AppColors.primary),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${"payment_method".tr()} : ",
                                      style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),
                                    ),

                                    Expanded(
                                      child: Text(
                                        ' ${paymentMethod == 0 ? "wallet".tr() : "pay_on_attendance".tr()}',
                                        maxLines: 1,
                                        style: TextStyle(fontSize: 16.sp,color:paymentMethod == 0?AppColors.primary:AppColors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24.h),

                          CustomButton(
                            title: "presence".tr(),
                            onTap: () async {
                              await cubit.scanQrCode(eventFollowerId: id);
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              transitionBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  child: child,
                );
              },
            );






          }

      ),
    );
  }
}
