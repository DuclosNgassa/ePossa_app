

class TransferDTO {
  String sender;
  String receiver;
  double amount;
  String description;

  TransferDTO(this.sender, this.receiver, this.amount, this.description);

  @override
  Map<String, dynamic> toJson() => {
        "sender": sender,
        "receiver": receiver,
        "amount": amount.toString(),
        "description": description,
      };

  Map<String, dynamic> toJsonWithoutId() => {
        "sender": sender,
        "receiver": receiver,
        "amount": amount.toString(),
        "description": description,
      };

  @override
  factory TransferDTO.fromJson(dynamic json) {
    return TransferDTO(
      json["sender"],
      json["receiver"],
      json["amount"],
      json["description"],
    );
  }

  Map<String, dynamic> toMap(TransferDTO transfer) {
    Map<String, dynamic> params = Map<String, dynamic>();
    params["sender"] = transfer.sender;
    params["receiver"] = transfer.receiver;
    params["amount"] = transfer.amount.toString();
    params["description"] = transfer.description;

    return params;
  }
}
