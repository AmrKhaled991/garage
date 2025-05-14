// ignore: one_member_abstracts
abstract class Decodable<T> {
  T decode(dynamic json);
}

class TypeDecodable<T> implements Decodable<TypeDecodable<T>> {
  T value;
  TypeDecodable({required this.value});

  @override
  TypeDecodable<T> decode(dynamic json) {
    value = json;
    return this;
  }
}
