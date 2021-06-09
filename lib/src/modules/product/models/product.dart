import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'discount.dart';
import 'meta.dart';
import 'product_accessories.dart';
import 'product_variants.dart';

class Product extends Equatable {
  final int tenantId;
  final String name;
  final String customCode;
  final String unitprice;
  final String msp;
  final int id;
  final bool isActive;
  final dynamic productOption1;
  final Meta meta;
  final Discount discount;
  final String gst;
  int sp;
  final List<ProductVariants> productVariants;
  final List<ProductAccessories> productAccessories;
  bool selected;
  int quantity;
  String selectedSize;
  String selectedColor;

  Product(
      {this.tenantId,
      this.name,
      this.customCode,
      this.unitprice,
      this.msp,
      this.id,
      this.isActive,
      this.productOption1,
      this.meta,
      this.discount,
      this.gst,
      this.sp,
      this.productVariants,
      this.productAccessories,
      this.selected,
      this.quantity});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        tenantId: json['tenant_id'] as int,
        name: json['name'] as String,
        customCode: json['custom_code'] as String,
        unitprice: json['unitprice'] as String,
        msp: json['msp'] as String,
        id: json['id'] as int,
        isActive: json['is_active'] as bool,
        productOption1: json['product_option1'],
        meta: json['meta'] == null
            ? null
            : Meta.fromJson(json['meta'] as Map<String, dynamic>),
        // discount: json['discount'] == null
        // 		? null
        // 		: Discount.fromJson(json['discount'] as Map<String, dynamic>),
        gst: json['gst'] as String,
        sp: json['sp'] as int,
        productVariants: (json['product_variants'] as List<dynamic>)
            ?.map((e) => e == null
                ? null
                : ProductVariants.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        productAccessories: (json['product_accessories'] as List<dynamic>)
            ?.map((e) => e == null
                ? null
                : ProductAccessories.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        quantity: 1);
  }

  Map<String, dynamic> toJson() {
    return {
      'tenant_id': tenantId,
      'name': name,
      'custom_code': customCode,
      'unitprice': unitprice,
      'msp': msp,
      'id': id,
      'is_active': isActive,
      'product_option1': productOption1,
      'meta': meta?.toJson(),
      'discount': discount?.toJson(),
      'gst': gst,
      'sp': sp,
      'product_variants': productVariants?.map((e) => e?.toJson())?.toList(),
      'product_accessories':
          productAccessories?.map((e) => e?.toJson())?.toList(),
    };
  }

  Product copyWith({
    int tenantId,
    String name,
    String customCode,
    String unitprice,
    String msp,
    int id,
    bool isActive,
    dynamic productOption1,
    Meta meta,
    Discount discount,
    String gst,
    int sp,
    List<ProductVariants> productVariants,
    List<ProductAccessories> productAccessories,
  }) {
    return Product(
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      customCode: customCode ?? this.customCode,
      unitprice: unitprice ?? this.unitprice,
      msp: msp ?? this.msp,
      id: id ?? this.id,
      isActive: isActive ?? this.isActive,
      productOption1: productOption1 ?? this.productOption1,
      meta: meta ?? this.meta,
      discount: discount ?? this.discount,
      gst: gst ?? this.gst,
      sp: sp ?? this.sp,
      productVariants: productVariants ?? this.productVariants,
      productAccessories: productAccessories ?? this.productAccessories,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      tenantId,
      name,
      customCode,
      unitprice,
      msp,
      id,
      isActive,
      productOption1,
      meta,
      discount,
      gst,
      sp,
      productVariants,
      productAccessories,
      selected,
      quantity
    ];
  }
}
