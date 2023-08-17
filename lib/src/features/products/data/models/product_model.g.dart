// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProductModel _$$_ProductModelFromJson(Map<String, dynamic> json) =>
    _$_ProductModel(
      brandName: json['brandName'] as String?,
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      color: json['color'] as String?,
      gender: json['gender'] as List<dynamic>?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      releaseYear: json['releaseYear'] as int?,
      retailPriceCents: json['retailPriceCents'] as num?,
      sizeRange:
          (json['sizeRange'] as List<dynamic>?)?.map((e) => e as num).toList(),
      storyHtml: json['storyHtml'] as String?,
      productImage: json['productImage'] as String?,
    );

Map<String, dynamic> _$$_ProductModelToJson(_$_ProductModel instance) =>
    <String, dynamic>{
      'brandName': instance.brandName,
      'category': instance.category,
      'color': instance.color,
      'gender': instance.gender,
      'id': instance.id,
      'name': instance.name,
      'releaseYear': instance.releaseYear,
      'retailPriceCents': instance.retailPriceCents,
      'sizeRange': instance.sizeRange,
      'storyHtml': instance.storyHtml,
      'productImage': instance.productImage,
    };
