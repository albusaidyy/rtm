import 'package:freezed_annotation/freezed_annotation.dart';

part 'visit.freezed.dart';
part 'visit.g.dart';

@freezed
abstract class Visit with _$Visit {
  factory Visit({
    required int id,
    @JsonKey(name: 'customer_id') required int customerId,
    @JsonKey(name: 'visit_date') required String visitDate,
    required String status,
    required String location,
    required String notes,
    @JsonKey(name: 'activities_done') required List<String> activitiesDone,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _Visit;
  factory Visit.fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);
}

@freezed
abstract class Visits with _$Visits {
  factory Visits({
    required List<Visit> visits,
  }) = _Visits;
  factory Visits.fromJson(Map<String, dynamic> json) => _$VisitsFromJson(json);
}
