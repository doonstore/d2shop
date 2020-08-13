import 'package:cached_network_image/cached_network_image.dart';
import 'package:d2shop/components/category_info.dart';
import 'package:d2shop/models/shopping_model.dart';
import 'package:d2shop/utils/constants.dart';
import 'package:d2shop/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryData extends StatelessWidget {
  const CategoryData({
    Key key,
    @required this.dataList,
  }) : super(key: key);

  final List<Category> dataList;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 15),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => MyRoute.push(
                context,
                CategoryInfo(
                  category: dataList[index],
                  colorCode: index % 8,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            kBackgroundColorsList[index % 8].withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: dataList[index].photoUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    dataList[index].name,
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w400,
                      fontSize: 13.sp,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
