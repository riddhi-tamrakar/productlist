part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class Loading extends ProductState {}

class DataLoaded extends ProductState {
  final data;
  DataLoaded({this.data});
  DataLoaded copyWith({var data}) {
    return DataLoaded(data: data ?? this.data);
  }
  @override
  List<Object> get props => [data];
}

class ErrorReceived extends ProductState {
  final err;
  ErrorReceived({this.err});
  ErrorReceived copyWith({var err}) {
    return ErrorReceived(err: err ?? this.err);
  }

  @override
  List<Object> get props => [err];
}
