import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
abstract class CustomerItem with _$CustomerItem {
  factory CustomerItem({
    required int id,
    required String name,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _CustomerItem;

  factory CustomerItem.fromJson(Map<String, dynamic> json) =>
      _$CustomerItemFromJson(json);
}
