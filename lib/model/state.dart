import 'dart:convert';

class State {
  final String name;
  State({
    required this.name,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory State.fromMap(Map<String, dynamic> map) {
    return State(
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory State.fromJson(String source) => State.fromMap(json.decode(source));

  @override
  String toString() => 'State(name: $name)';
}
