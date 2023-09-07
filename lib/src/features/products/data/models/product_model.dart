import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/src/features/products/domain/entities/product_entity.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  factory ProductModel({
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
    String? productImage,
  }) = _ProductModel;

  const ProductModel._();

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  factory ProductModel.fromFirestore(
      {required DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options}) {
    final data = snapshot.data();
    return ProductModel(
      brandName: data?["brand_name"],
      category:
          data?["category"] is Iterable ? List.from(data?["category"]) : null,
      color: data?["color"],
      gender: data?["gender"] is Iterable ? List.from(data?["gender"]) : null,
      id: data?["id"],
      name: data?["name"],
      releaseYear: data?["release_year"],
      retailPriceCents: data?["retail_price_cents"],
      productImage: data?["original_picture_url"],
      // sizeRange: data?["size_range"] is Iterable
      //     ? List.from(data?["size_range"])
      //     : null,
      storyHtml: data?["story_html"],
    );
  }

  // Convert ProductModel to Product entity
  ProductEntity toEntity() {
    return ProductEntity(
      brandName: brandName,
      category: category,
      color: color,
      gender: gender?.cast<String>(),
      id: id,
      name: name,
      releaseYear: releaseYear,
      retailPriceCents: retailPriceCents,
      sizeRange: sizeRange,
      storyHtml: storyHtml,
      productImage: productImage,
    );
  }

// Convert Product entity to ProductModel
//  ProductModel toModel() {
//     return ProductModel(
//       brandName: brandName,
//       category: category,
//       color: color,
//       gender: gender?.cast<String>(),
//       id: id,
//       name: name,
//       releaseYear: releaseYear,
//       retailPriceCents: retailPriceCents,
//       sizeRange: sizeRange,
//       storyHtml: storyHtml,
//     );
//   }

  Map<String, dynamic> toFirestore() {
    return {
      if (brandName != null) "brandName": brandName,
      if (category != null) "category": category,
      if (color != null) "color": color,
      if (gender != null) "gender": gender,
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (releaseYear != null) "releaseYear": releaseYear,
      if (retailPriceCents != null) "retailPriceCents": retailPriceCents,
      if (sizeRange != null) "sizeRange": sizeRange,
      if (storyHtml != null) "storyHtml": storyHtml,
      if (productImage != null) "isFaVorite": productImage,
    };
  }
}



