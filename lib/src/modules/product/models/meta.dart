import 'package:equatable/equatable.dart';

class Meta extends Equatable {
	final String description;
	final String specifications;
	final String features;
	final String variant;
	final String imageId;

	const Meta({
		this.description,
		this.specifications,
		this.features,
		this.variant,
		this.imageId,
	});

	factory Meta.fromJson(Map<String, dynamic> json) {
		return Meta(
			description: json['description'] as String,
			specifications: json['specifications'] as String,
			features: json['features'] as String,
			variant: json['variant'] as String,
			imageId: json['imageId'] as String,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'description': description,
			'specifications': specifications,
			'features': features,
			'variant': variant,
			'imageId': imageId,
		};
	}	

	Meta copyWith({
		String description,
		String specifications,
		String features,
		String variant,
		String imageId,
	}) {
		return Meta(
			description: description ?? this.description,
			specifications: specifications ?? this.specifications,
			features: features ?? this.features,
			variant: variant ?? this.variant,
			imageId: imageId ?? this.imageId,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object> get props {
		return [
			description,
			specifications,
			features,
			variant,
			imageId,
		];
	}
}
