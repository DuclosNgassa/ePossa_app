abstract class BasisDTO<T extends Object> {
  int id;
  DateTime created_at;

  BasisDTO(this.id, this.created_at);

  Map<String, dynamic> toJson();

  Map<String, dynamic> toMap(T basisDTO);
}
