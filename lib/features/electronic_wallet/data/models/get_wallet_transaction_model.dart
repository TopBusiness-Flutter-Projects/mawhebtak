
class GetWalletTransactionModel {
  GetWalletTransactionModelData? data;
  String? msg;
  int? status;

  GetWalletTransactionModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetWalletTransactionModel.fromJson(Map<String, dynamic> json) => GetWalletTransactionModel(
    data: json["data"] == null ? null : GetWalletTransactionModelData.fromJson(json["data"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "msg": msg,
    "status": status,
  };
}

class GetWalletTransactionModelData {
  dynamic wallet;
  List<WalletTransaction>? walletTransactions;

  GetWalletTransactionModelData({
    this.wallet,
    this.walletTransactions,
  });

  factory GetWalletTransactionModelData.fromJson(Map<String, dynamic> json) => GetWalletTransactionModelData(
    wallet: json["wallet"],
    walletTransactions: json["walletTransactions"] == null ? [] : List<WalletTransaction>.from(json["walletTransactions"]!.map((x) => WalletTransaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "wallet": wallet,
    "walletTransactions": walletTransactions == null ? [] : List<dynamic>.from(walletTransactions!.map((x) => x.toJson())),
  };
}

class WalletTransaction {
  int? id;
  int? userId;
  String? userType;
  int? credit;
  double? debit;
  dynamic caseId;
  String? comment;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  WalletTransaction({
    this.id,
    this.userId,
    this.userType,
    this.credit,
    this.debit,
    this.caseId,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory WalletTransaction.fromJson(Map<String, dynamic> json) => WalletTransaction(
    id: json["id"],
    userId: json["user_id"],
    userType: json["user_type"],
    credit: json["credit"],
    debit: json["debit"],
    caseId: json["case_id"],
    comment: json["comment"],
    createdAt: json["created_at"] ,
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "user_type": userType,
    "credit": credit,
    "debit": debit,
    "case_id": caseId,
    "comment": comment,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}
