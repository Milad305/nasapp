import 'package:flutter/material.dart';
import 'package:nasboard/src/model/data.dart';
import 'package:nasboard/src/themes/light_color.dart';
import 'package:nasboard/src/themes/theme.dart';
import 'package:nasboard/src/widgets/title_text.dart';
import 'package:nasboard/src/widgets/extentions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:nasboard/src/widgets/product_counter.dart';
class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({Key key}) : super(key: key);
  static const String routeName = '/detail';

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isLiked = true;
  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

          ///like bottun  top left
          /* _icon(isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? LightColor.red : LightColor.lightGrey,
              size: 15,
              padding: 12,
              isOutLine: false, onPressed: () {
            setState(() {
              isLiked = !isLiked;
            });
          }),*/
        ],
      ),
    );
  }

  Widget _icon(
      IconData icon, {
        Color color = LightColor.iconColor,
        double size = 20,
        double padding = 10,
        bool isOutLine = false,
        Function onPressed,
      }) {
    return Container(
      height: 40,
      width: 40,
      padding: EdgeInsets.all(padding),
      // margin: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: isOutLine ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
        isOutLine ? Colors.transparent : Theme.of(context).backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 5,
              spreadRadius: 10,
              offset: Offset(5, 5)),
        ],
      ),
      child: Icon(icon, color: color, size: size),
    ).ripple(() {
      if (onPressed != null) {
        onPressed();
      }
    }, borderRadius: BorderRadius.all(Radius.circular(13)));
  }

  Widget _productImage() {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: animation.value,
          child: child,
        );
      },
      animation: animation,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          TitleText(
            text: "NASBORD",
            fontSize: 70,
            color: LightColor.lightGrey,
          ),
          Container(
            height:200 ,
            margin: EdgeInsets.only(bottom: 20),
            child: Image.asset('assets/pro.png'),
          )

        ],
      ),
    );
  }

  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      width: AppTheme.fullWidth(context),
      height: 80,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          AppData.showThumbnailList.map((x) => _thumbnail(x)).toList()),
    );
  }

  Widget _thumbnail(String image) {
    return AnimatedBuilder(
      animation: animation,
      //  builder: null,
      builder: (context, child) => AnimatedOpacity(
        opacity: animation.value,
        duration: Duration(milliseconds: 500),
        child: child,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: LightColor.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(13)),
            // color: Theme.of(context).backgroundColor,
          ),
          child: Image.asset(image),
        ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13))),
      ),
    );
  }

  Widget _detailWidget() {
    int _invent = 10;
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .40,
      minChildSize: .40,
      builder: (context, scrollController) {
        return Container(
          padding: AppTheme.padding.copyWith(bottom: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: LightColor.iconColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TitleText(text: "برد گوشی A30", fontSize: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TitleText(
                                text: "\T ",
                                fontSize: 18,
                                color: LightColor.red,
                              ),
                              TitleText(
                                text: "400000",
                                fontSize: 25,
                              ),
                            ],
                          ),
                          ///rate bardashte shode
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                /*_availableSize(),*/

                SizedBox(
                  height: 20,
                ),
                _description(_invent),
              ],
            ),
          ),
        );
      },
    );
  }

  /*Widget _availableSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(
          text: "جزئیات",
          fontSize: 16,
        ),
        SizedBox(height: 20),
       /* Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _sizeWidget("نمایشگر شکسته"),
            _sizeWidget("بدون ریجستر", isSelected: true),
            _sizeWidget("ثبت تعمیری"),
            _sizeWidget("بدون تعمیر"),
          ],
        )*/
      ],
    );
  }*/

  /* Widget _sizeWidget(String text,
      {Color color = LightColor.iconColor, bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: LightColor.iconColor,
            style: !isSelected ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color:
            isSelected ? LightColor.red : Theme.of(context).backgroundColor,
      ),
      child: TitleText(
        text: text,
        fontSize: 14,
        color: isSelected ? LightColor.background : LightColor.titleTextColor,
      ),
    ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(13)));
  }
*/
  ///avalabe color deleted
  Widget _colorWidget(Color color, {bool isSelected = false}) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: color.withAlpha(150),
      child: isSelected
          ? Icon(
        Icons.check_circle,
        color: color,
        size: 18,
      )
          : CircleAvatar(radius: 7, backgroundColor: color),
    );
  }

  Widget _description(_invent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Text(
              "تعداد موجود:",
              style: TextStyle(
                  color: LightColor.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),

            Spacer(),

            Container(
                alignment: Alignment.center,
                height: 30,
                width: MediaQuery.of(context).size.width *0.15,
                decoration: BoxDecoration(
                    color: LightColor.lightGrey,
                    borderRadius: BorderRadius.circular(20)
                ),

                child:Center(
                  child: Text(
                    _invent.toString()+" عدد",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                )
            ),

          ],
        ),
        SizedBox(
          height: 30,
        ),
        TitleText(
          text: "توضیحات",
          fontSize: 14,
        ),
        SizedBox(height: 20),
        Text(AppData.description),
      ],
    );
  }

  FloatingActionButton _flotingButton() {
    return FloatingActionButton(
      onPressed: () {
        Alert(
            context: context,
            title: "تعداد محصول",
            content: Row(
              children: [
                MyCounter(),
                Spacer(),

              ],
            ),
            buttons: [
              DialogButton(
                color: LightColor.orange,
                onPressed: () {
                  ///inja bayad az tedad mojood dar anbar kaste beshe va dar
                  ///database update beshe
                  // _invent =-_currentAmount;
                  Navigator.pop(context);
                } ,
                child: Text(
                  "افزودن به سبد خرید",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ]).show();
      },
      backgroundColor: LightColor.orange,
      child: Icon(Icons.shopping_basket,
          color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _flotingButton(),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xfffbfbfb),
                  Color(0xfff7f7f7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _appBar(),
                  _productImage(),
                  _categoryWidget(),
                ],
              ),
              _detailWidget()
            ],
          ),
        ),
      ),
    );
  }
}