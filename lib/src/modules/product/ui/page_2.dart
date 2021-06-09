import 'package:app/src/modules/product/bloc/product_bloc.dart';
import 'package:app/src/modules/product/models/product.dart';
import 'package:app/src/modules/product/ui/page_3.dart';
import 'package:app/src/styles/theme.dart';
import 'package:app/src/widgets/common_button_widget.dart';
import 'package:app/src/widgets/custom_card_widget.dart';
import 'package:app/src/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  final List<Product> selectedProducts;
  Page2({Key key, @required this.selectedProducts}) : super(key: key);
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final ProductBloc _bloc = ProductBloc();
  TextEditingController _textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SpacerWidget(AppTheme.kBodyPadding),
          item.selectedColor != null
              ? Text('Varients(Color) : ${item.selectedColor ?? ''}',
                  style: Theme.of(context).textTheme.subtitle1)
              : Container(),
          item.selectedSize != null
              ? Text('Varients(Size) : ${item.selectedSize ?? ''}',
                  style: Theme.of(context).textTheme.subtitle1)
              : Container(),
        ],
      );

  Widget _quantityButton(Product item) => Container(
          child: Column(
        children: [
          Text('Quantity', style: Theme.of(context).textTheme.subtitle1),
          Text('${item.quantity}',
              style: Theme.of(context).textTheme.subtitle1),
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
            Expanded(
              child: ListTile(
                onTap: () async {
                  final _returned = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Page3Page(
                                product: item,
                              )));
                  setState(() {
                    item = _returned;
                  });
                },
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
            Icon(Icons.keyboard_arrow_right)
          ],
        )),
      );

  ListView _productList(List<Product> list) => ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, i) {
        return _listTile(list[i]);
      });

  Widget _body() => SafeArea(
          child: Column(
        children: [
          Expanded(child: _productList(widget.selectedProducts)),
          SpacerWidget(AppTheme.kBodyPadding),
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppTheme.kBodyPadding),
            child: CommonButtonWidget(
              buttonText: 'Add Product',
              onTap: (v) {},
            ),
          ),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selected Products',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: _body(),
    );
  }
}
