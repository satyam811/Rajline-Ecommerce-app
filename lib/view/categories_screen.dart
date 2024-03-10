import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/data/response/status.dart';
import 'package:raj_lines/provider/category_provider.dart';
import 'package:raj_lines/res/colors.dart';
import 'package:raj_lines/utils/enums.dart';
import 'package:raj_lines/utils/sort_dialog.dart';
import 'package:raj_lines/view/categories_details.dart';
import 'package:raj_lines/view/sub_category_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.id, required this.type});
  final String id;
  final String type;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<CategoryProvider>().fetchHomeData(widget.id);
    });
    super.initState();
  }

  // final items = CategoriesProduct.getCategoriesProducts();
  SortType? _selectedSort;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_ios_new_outlined)),
        centerTitle: true,
        title: Text(
          widget.type,
          style: const TextStyle(
              fontFamily: 'Poppins',
              color: AppColor.white,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff12C1B1), Color(0xff0C68AD)])),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubCategorySearch(
                      type: widget.type,
                    ),
                  ));
            },
            icon: const Icon(Icons.search),
          ),
          InkWell(
            onTap: () async {
              _selectedSort = await sortDialog(context, _selectedSort);
              setState(() {});
            },
            child: Container(
              height: 30.h,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sort',
                    style: GoogleFonts.assistant(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  SvgPicture.asset(
                    'assets/icons/sort.svg',
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Consumer<CategoryProvider>(builder: (context, value, child) {
            switch (value.subCategory.status) {
              case Status.loading:
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              case Status.completed:
                final subCategories =
                    value.subCategory.data?.subCategories ?? [];
                if (_selectedSort == SortType.highToLow) {
                  subCategories.sort(
                    (a, b) => b.startingPrice.compareTo(a.startingPrice),
                  );
                }
                if (_selectedSort == SortType.lowToHigh) {
                  subCategories.sort(
                    (a, b) => a.startingPrice.compareTo(b.startingPrice),
                  );
                }
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => value.fetchHomeData(widget.id),
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 12.h),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 145 / 237),
                      itemCount: subCategories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CategoriesDetailsScreen(
                                appbarTitle: subCategories[index].name,
                                id: subCategories[index].id,
                              ),
                            ));
                          },
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 177.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          subCategories[index].imageUrl.url,
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                SizedBox(
                                  height: 9.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 11.w),
                                  child: Text(
                                    subCategories[index].name,
                                    style: GoogleFonts.assistant(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff282C3F)),
                                  ),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 11.w),
                                    child: Text(
                                      'starting from ${subCategories[index].startingPrice}',
                                      style: GoogleFonts.assistant(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff535766)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              case Status.error:
                return Center(
                  child: Text(value.subCategory.message.toString()),
                );
              default:
            }
            return Container();
          })
        ],
      ),
    );
  }
}
