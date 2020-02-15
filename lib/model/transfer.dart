

class Transfer {
  int id;
  DateTime created_at;
  String phone_number_sender = '';
  String phone_number_receiver = '';
  int amount;
  String description;

  Transfer({this.id, this.created_at, this.phone_number_sender,
      this.phone_number_receiver, this.amount, this.description});
}
