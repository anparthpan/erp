class Project {
  final String id;
  final String name;
  final String client;
  final double progress;
  final String status;

  const Project({
    required this.id,
    required this.name,
    required this.client,
    required this.progress,
    required this.status,
  });

  Project copyWith({
    String? name,
    String? client,
    double? progress,
    String? status,
  }) {
    return Project(
      id: id,
      name: name ?? this.name,
      client: client ?? this.client,
      progress: progress ?? this.progress,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'client': client,
    'progress': progress,
    'status': status,
  };

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json['id'],
    name: json['name'],
    client: json['client'],
    progress: (json['progress'] as num).toDouble(),
    status: json['status'],
  );
}
