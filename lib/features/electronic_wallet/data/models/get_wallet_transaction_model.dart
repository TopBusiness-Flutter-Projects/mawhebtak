
class GetWalletTransactionModel {
  Data? data;
  String? msg;
  int? status;

  GetWalletTransactionModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetWalletTransactionModel.fromJson(Map<String, dynamic> json) => GetWalletTransactionModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "msg": msg,
    "status": status,
  };
}

class Data {
  int? walletBalance;
  List<MyTransaction>? myTransaction;

  Data({
    this.walletBalance,
    this.myTransaction,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    walletBalance: json["wallet_balance"],
    myTransaction: json["my_transaction"] == null ? [] : List<MyTransaction>.from(json["my_transaction"]!.map((x) => MyTransaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "wallet_balance": walletBalance,
    "my_transaction": myTransaction == null ? [] : List<dynamic>.from(myTransaction!.map((x) => x.toJson())),
  };
}

class MyTransaction {
  int? id;
  String? type;
  String? comment;
  String? time;
  int? amount;

  MyTransaction({
    this.id,
    this.type,
    this.comment,
    this.time,
    this.amount,
  });

  factory MyTransaction.fromJson(Map<String, dynamic> json) => MyTransaction(
    id: json["id"],
    type: json["type"],
    comment: json["comment"],
    time: json["time"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "comment": comment,
    "time": time,
    "amount": amount,
  };
}
