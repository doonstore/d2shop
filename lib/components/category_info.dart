import 'package:d2shop/components/item_info.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CategoryInfo extends StatefulWidget {
  final int colorCode;
  final Category category;

  const CategoryInfo({@required this.category, this.colorCode});

  @override
  _CategoryInfoState createState() => _CategoryInfoState();
}

class _CategoryInfoState extends State<CategoryInfo> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
    final Color color = kBackgroundColorsList[widget.colorCode];

    return Consumer<ApplicationState>(
      builder: (context, value, child) => Scaffold(
        key: _globalKey,
        bottomSheet: value.cart.isNotEmpty
            ? Container(
                margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                color: Colors.transparent,
                child: value.showCart(),
              )
            : null,
        body: Builder(
          builder: (context) => CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: color.withOpacity(0.6),
                leading: IconButton(
                  icon:
                      FaIcon(FontAwesomeIcons.chevronLeft, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                elevation: 0.0,
                title: Utils.searchCard(color, context),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [InfoCard(color: color, category: widget.category)],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int i) {
                    String title = widget.category.itemList.keys.elementAt(i);
                    List<dynamic> itemList = widget.category.itemList[title]
                        .map((e) => Item.fromJson(e))
                        .toList();

                    return ExpansionTile(
                      title: Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('${itemList.length} items'),
                      children: itemList.map((e) => ItemInfo(item: e)).toList(),
                    );
                  },
                  childCount: widget.category.itemList.length,
                ),
              )
            ],
          ),
        ),
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
      children: [
        ListView.builder(itemBuilder: (context, index) => ItemInfo(item: null))
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
