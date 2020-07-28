import 'package:d2shop/components/category_data.dart';
import 'package:d2shop/config/firestore_services.dart';
import 'package:d2shop/components/item_info.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/screens/request_product.dart';
import 'package:d2shop/state/application_state.dart';
import 'package:d2shop/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CategoryExplorer extends StatefulWidget {
  @override
  _CategoryExplorerState createState() => _CategoryExplorerState();
}

class _CategoryExplorerState extends State<CategoryExplorer> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Item>>.value(
      value: listOfItems,
      builder: (context, child) => SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController queryController = TextEditingController();

  List<Item> dataList = [], filteredList = [];
  List<Category> categoryList = <Category>[];

  @override
  void initState() {
    super.initState();
    queryController.addListener(() {
      if (queryController.text.isNotEmpty) {
        filteredList = dataList
            .where((e) => e.name.toLowerCase().contains(queryController.text))
            .toList();

        setState(() {});
      } else {
        filteredList.clear();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    queryController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dataList = Provider.of<List<Item>>(context) ?? [];
    categoryList = Provider.of<ApplicationState>(context).categoryList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
          color: Colors.black54,
        ),
        title: TextField(
          controller: queryController,
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search for milk & groceries...',
            isDense: true,
          ),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: queryController.text.isEmpty
          ? CategoryData(dataList: categoryList)
          : filteredList.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        '${filteredList.length} results found for "${queryController.text}"',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) =>
                            ItemInfo(item: filteredList[index]),
                        itemCount: filteredList.length,
                      ),
                    )
                  ],
                )
              : NoDataWidget(),
    );
  }
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Not result found!',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black45,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 25),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[100].withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  'Looks like we don\'t have this product listed yet',
                  style: GoogleFonts.oxygen(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Text(
                  'Tell us what you are looking for and we will do our best to list at the earliest',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: OutlineButton(
                    borderSide: BorderSide(color: Colors.blue[400]),
                    splashColor: Colors.blue,
                    onPressed: () => MyRoute.push(context, RequestProduct()),
                    child: Text('Request a product'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
