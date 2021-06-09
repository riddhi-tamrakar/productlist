import 'package:equatable/equatable.dart';

class Discount extends Equatable {
	final bool isDiscountPercent;
	final int discountValue;

	const Discount({this.isDiscountPercent, this.discountValue});

	factory Discount.fromJson(Map<String, dynamic> json) {
		return Discount(
			isDiscountPercent: json['is_discount_percent'] as bool,
			discountValue: json['discount_value'],
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'is_discount_percent': isDiscountPercent,
			'discount_value': discountValue,
		};
	}	

	Discount copyWith({
		bool isDiscountPercent,
		int discountValue,
	}) {
		return Discount(
			isDiscountPercent: isDiscountPercent ?? this.isDiscountPercent,
			discountValue: discountValue ?? this.discountValue,
		);
	}

	@override
	bool get stringify => true;

	@override
	List<Object> get props => [isDiscountPercent, discountValue];
}
