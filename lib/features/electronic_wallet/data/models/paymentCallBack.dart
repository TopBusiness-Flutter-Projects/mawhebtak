

class PaymentCallBackModel {
    int? id;
    bool? pending;
    int? amountCents;
    bool? success;
    bool? isAuth;
    bool? isCapture;
    bool? isStandalonePayment;
    bool? isVoided;
    bool? isRefunded;
    bool? is3DSecure;
    int? integrationId;
    int? profileId;
    bool? hasParentTransaction;
    Order? order;
    DateTime? createdAt;
    List<TransactionProcessedCallbackResponse>? transactionProcessedCallbackResponses;
    String? currency;
    SourceData? sourceData;
    String? apiSource;
    dynamic terminalId;
    int? merchantCommission;
    dynamic installment;
    List<dynamic>? discountDetails;
    bool? isVoid;
    bool? isRefund;
    Data? data;
    bool? isHidden;
    PaymentKeyClaims? paymentKeyClaims;
    bool? errorOccured;
    bool? isLive;
    dynamic otherEndpointReference;
    int? refundedAmountCents;
    int? sourceId;
    bool? isCaptured;
    int? capturedAmount;
    dynamic merchantStaffTag;
    DateTime? updatedAt;
    bool? isSettled;
    bool? billBalanced;
    bool? isBill;
    int? owner;
    dynamic parentTransaction;
    String? uniqueRef;

    PaymentCallBackModel({
        this.id,
        this.pending,
        this.amountCents,
        this.success,
        this.isAuth,
        this.isCapture,
        this.isStandalonePayment,
        this.isVoided,
        this.isRefunded,
        this.is3DSecure,
        this.integrationId,
        this.profileId,
        this.hasParentTransaction,
        this.order,
        this.createdAt,
        this.transactionProcessedCallbackResponses,
        this.currency,
        this.sourceData,
        this.apiSource,
        this.terminalId,
        this.merchantCommission,
        this.installment,
        this.discountDetails,
        this.isVoid,
        this.isRefund,
        this.data,
        this.isHidden,
        this.paymentKeyClaims,
        this.errorOccured,
        this.isLive,
        this.otherEndpointReference,
        this.refundedAmountCents,
        this.sourceId,
        this.isCaptured,
        this.capturedAmount,
        this.merchantStaffTag,
        this.updatedAt,
        this.isSettled,
        this.billBalanced,
        this.isBill,
        this.owner,
        this.parentTransaction,
        this.uniqueRef,
    });

    factory PaymentCallBackModel.fromJson(Map<String, dynamic> json) => PaymentCallBackModel(
        id: json["id"],
        pending: json["pending"],
        amountCents: json["amount_cents"],
        success: json["success"],
        isAuth: json["is_auth"],
        isCapture: json["is_capture"],
        isStandalonePayment: json["is_standalone_payment"],
        isVoided: json["is_voided"],
        isRefunded: json["is_refunded"],
        is3DSecure: json["is_3d_secure"],
        integrationId: json["integration_id"],
        profileId: json["profile_id"],
        hasParentTransaction: json["has_parent_transaction"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        transactionProcessedCallbackResponses: json["transaction_processed_callback_responses"] == null ? [] : List<TransactionProcessedCallbackResponse>.from(json["transaction_processed_callback_responses"]!.map((x) => TransactionProcessedCallbackResponse.fromJson(x))),
        currency: json["currency"],
        sourceData: json["source_data"] == null ? null : SourceData.fromJson(json["source_data"]),
        apiSource: json["api_source"],
        terminalId: json["terminal_id"],
        merchantCommission: json["merchant_commission"],
        installment: json["installment"],
        discountDetails: json["discount_details"] == null ? [] : List<dynamic>.from(json["discount_details"]!.map((x) => x)),
        isVoid: json["is_void"],
        isRefund: json["is_refund"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        isHidden: json["is_hidden"],
        paymentKeyClaims: json["payment_key_claims"] == null ? null : PaymentKeyClaims.fromJson(json["payment_key_claims"]),
        errorOccured: json["error_occured"],
        isLive: json["is_live"],
        otherEndpointReference: json["other_endpoint_reference"],
        refundedAmountCents: json["refunded_amount_cents"],
        sourceId: json["source_id"],
        isCaptured: json["is_captured"],
        capturedAmount: json["captured_amount"],
        merchantStaffTag: json["merchant_staff_tag"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        isSettled: json["is_settled"],
        billBalanced: json["bill_balanced"],
        isBill: json["is_bill"],
        owner: json["owner"],
        parentTransaction: json["parent_transaction"],
        uniqueRef: json["unique_ref"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pending": pending,
        "amount_cents": amountCents,
        "success": success,
        "is_auth": isAuth,
        "is_capture": isCapture,
        "is_standalone_payment": isStandalonePayment,
        "is_voided": isVoided,
        "is_refunded": isRefunded,
        "is_3d_secure": is3DSecure,
        "integration_id": integrationId,
        "profile_id": profileId,
        "has_parent_transaction": hasParentTransaction,
        "order": order?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "transaction_processed_callback_responses": transactionProcessedCallbackResponses == null ? [] : List<dynamic>.from(transactionProcessedCallbackResponses!.map((x) => x.toJson())),
        "currency": currency,
        "source_data": sourceData?.toJson(),
        "api_source": apiSource,
        "terminal_id": terminalId,
        "merchant_commission": merchantCommission,
        "installment": installment,
        "discount_details": discountDetails == null ? [] : List<dynamic>.from(discountDetails!.map((x) => x)),
        "is_void": isVoid,
        "is_refund": isRefund,
        "data": data?.toJson(),
        "is_hidden": isHidden,
        "payment_key_claims": paymentKeyClaims?.toJson(),
        "error_occured": errorOccured,
        "is_live": isLive,
        "other_endpoint_reference": otherEndpointReference,
        "refunded_amount_cents": refundedAmountCents,
        "source_id": sourceId,
        "is_captured": isCaptured,
        "captured_amount": capturedAmount,
        "merchant_staff_tag": merchantStaffTag,
        "updated_at": updatedAt?.toIso8601String(),
        "is_settled": isSettled,
        "bill_balanced": billBalanced,
        "is_bill": isBill,
        "owner": owner,
        "parent_transaction": parentTransaction,
        "unique_ref": uniqueRef,
    };
}

class Data {
    String? klass;
    int? amount;
    String? acsEci;
    String? message;
    int? batchNo;
    String? cardNum;
    String? currency;
    String? merchant;
    String? cardType;
    DateTime? createdAt;
    MigsOrder? migsOrder;
    String? orderInfo;
    String? receiptNo;
    String? migsResult;
    String? secureHash;
    String? authorizeId;
    String? transactionNo;
    String? avsResultCode;
    int? capturedAmount;
    int? refundedAmount;
    String? merchantTxnRef;
    MigsTransaction? migsTransaction;
    String? acqResponseCode;
    int? authorisedAmount;
    String? txnResponseCode;
    String? avsAcqResponseCode;
    int? gatewayIntegrationPk;

    Data({
        this.klass,
        this.amount,
        this.acsEci,
        this.message,
        this.batchNo,
        this.cardNum,
        this.currency,
        this.merchant,
        this.cardType,
        this.createdAt,
        this.migsOrder,
        this.orderInfo,
        this.receiptNo,
        this.migsResult,
        this.secureHash,
        this.authorizeId,
        this.transactionNo,
        this.avsResultCode,
        this.capturedAmount,
        this.refundedAmount,
        this.merchantTxnRef,
        this.migsTransaction,
        this.acqResponseCode,
        this.authorisedAmount,
        this.txnResponseCode,
        this.avsAcqResponseCode,
        this.gatewayIntegrationPk,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        klass: json["klass"],
        amount: json["amount"],
        acsEci: json["acs_eci"],
        message: json["message"],
        batchNo: json["batch_no"],
        cardNum: json["card_num"],
        currency: json["currency"],
        merchant: json["merchant"],
        cardType: json["card_type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        migsOrder: json["migs_order"] == null ? null : MigsOrder.fromJson(json["migs_order"]),
        orderInfo: json["order_info"],
        receiptNo: json["receipt_no"],
        migsResult: json["migs_result"],
        secureHash: json["secure_hash"],
        authorizeId: json["authorize_id"],
        transactionNo: json["transaction_no"],
        avsResultCode: json["avs_result_code"],
        capturedAmount: json["captured_amount"],
        refundedAmount: json["refunded_amount"],
        merchantTxnRef: json["merchant_txn_ref"],
        migsTransaction: json["migs_transaction"] == null ? null : MigsTransaction.fromJson(json["migs_transaction"]),
        acqResponseCode: json["acq_response_code"],
        authorisedAmount: json["authorised_amount"],
        txnResponseCode: json["txn_response_code"],
        avsAcqResponseCode: json["avs_acq_response_code"],
        gatewayIntegrationPk: json["gateway_integration_pk"],
    );

    Map<String, dynamic> toJson() => {
        "klass": klass,
        "amount": amount,
        "acs_eci": acsEci,
        "message": message,
        "batch_no": batchNo,
        "card_num": cardNum,
        "currency": currency,
        "merchant": merchant,
        "card_type": cardType,
        "created_at": createdAt?.toIso8601String(),
        "migs_order": migsOrder?.toJson(),
        "order_info": orderInfo,
        "receipt_no": receiptNo,
        "migs_result": migsResult,
        "secure_hash": secureHash,
        "authorize_id": authorizeId,
        "transaction_no": transactionNo,
        "avs_result_code": avsResultCode,
        "captured_amount": capturedAmount,
        "refunded_amount": refundedAmount,
        "merchant_txn_ref": merchantTxnRef,
        "migs_transaction": migsTransaction?.toJson(),
        "acq_response_code": acqResponseCode,
        "authorised_amount": authorisedAmount,
        "txn_response_code": txnResponseCode,
        "avs_acq_response_code": avsAcqResponseCode,
        "gateway_integration_pk": gatewayIntegrationPk,
    };
}

class MigsOrder {
    String? id;
    int? amount;
    String? status;
    String? currency;
    Chargeback? chargeback;
    String? description;
    DateTime? creationTime;
    int? merchantAmount;
    DateTime? lastUpdatedTime;
    String? merchantCurrency;
    bool? acceptPartialAmount;
    int? totalCapturedAmount;
    int? totalRefundedAmount;
    String? authenticationStatus;
    String? merchantCategoryCode;
    int? totalAuthorizedAmount;

    MigsOrder({
        this.id,
        this.amount,
        this.status,
        this.currency,
        this.chargeback,
        this.description,
        this.creationTime,
        this.merchantAmount,
        this.lastUpdatedTime,
        this.merchantCurrency,
        this.acceptPartialAmount,
        this.totalCapturedAmount,
        this.totalRefundedAmount,
        this.authenticationStatus,
        this.merchantCategoryCode,
        this.totalAuthorizedAmount,
    });

    factory MigsOrder.fromJson(Map<String, dynamic> json) => MigsOrder(
        id: json["id"],
        amount: json["amount"],
        status: json["status"],
        currency: json["currency"],
        chargeback: json["chargeback"] == null ? null : Chargeback.fromJson(json["chargeback"]),
        description: json["description"],
        creationTime: json["creationTime"] == null ? null : DateTime.parse(json["creationTime"]),
        merchantAmount: json["merchantAmount"],
        lastUpdatedTime: json["lastUpdatedTime"] == null ? null : DateTime.parse(json["lastUpdatedTime"]),
        merchantCurrency: json["merchantCurrency"],
        acceptPartialAmount: json["acceptPartialAmount"],
        totalCapturedAmount: json["totalCapturedAmount"],
        totalRefundedAmount: json["totalRefundedAmount"],
        authenticationStatus: json["authenticationStatus"],
        merchantCategoryCode: json["merchantCategoryCode"],
        totalAuthorizedAmount: json["totalAuthorizedAmount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "status": status,
        "currency": currency,
        "chargeback": chargeback?.toJson(),
        "description": description,
        "creationTime": creationTime?.toIso8601String(),
        "merchantAmount": merchantAmount,
        "lastUpdatedTime": lastUpdatedTime?.toIso8601String(),
        "merchantCurrency": merchantCurrency,
        "acceptPartialAmount": acceptPartialAmount,
        "totalCapturedAmount": totalCapturedAmount,
        "totalRefundedAmount": totalRefundedAmount,
        "authenticationStatus": authenticationStatus,
        "merchantCategoryCode": merchantCategoryCode,
        "totalAuthorizedAmount": totalAuthorizedAmount,
    };
}

class Chargeback {
    int? amount;
    String? currency;

    Chargeback({
        this.amount,
        this.currency,
    });

    factory Chargeback.fromJson(Map<String, dynamic> json) => Chargeback(
        amount: json["amount"],
        currency: json["currency"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency": currency,
    };
}

class MigsTransaction {
    String? id;
    String? stan;
    String? type;
    int? amount;
    String? source;
    String? receipt;
    Acquirer? acquirer;
    String? currency;
    String? terminal;
    String? authorizationCode;
    String? authenticationStatus;

    MigsTransaction({
        this.id,
        this.stan,
        this.type,
        this.amount,
        this.source,
        this.receipt,
        this.acquirer,
        this.currency,
        this.terminal,
        this.authorizationCode,
        this.authenticationStatus,
    });

    factory MigsTransaction.fromJson(Map<String, dynamic> json) => MigsTransaction(
        id: json["id"],
        stan: json["stan"],
        type: json["type"],
        amount: json["amount"],
        source: json["source"],
        receipt: json["receipt"],
        acquirer: json["acquirer"] == null ? null : Acquirer.fromJson(json["acquirer"]),
        currency: json["currency"],
        terminal: json["terminal"],
        authorizationCode: json["authorizationCode"],
        authenticationStatus: json["authenticationStatus"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "stan": stan,
        "type": type,
        "amount": amount,
        "source": source,
        "receipt": receipt,
        "acquirer": acquirer?.toJson(),
        "currency": currency,
        "terminal": terminal,
        "authorizationCode": authorizationCode,
        "authenticationStatus": authenticationStatus,
    };
}

class Acquirer {
    String? id;
    String? date;
    int? batch;
    String? timeZone;
    String? merchantId;
    String? transactionId;
    DateTime? settlementDate;

    Acquirer({
        this.id,
        this.date,
        this.batch,
        this.timeZone,
        this.merchantId,
        this.transactionId,
        this.settlementDate,
    });

    factory Acquirer.fromJson(Map<String, dynamic> json) => Acquirer(
        id: json["id"],
        date: json["date"],
        batch: json["batch"],
        timeZone: json["timeZone"],
        merchantId: json["merchantId"],
        transactionId: json["transactionId"],
        settlementDate: json["settlementDate"] == null ? null : DateTime.parse(json["settlementDate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "batch": batch,
        "timeZone": timeZone,
        "merchantId": merchantId,
        "transactionId": transactionId,
        "settlementDate": "${settlementDate!.year.toString().padLeft(4, '0')}-${settlementDate!.month.toString().padLeft(2, '0')}-${settlementDate!.day.toString().padLeft(2, '0')}",
    };
}

class Order {
    int? id;
    DateTime? createdAt;
    bool? deliveryNeeded;
    Merchant? merchant;
    dynamic collector;
    int? amountCents;
    IngData? shippingData;
    String? currency;
    bool? isPaymentLocked;
    bool? isReturn;
    bool? isCancel;
    bool? isReturned;
    bool? isCanceled;
    dynamic merchantOrderId;
    dynamic walletNotification;
    int? paidAmountCents;
    bool? notifyUserWithEmail;
    List<dynamic>? items;
    String? orderUrl;
    int? commissionFees;
    int? deliveryFeesCents;
    int? deliveryVatCents;
    String? paymentMethod;
    dynamic merchantStaffTag;
    String? apiSource;
    List<dynamic>? data;
    String? paymentStatus;

    Order({
        this.id,
        this.createdAt,
        this.deliveryNeeded,
        this.merchant,
        this.collector,
        this.amountCents,
        this.shippingData,
        this.currency,
        this.isPaymentLocked,
        this.isReturn,
        this.isCancel,
        this.isReturned,
        this.isCanceled,
        this.merchantOrderId,
        this.walletNotification,
        this.paidAmountCents,
        this.notifyUserWithEmail,
        this.items,
        this.orderUrl,
        this.commissionFees,
        this.deliveryFeesCents,
        this.deliveryVatCents,
        this.paymentMethod,
        this.merchantStaffTag,
        this.apiSource,
        this.data,
        this.paymentStatus,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        deliveryNeeded: json["delivery_needed"],
        merchant: json["merchant"] == null ? null : Merchant.fromJson(json["merchant"]),
        collector: json["collector"],
        amountCents: json["amount_cents"],
        shippingData: json["shipping_data"] == null ? null : IngData.fromJson(json["shipping_data"]),
        currency: json["currency"],
        isPaymentLocked: json["is_payment_locked"],
        isReturn: json["is_return"],
        isCancel: json["is_cancel"],
        isReturned: json["is_returned"],
        isCanceled: json["is_canceled"],
        merchantOrderId: json["merchant_order_id"],
        walletNotification: json["wallet_notification"],
        paidAmountCents: json["paid_amount_cents"],
        notifyUserWithEmail: json["notify_user_with_email"],
        items: json["items"] == null ? [] : List<dynamic>.from(json["items"]!.map((x) => x)),
        orderUrl: json["order_url"],
        commissionFees: json["commission_fees"],
        deliveryFeesCents: json["delivery_fees_cents"],
        deliveryVatCents: json["delivery_vat_cents"],
        paymentMethod: json["payment_method"],
        merchantStaffTag: json["merchant_staff_tag"],
        apiSource: json["api_source"],
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
        paymentStatus: json["payment_status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "delivery_needed": deliveryNeeded,
        "merchant": merchant?.toJson(),
        "collector": collector,
        "amount_cents": amountCents,
        "shipping_data": shippingData?.toJson(),
        "currency": currency,
        "is_payment_locked": isPaymentLocked,
        "is_return": isReturn,
        "is_cancel": isCancel,
        "is_returned": isReturned,
        "is_canceled": isCanceled,
        "merchant_order_id": merchantOrderId,
        "wallet_notification": walletNotification,
        "paid_amount_cents": paidAmountCents,
        "notify_user_with_email": notifyUserWithEmail,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x)),
        "order_url": orderUrl,
        "commission_fees": commissionFees,
        "delivery_fees_cents": deliveryFeesCents,
        "delivery_vat_cents": deliveryVatCents,
        "payment_method": paymentMethod,
        "merchant_staff_tag": merchantStaffTag,
        "api_source": apiSource,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "payment_status": paymentStatus,
    };
}

class Merchant {
    int? id;
    DateTime? createdAt;
    List<String>? phones;
    dynamic companyEmails;
    String? companyName;
    String? state;
    String? country;
    String? city;
    String? postalCode;
    String? street;

    Merchant({
        this.id,
        this.createdAt,
        this.phones,
        this.companyEmails,
        this.companyName,
        this.state,
        this.country,
        this.city,
        this.postalCode,
        this.street,
    });

    factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        phones: json["phones"] == null ? [] : List<String>.from(json["phones"]!.map((x) => x)),
        companyEmails: json["company_emails"],
        companyName: json["company_name"],
        state: json["state"],
        country: json["country"],
        city: json["city"],
        postalCode: json["postal_code"],
        street: json["street"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "phones": phones == null ? [] : List<dynamic>.from(phones!.map((x) => x)),
        "company_emails": companyEmails,
        "company_name": companyName,
        "state": state,
        "country": country,
        "city": city,
        "postal_code": postalCode,
        "street": street,
    };
}

class IngData {
    int? id;
    String? firstName;
    String? lastName;
    String? street;
    String? building;
    String? floor;
    String? apartment;
    String? city;
    String? state;
    String? country;
    String? email;
    String? phoneNumber;
    String? postalCode;
    String? extraDescription;
    String? shippingMethod;
    int? orderId;
    int? order;

    IngData({
        this.id,
        this.firstName,
        this.lastName,
        this.street,
        this.building,
        this.floor,
        this.apartment,
        this.city,
        this.state,
        this.country,
        this.email,
        this.phoneNumber,
        this.postalCode,
        this.extraDescription,
        this.shippingMethod,
        this.orderId,
        this.order,
    });

    factory IngData.fromJson(Map<String, dynamic> json) => IngData(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        street: json["street"],
        building: json["building"],
        floor: json["floor"],
        apartment: json["apartment"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        postalCode: json["postal_code"],
        extraDescription: json["extra_description"],
        shippingMethod: json["shipping_method"],
        orderId: json["order_id"],
        order: json["order"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "street": street,
        "building": building,
        "floor": floor,
        "apartment": apartment,
        "city": city,
        "state": state,
        "country": country,
        "email": email,
        "phone_number": phoneNumber,
        "postal_code": postalCode,
        "extra_description": extraDescription,
        "shipping_method": shippingMethod,
        "order_id": orderId,
        "order": order,
    };
}

class PaymentKeyClaims {
    int? exp;
    Extra? extra;
    int? userId;
    String? currency;
    int? orderId;
    int? amountCents;
    IngData? billingData;
    String? redirectUrl;
    int? integrationId;
    bool? lockOrderWhenPaid;
    String? nextPaymentIntention;
    bool? singlePaymentAttempt;

    PaymentKeyClaims({
        this.exp,
        this.extra,
        this.userId,
        this.currency,
        this.orderId,
        this.amountCents,
        this.billingData,
        this.redirectUrl,
        this.integrationId,
        this.lockOrderWhenPaid,
        this.nextPaymentIntention,
        this.singlePaymentAttempt,
    });

    factory PaymentKeyClaims.fromJson(Map<String, dynamic> json) => PaymentKeyClaims(
        exp: json["exp"],
        extra: json["extra"] == null ? null : Extra.fromJson(json["extra"]),
        userId: json["user_id"],
        currency: json["currency"],
        orderId: json["order_id"],
        amountCents: json["amount_cents"],
        billingData: json["billing_data"] == null ? null : IngData.fromJson(json["billing_data"]),
        redirectUrl: json["redirect_url"],
        integrationId: json["integration_id"],
        lockOrderWhenPaid: json["lock_order_when_paid"],
        nextPaymentIntention: json["next_payment_intention"],
        singlePaymentAttempt: json["single_payment_attempt"],
    );

    Map<String, dynamic> toJson() => {
        "exp": exp,
        "extra": extra?.toJson(),
        "user_id": userId,
        "currency": currency,
        "order_id": orderId,
        "amount_cents": amountCents,
        "billing_data": billingData?.toJson(),
        "redirect_url": redirectUrl,
        "integration_id": integrationId,
        "lock_order_when_paid": lockOrderWhenPaid,
        "next_payment_intention": nextPaymentIntention,
        "single_payment_attempt": singlePaymentAttempt,
    };
}

class Extra {
    int? acceptOrderId;
    dynamic merchantOrderId;

    Extra({
        this.acceptOrderId,
        this.merchantOrderId,
    });

    factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        acceptOrderId: json["accept_order_id"],
        merchantOrderId: json["merchant_order_id"],
    );

    Map<String, dynamic> toJson() => {
        "accept_order_id": acceptOrderId,
        "merchant_order_id": merchantOrderId,
    };
}

class SourceData {
    String? pan;
    String? type;
    dynamic tenure;
    String? subType;

    SourceData({
        this.pan,
        this.type,
        this.tenure,
        this.subType,
    });

    factory SourceData.fromJson(Map<String, dynamic> json) => SourceData(
        pan: json["pan"],
        type: json["type"],
        tenure: json["tenure"],
        subType: json["sub_type"],
    );

    Map<String, dynamic> toJson() => {
        "pan": pan,
        "type": type,
        "tenure": tenure,
        "sub_type": subType,
    };
}

class TransactionProcessedCallbackResponse {
    String? response;
    String? callbackUrl;
    DateTime? responseReceivedAt;

    TransactionProcessedCallbackResponse({
        this.response,
        this.callbackUrl,
        this.responseReceivedAt,
    });

    factory TransactionProcessedCallbackResponse.fromJson(Map<String, dynamic> json) => TransactionProcessedCallbackResponse(
        response: json["response"],
        callbackUrl: json["callback_url"],
        responseReceivedAt: json["response_received_at"] == null ? null : DateTime.parse(json["response_received_at"]),
    );

    Map<String, dynamic> toJson() => {
        "response": response,
        "callback_url": callbackUrl,
        "response_received_at": responseReceivedAt?.toIso8601String(),
    };
}
