

class PaymobPayModel {
    bool? success;
    String? paymentUrl;
    int? orderId;

    PaymobPayModel({
        this.success,
        this.paymentUrl,
        this.orderId,
    });

    factory PaymobPayModel.fromJson(Map<String, dynamic> json) => PaymobPayModel(
        success: json["success"],
        paymentUrl: json["payment_url"],
        orderId: json["order_id"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "payment_url": paymentUrl,
        "order_id": orderId,
    };
}
