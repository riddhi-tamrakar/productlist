import 'package:app/src/modules/product/bloc/product_bloc.dart';
import 'package:app/src/modules/product/models/product.dart';
import 'package:app/src/modules/product/ui/page_2.dart';
import 'package:app/src/services/utility.dart';
import 'package:app/src/styles/theme.dart';
import 'package:app/src/widgets/common_button_widget.dart';
import 'package:app/src/widgets/custom_card_widget.dart';
import 'package:app/src/widgets/fake_list_widget.dart';
import 'package:app/src/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final ProductBloc _bloc = ProductBloc();
  TextEditingController _textEditingController = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _bloc.add(FetchProductList());
  }

  showBottomSheet(BuildContext context, Product item) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.kBodyPadding,
                  vertical: AppTheme.kBodyPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Enter new special price',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Special price'),
                      // keyboardType: TextInputType.number,
                      autofocus: true,
                      controller: _textEditingController,
                      onEditingComplete: () {
                        if (_textEditingController.text != '') {
                          setState(() {
                            item.sp = int.parse(_textEditingController.text);
                            _textEditingController.text = '';
                          });
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ));
  }

  Widget _priceIndicator(Product item) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              showBottomSheet(context, item);
            },
            child: Text(
              'Rs ${item.sp ?? ''}',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          Text(
            'Rs ${item.unitprice ?? ''}',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                decoration: int.parse(item.unitprice ?? '0') == item.sp
                    ? null
                    : TextDecoration.lineThrough),
          ),
        ],
      );

  Widget _quantityButton(Product item) => Container(
          child: Column(
        children: [
          Text('Quantity', style: Theme.of(context).textTheme.subtitle1),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  if (item.quantity > 1)
                    setState(() {
                      item.quantity--;
                    });
                },
                iconSize: 30,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                icon: Icon(Icons.remove_circle_outline),
                color: Theme.of(context).hintColor,
              ),
              Text('${item.quantity}',
                  style: Theme.of(context).textTheme.subtitle1),
              IconButton(
                onPressed: () {
                  setState(() {
                    item.quantity++;
                  });
                },
                iconSize: 30,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                icon: Icon(Icons.add_circle_outline),
                color: Theme.of(context).hintColor,
              )
            ],
          ),
        ],
      ));

  Widget _listTile(Product item) => Container(
        margin: const EdgeInsets.only(
            left: AppTheme.kBodyPadding,
            right: AppTheme.kBodyPadding,
            top: AppTheme.kBodyPadding),
        child: CustomCard(
            child: Row(
          children: [
            Checkbox(
              value: item.selected ?? false,
              onChanged: (bool v) {
                item.selected = v;
                setState(() {});
              },
            ),
            Expanded(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.all(AppTheme.kBodyPadding * 0.5),
                isThreeLine: true,
                title: Text(
                  item.name ?? '',
                  style: Theme.of(context).textTheme.caption,
                ),
                subtitle: Container(
                  padding:
                      const EdgeInsets.only(top: AppTheme.kBodyPadding * 0.5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_priceIndicator(item), _quantityButton(item)],
                  ),
                ),
              ),
            ),
          ],
        )),
      );

  ListView _productList(List<Product> list) => ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, i) {
        return _listTile(list[i]);
      });

  Widget _body() => SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          bloc: _bloc,
          builder: (BuildContext context, ProductState state) {
            if (state is ProductInitial || state is Loading) {
              return FakeListWidget(20, _listTile(Product()));
            } else if (state is DataLoaded) {
              return Column(
                children: [
                  Container(
                    child: ListTile(
                      isThreeLine: true,
                      title: Text(
                        'Products: ${_bloc.selectedProduct(state.data)} / ${state.data.length}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                          'Total units: ${_bloc.totalSelectedUnits(state.data)}',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Theme.of(context).colorScheme.secondary)),
                      trailing: Text(
                          'Total price: ${_bloc.totalPrice(state.data)}',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Theme.of(context).colorScheme.secondary)),
                    ),
                  ),
                  SpacerWidget(AppTheme.kBodyPadding),
                  Expanded(child: _productList(state.data)),
                  SpacerWidget(AppTheme.kBodyPadding),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: AppTheme.kBodyPadding),
                    child: CommonButtonWidget(
                      buttonText: 'Continue',
                      onTap: (v) {
                        List<Product> _selectedProduct = state.data
                            .where((Product element) =>
                                element.selected != null && element.selected)
                            .toList();
                        if (_selectedProduct.length > 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Page2(
                                        selectedProducts: _selectedProduct,
                                      )));
                        } else {
                          Utility.showSnackBar(_scaffoldKey,
                              'Please select at least one product.', context);
                        }
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _body(),
    );
  }
}
