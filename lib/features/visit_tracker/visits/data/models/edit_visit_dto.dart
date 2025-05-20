import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';

part 'edit_visit_dto.freezed.dart';
part 'edit_visit_dto.g.dart';

@freezed
class EditVisitDTO with _$EditVisitDTO {
  const factory EditVisitDTO({
    CustomerVisit? visit,
    @Default(false) bool isEdit,
  }) = _EditVisitDTO;

  factory EditVisitDTO.fromJson(Map<String, dynamic> json) =>
      _$EditVisitDTOFromJson(json);
}
