import 'package:epossa_app/model/basis_dto.dart';

class Transfer extends BasisDTO{
  String phone_number_sender;
  String phone_number_receiver;
  double amount;
  String description;

  Transfer(
      id,
      created_at,
      this.phone_number_sender,
      this.phone_number_receiver,
      this.amount,
      this.description):super(id, created_at);

  @override
  Map<String, dynamic> toJson() => {
    'id': id.toString(),
    'created_at': created_at.toString(),
    'phone_number_sender': phone_number_sender,
    'phone_number_receiver': phone_number_receiver,
    'amount': amount.toString(),
    'description': description,
  };

  @override
  factory Transfer.fromJson(Map<String, dynamic> json) {
    return Transfer(
      json["id"],
      DateTime.parse(json["created_at"]),
      json["phone_number_sender"],
      json["phone_number_receiver"],
      json["amount"],
      json["description"],
    );
  }

  @override
  Map<String, dynamic> toMap(Object _transfer){
    Transfer transfer = _transfer;
    Map<String, dynamic> params = Map<String, dynamic>();
    params["created_at"] = transfer.created_at.toString();
    params["phone_number_sender"] = transfer.phone_number_sender;
    params["phone_number_receiver"] = transfer.phone_number_receiver;
    params["amount"] = transfer.amount.toString();
    params["description"] = transfer.description;

    return params;
  }

}
