import 'package:equatable/equatable.dart';

class ProductAccessories extends Equatable {
	final int accessoriesId;
	final int productId;
	final String name;
	final int sellingPrice;
	final int gst;
	final String createdAt;

	const ProductAccessories({
		this.accessoriesId,
		this.productId,
		this.name,
		this.sellingPrice,
		this.gst,
		this.createdAt,
	});

	factory ProductAccessories.fromJson(Map<String, dynamic> json) {
		return ProductAccessories(
			accessoriesId: json['accessories_id'] as int,
			productId: json['product_id'] as int,
			name: json['name'] as String,
			sellingPrice: json['selling_price'] as int,
			gst: json['gst'] as int,
			createdAt: json['created_at'] as String,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'accessories_id': accessoriesId,
			'product_id': productId,
			'name': name,
			'selling_price': sellingPrice,
			'gst': gst,
			'created_at': createdAt,
		};
	}	

	ProductAccessories copyWith({
		int accessoriesId,
		int productId,
		String name,
		int sellingPrice,
		int gst,
		String createdAt,
	}) {
		return ProductAccessories(
			accessoriesId: accessoriesId ?? this.accessoriesId,
			productId: productId ?? this.productId,
			name: name ?? this.name,
			sellingPrice: sellingPrice ?? this.sellingPrice,
			gst: gst ?? this.gst,
			createdAt: createdAt ?? this.createdAt,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object> get props {
		return [
			accessoriesId,
			productId,
			name,
			sellingPrice,
			gst,
			createdAt,
		];
	}
}
