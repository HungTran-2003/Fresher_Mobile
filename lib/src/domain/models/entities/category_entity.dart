import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String name;

  const CategoryEntity({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  @override
  List<Object?> get props => [id, status, createdAt, updatedAt, name];
}
