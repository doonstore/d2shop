import 'package:d2shop/components/category_info.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/repository/shopping_repository.dart';
import 'package:d2shop/utils/constants.dart';
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
    return StreamProvider<List<Category>>.value(
      value: listOfCategories,
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

  List<Category> dataList = [], filteredList = [];

  @override
  void initState() {
    super.initState();
    queryController.addListener(() {
      if (queryController.text.isNotEmpty) {
        filteredList = dataList
            .where((e) => e.name
                .toLowerCase()
                .contains(queryController.text.toLowerCase()))
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
    dataList = Provider.of<List<Category>>(context) ?? [];

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
            labelText: 'Search',
            hintText: 'Search for milk & groceries...',
            isDense: true,
          ),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: DataList(
        dataList: queryController.text.isEmpty ? dataList : filteredList,
      ),
    );
  }
}

class DataList extends StatelessWidget {
  const DataList({
    Key key,
    @required this.dataList,
  }) : super(key: key);

  final List<Category> dataList;

  @override
  Widget build(BuildContext context) {
    return dataList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'Explore Categories',
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: GridView.builder(
                    itemCount: dataList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 35,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => MyRoute.push(
                        context,
                        CategoryInfo(
                          category: dataList[index],
                          colorCode: index % 8,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                color: kBackgroundColorsList[index % 8]
                                    .withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(2),
                              child: Image.asset(
                                dataList[index].photoUrl,
                                width: width(context) * 0.23,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              dataList[index].name,
                              style: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.w400,
                                fontSize: 13.sp,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : NoDataWidget();
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
                    onPressed: null,
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
