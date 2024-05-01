class RouteClass {
  final int? id;
  final String? code;
  final String? name;

  RouteClass({
     this.id,
    this.code,
    this.name,
  });

  factory RouteClass.fromJson(Map<String, dynamic> json) {
    return RouteClass(
      id: json['id'] as int,
      code: json['code'] as String?,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
    };
  }
}
