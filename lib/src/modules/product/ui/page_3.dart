import 'package:app/src/modules/product/models/product.dart';
import 'package:app/src/modules/product/models/product_variants.dart';
import 'package:app/src/services/utility.dart';
import 'package:app/src/styles/theme.dart';
import 'package:app/src/widgets/custom_card_widget.dart';
import 'package:app/src/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';

class Page3Page extends StatefulWidget {
  final Product product;
  Page3Page({Key key, @required this.product}) : super(key: key);
  @override
  _Page3PageState createState() => _Page3PageState();
}

class _Page3PageState extends State<Page3Page> {
  Widget _priceIndicator(Product item) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Rs ${item.sp ?? ''}',
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Theme.of(context).primaryColor),
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

  Widget _listTile(Product item) => Container(
        child: CustomCard(
            child: ListTile(
          onTap: () {},
          contentPadding: const EdgeInsets.all(AppTheme.kBodyPadding * 0.5),
          // isThreeLine: true,
          title: Text(
            item.name ?? '',
            style: Theme.of(context).textTheme.caption,
          ),
          subtitle: Container(
            padding: const EdgeInsets.only(top: AppTheme.kBodyPadding * 0.5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _priceIndicator(item),
                Text('Quantity:  ${item.quantity}',
                    style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ),
        )),
      );

  Widget _colorVariant(Product item) {
    List<ProductVariants> _colorOption = item.productVariants
        .where((ProductVariants v) => v.variantType == 'color')
        .toList();
    return _colorOption != null && _colorOption.length > 0
        ? CustomCard(
            child: ListTile(
              title: Text('Color Variant',
                  style: Theme.of(context).textTheme.caption),
              trailing: item.selectedColor != null
                  ? Text(item.selectedColor)
                  : Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Widget _body = Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _colorOption
                      .map<Widget>((i) => ListTile(
                            title: Text(i.variantValue ?? ''),
                            onTap: () {
                              setState(() {
                                item.selectedColor = i.variantValue ?? '';
                              });
                              Navigator.pop(context);
                            },
                          ))
                      .toList(),
                );
                Utility.showBottomSheet(_body, context);
              },
            ),
          )
        : Container();
  }

  Widget _sizeVariant(Product item) {
    List<ProductVariants> _colorOption = item.productVariants
        .where((ProductVariants v) => v.variantType == 'size')
        .toList();
    return _colorOption != null && _colorOption.length > 0
        ? CustomCard(
            child: ListTile(
              title: Text('Size Variant',
                  style: Theme.of(context).textTheme.caption),
              trailing: item.selectedSize != null
                  ? Text(item.selectedSize)
                  : Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Widget _body = Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _colorOption
                      .map<Widget>((i) => ListTile(
                            title: Text(i.variantValue ?? ''),
                            onTap: () {
                              setState(() {
                                item.selectedSize = i.variantValue ?? '';
                              });
                              Navigator.pop(context);
                            },
                          ))
                      .toList(),
                );
                Utility.showBottomSheet(_body, context);
              },
            ),
          )
        : Container();
  }

  Widget _body() => Container(
      margin: const EdgeInsets.all(AppTheme.kBodyPadding),
      child: Column(
        children: [
          _listTile(widget.product),
          SpacerWidget(AppTheme.kBodyPadding),
          _colorVariant(widget.product),
          SpacerWidget(AppTheme.kBodyPadding),
          _sizeVariant(widget.product)
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){},
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.product.name ?? '',
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (){
                print( widget.product);
                Navigator.pop(context, widget.product);
              },
            ),
          ),
          body: _body()),
    );
  }
}
