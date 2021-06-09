import 'package:equatable/equatable.dart';

class ProductVariants extends Equatable {
	final int productId;
	final String variantType;
	final String variantValue;
	final int tenantId;
	final String createdAt;

	const ProductVariants({
		this.productId,
		this.variantType,
		this.variantValue,
		this.tenantId,
		this.createdAt,
	});

	factory ProductVariants.fromJson(Map<String, dynamic> json) {
		return ProductVariants(
			productId: json['product_id'] as int,
			variantType: json['variant_type'] as String,
			variantValue: json['variant_value'] as String,
			tenantId: json['tenant_id'] as int,
			createdAt: json['created_at'] as String,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'product_id': productId,
			'variant_type': variantType,
			'variant_value': variantValue,
			'tenant_id': tenantId,
			'created_at': createdAt,
		};
	}	

	ProductVariants copyWith({
		int productId,
		String variantType,
		String variantValue,
		int tenantId,
		String createdAt,
	}) {
		return ProductVariants(
			productId: productId ?? this.productId,
			variantType: variantType ?? this.variantType,
			variantValue: variantValue ?? this.variantValue,
			tenantId: tenantId ?? this.tenantId,
			createdAt: createdAt ?? this.createdAt,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object> get props {
		return [
			productId,
			variantType,
			variantValue,
			tenantId,
			createdAt,
		];
	}
}
