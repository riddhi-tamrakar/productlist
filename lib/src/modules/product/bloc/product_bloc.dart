import 'dart:async';

import 'package:app/src/modules/product/models/product.dart';
import 'package:app/src/services/db_service.dart';
import 'package:app/src/services/db_service_response.model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial());
  DbServices _dbServices = DbServices();

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is FetchProductList) {
      try {
        yield Loading();
        List<Product> _products = await _fetchProductList();
        yield DataLoaded(data: _products);
      } catch (e) {
        yield ErrorReceived(err: e);
      }
    }
  }

  Future<List<Product>> _fetchProductList() async {
    try {
      ResponseModel _response =
          await _dbServices.getapi('/26ca1ca6-332a-46fe-9df8-392d87a0ecf2');
      if (_response.statusCode == 200) {
        return _response.data['product_list']
            .map<Product>((e) => Product.fromJson(e))
            .toList();
      } else {
        throw ('something_went_wrong');
      }
    } catch (e) {
      throw (e);
    }
  }

  int selectedProduct(List<Product> list) {
    try {
      return list
          .where(
              (Product element) => element.selected != null && element.selected)
          .toList()
          .length;
    } catch (e) {
      return 0;
    }
  }

  int totalSelectedUnits(List<Product> list) {
    try {
      int _totalUnits = 0;
      list.forEach((Product element) {
        if (element.selected != null && element.selected) {
          _totalUnits += element.quantity;
        }
      });
      return _totalUnits;
    } catch (e) {
      return 0;
    }
  }

    int totalPrice(List<Product> list) {
    try {
      int _totalPrice = 0;
      list.forEach((Product element) {
        if (element.selected != null && element.selected) {
          _totalPrice += element.quantity * element.sp;
        }
      });
      return _totalPrice;
    } catch (e) {
      return 0;
    }
  }
}
