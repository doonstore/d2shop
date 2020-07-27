import 'package:d2shop/helper/item_info.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryInfo extends StatelessWidget {
  final int colorCode;
  final Category category;

  const CategoryInfo({@required this.category, this.colorCode});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
    final Color color = kBackgroundColorsList[colorCode];

    return Scaffold(
      key: _globalKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: color.withOpacity(0.6),
            leading: IconButton(
              icon: FaIcon(FontAwesomeIcons.chevronLeft, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            elevation: 0.0,
            title: Utils.searchCard(color, context),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [InfoCard(color: color, category: category)],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int i) =>
                  ShowDataItems(color: color, index: i),
              childCount: category.itemList.length,
            ),
          )
        ],
      ),
    );
  }
}

class ShowDataItems extends StatelessWidget {
  const ShowDataItems({Key key, this.index, @required this.color})
      : super(key: key);

  final Color color;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Heading #$index',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text('10 items'),
      children: List.generate(
        2,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: GestureDetector(
            onTap: () {
              showBottomSheet(
                context: context,
                builder: (context) => ItemInfo(),
              );
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/item/2.png',
                  width: 70,
                  height: 80,
                ),
                SizedBox(width: 7),
                Expanded(
                  child: showItemInfo(
                    context,
                    title: 'Amul Milk (100 Ml)',
                    desc: '2 Pkt',
                    price: 20.00,
                  ),
                ),
                SizedBox(width: 5),
                SizedBox(
                  height: 30,
                  width: 100,
                  child: btnAction('Add', FontAwesomeIcons.plus, true),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container btnAction(String text, IconData iconData, bool primary) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: primary ? color.withOpacity(0.2) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: primary ? null : Border.all(color: color),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(iconData, size: 12, color: color),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }

  Column showItemInfo(BuildContext context,
      {String title, String desc, double price}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.ptSans(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        Text(
          desc,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(color: Colors.black45),
        ),
        Text(
          '\u20b9$price',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key key,
    @required this.color,
    @required this.category,
  }) : super(key: key);

  final Color color;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withOpacity(0.6),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(category.photoUrl, width: 100),
              Expanded(
                child: ListTile(
                  title: Text(
                    category.name,
                    style: GoogleFonts.ubuntu(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${category.itemList.length} items',
                    style: GoogleFonts.stylish(
                      color: Colors.black45,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Text(
            'Suggestions',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 15),
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Placeholder(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
