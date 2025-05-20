import 'package:freezed_annotation/freezed_annotation.dart';

part 'visit.freezed.dart';
part 'visit.g.dart';

@freezed
abstract class Visit with _$Visit {
  factory Visit({
    required int id,
    @JsonKey(name: 'customer_id') required int customerId,
    required String status,
    required String location,
    @JsonKey(name: 'activities_done') List<String>? activitiesDone,
    @JsonKey(name: 'visit_date') String? visitDate,
    String? notes,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _Visit;
  factory Visit.fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);
}

@freezed
abstract class CustomerVisit with _$CustomerVisit {
  factory CustomerVisit({
    required int id,
    required String customerName,
    required String status,
    required String location,
    @Default([]) List<String> activitiesDone,
    @Default('') String visitDate,
    @Default('') String notes,
    @Default('') String createdAt,
  }) = _CustomerVisit;
  factory CustomerVisit.fromJson(Map<String, dynamic> json) =>
      _$CustomerVisitFromJson(json);
}
