import 'package:freezed_annotation/freezed_annotation.dart';
part 'product_entity.freezed.dart';

@freezed
abstract class ProductEntity with _$ProductEntity {
  factory ProductEntity({
    String? brandName,
    List<String>? category,
    String? color,
    List? gender,
    int? id,
    String? name,
    int? releaseYear,
    num? retailPriceCents,
    List<num>? sizeRange,
    String? storyHtml,
    bool? isFavorite,
  }) = _ProductEntity;
}
