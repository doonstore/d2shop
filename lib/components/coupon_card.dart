import 'package:d2shop/config/firestore_services.dart';
import 'package:d2shop/models/coupon_model.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CouponCard extends StatefulWidget {
  @override
  _CouponCardState createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  final TextEditingController _tec = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: FaIcon(FontAwesomeIcons.times),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      contentPadding: EdgeInsets.fromLTRB(24, 0, 24, 24),
      scrollable: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Apply Promo",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: _tec,
            decoration: Utils.inputDecoration("Promo Code",
                hint: "Enter promo code here"),
            style: Utils.formTextStyle(),
            textCapitalization: TextCapitalization.characters,
          ),
          SizedBox(height: 15),
          Utils.basicBtn(
            context,
            text: 'APPLY',
            onTap: () async {
              if (_tec.text.isNotEmpty) {
                CouponModel couponModel = await checkCoupon(_tec.text);

                if (couponModel.message == null) {
                  Utils.showMessage("Invalid Promo Code!", error: true);
                  Navigator.pop(context);
                  return;
                }

                if (DateTime.parse(couponModel.validTill)
                    .difference(DateTime.now())
                    .isNegative) {
                  Utils.showMessage("Promo Code has been expired!",
                      error: true);
                  Navigator.pop(context);
                  return;
                }

                Utils.showMessage(
                    "${couponModel.promoCode} has been applied. ${couponModel.message}");
                Provider.of<ApplicationState>(context, listen: false)
                    .setCoupon(couponModel);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
