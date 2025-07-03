import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/electronic_wallet/cubit/electronic_wallet_cubit.dart';
import 'package:mawhebtak/features/electronic_wallet/cubit/electronic_wallet_state.dart';
import 'package:mawhebtak/features/electronic_wallet/screens/widgets/shadow.dart';

class ElectronicWalletScreen extends StatefulWidget {
  const ElectronicWalletScreen({super.key,});


  @override
  State<ElectronicWalletScreen> createState() => _ElectronicWalletScreenState();
}

class _ElectronicWalletScreenState extends State<ElectronicWalletScreen> {
  @override
  void initState() {
    context.read<ElectronicWalletCubit>().getWalletTransactionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ElectronicWalletCubit>();
    return SafeArea(child: Scaffold(
      body: BlocBuilder<ElectronicWalletCubit, ElectronicWalletState>(
          builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSimpleAppbar(title: "electronic_wallet".tr()),
            SizedBox(height: 20.h),
            (state is LoadingGetWalletTransactionDataState)
                ? const Center(
                    child: CustomLoadingIndicator(),
                  )
                :

            Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(12.sp)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0.w, vertical: 15.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "current_balance".tr(),
                                      style: getRegularStyle(
                                          fontSize:
                                              11.sp * textScaleFactor(context),
                                          color: AppColors.white),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text(

                                      '${cubit.getWalletTransactionModel?.data?.walletBalance.toString().substring(0,8)?? 0} ${"egp".tr()}',
                                      style: getRegularStyle(
                                          fontSize:
                                              20.sp * textScaleFactor(context),
                                          color: AppColors.white),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              title:
                                                  Text("deposit_process".tr()),
                                              content: TextField(
                                                controller: cubit
                                                    .priceController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      "enter_the_amount".tr(),
                                                  border:
                                                      const OutlineInputBorder(),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    cubit.paymobPay(
                                                        context);
                                                  },
                                                  child: Text("deposit".tr()),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                              20.sp * textScaleFactor(context)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0.w, vertical: 5.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                AppIcons.pushIcon,
                                                color: AppColors.white,
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                "deposit".tr(),
                                                style: getRegularStyle(
                                                  fontSize: 14.sp *
                                                      textScaleFactor(context),
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            String selectedMethod = 'wallet';
                                            List<String> methods = [
                                              'wallet',
                                              'ipa',
                                              'bank'
                                            ];

                                            return StatefulBuilder(
                                              builder: (context, setState) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  title:
                                                      Text("pull_process".tr()),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TextField(
                                                          controller: cubit
                                                              .amountController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                "enter_price"
                                                                    .tr(),
                                                            border:
                                                                const OutlineInputBorder(),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 15),
                                                        DropdownButtonFormField<
                                                            String>(
                                                          value: selectedMethod,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                "choose_the_method"
                                                                    .tr(),
                                                            border:
                                                                const OutlineInputBorder(),
                                                          ),
                                                          items: methods.map(
                                                              (String method) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: method,
                                                              child:
                                                                  Text(method),
                                                            );
                                                          }).toList(),
                                                          onChanged: (String?
                                                              newValue) {
                                                            if (newValue !=
                                                                null) {
                                                              setState(() {
                                                                selectedMethod =
                                                                    newValue;
                                                                cubit.paymentMethodController
                                                                        .text =
                                                                    newValue;
                                                              });
                                                            }
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            height: 15),
                                                        TextField(
                                                          controller: cubit
                                                              .paymentKeyController,
                                                          keyboardType: selectedMethod ==
                                                                      'wallet' ||
                                                                  selectedMethod ==
                                                                      'ipa'
                                                              ? TextInputType
                                                                  .phone
                                                              : TextInputType
                                                                  .text,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: selectedMethod ==
                                                                    'wallet'
                                                                ? 'enter_mobile_number'
                                                                    .tr()
                                                                : selectedMethod ==
                                                                        'ipa'
                                                                    ? 'enter_phone_or_account_number'
                                                                        .tr()
                                                                    : 'enter_iban'
                                                                        .tr(),
                                                            border:
                                                                const OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        cubit.requestWithdraw();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("pull".tr()),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.white.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                              20.sp * textScaleFactor(context)),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0.w, vertical: 5.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                AppIcons.pillIcon,
                                                color: AppColors.white,
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                "pull".tr(),
                                                style: getRegularStyle(
                                                  fontSize: 14.sp *
                                                      textScaleFactor(context),
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "process".tr(),
                          style: getRegularStyle(
                              fontSize: 16.sp, color: AppColors.blackLight),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        (cubit.getWalletTransactionModel?.data
                                    ?.myTransaction?.length ==
                                0)
                            ? Center(child: Text("no_process".tr()))
                            : SingleChildScrollView(
                              child: Expanded(
                                child: ListView.builder(

                                    itemBuilder: (context, index) => Container(
                                        padding: EdgeInsets.all(
                                          10.sp * textScaleFactor(context),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8.sp * textScaleFactor(context),
                                            ),
                                            boxShadow: customShadow),
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.redLight,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    8.sp * textScaleFactor(context),
                                                  )),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Icon(
                                                  Icons.arrow_upward_outlined,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),

                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: getWidthSize(context) /
                                                          1.6,
                                                      child: Text(
                                                        cubit
                                                                .getWalletTransactionModel
                                                                ?.data
                                                                ?.myTransaction?[
                                                                    index]
                                                                .comment ??
                                                            "",
                                                        maxLines: 2,
                                                        style: getRegularStyle(
                                                          color:
                                                              AppColors.blackLight,
                                                          fontSize: 14.sp *
                                                              textScaleFactor(
                                                                  context),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "${cubit.getWalletTransactionModel?.data?.myTransaction?[index].amount ?? ""} ${"egp".tr()}",
                                                      style: getRegularStyle(
                                                        color: AppColors.green,
                                                        fontSize: 14.sp *
                                                            textScaleFactor(
                                                                context),


                                                      ),
                                                    ),




                                                    SizedBox(
                                                      width: 100.w,
                                                    ),
                                                    Text(
                                                      cubit
                                                              .getWalletTransactionModel
                                                              ?.data
                                                              ?.myTransaction?[
                                                                  index]
                                                              .time
                                                              .toString()
                                                              .substring(0, 10) ??
                                                          "",
                                                      style: getRegularStyle(
                                                        color: AppColors.gray,
                                                        fontSize: 14.sp *
                                                            textScaleFactor(
                                                                context),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        )),
                                    itemCount: cubit.getWalletTransactionModel?.data
                                            ?.myTransaction?.length ??
                                        0,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                  ),
                              ),
                            ),
                      ],
                    ),
                  ),
          ],
        );
      }),
    ));
  }
}
