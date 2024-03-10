import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/data/response/status.dart';
import 'package:raj_lines/provider/productby_category_provider.dart';
import 'package:raj_lines/res/colors.dart';
import 'package:raj_lines/utils/sort_dialog.dart';
import 'package:raj_lines/view/product_details_screen.dart';

import '../utils/enums.dart';
import 'categories_details _seach.dart';

class CategoriesDetailsScreen extends StatefulWidget {
  const CategoriesDetailsScreen(
      {super.key, required this.appbarTitle, required this.id});
  final String appbarTitle;
  final String id;

  @override
  State<CategoriesDetailsScreen> createState() =>
      _CategoriesDetailsScreenState();
}

class _CategoriesDetailsScreenState extends State<CategoriesDetailsScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<ProductByCategoryProvider>().fetchHomeData(widget.id);
    });
    super.initState();
  }

  SortType? _selectedSort;
  // final items = Product.getProducts();
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
          widget.appbarTitle,
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CategoriesDetailsSearchScreen(
                        appbarTitle: widget.appbarTitle, id: widget.id)));
              },
              icon: const Icon(Icons.search)),
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
          Consumer<ProductByCategoryProvider>(builder: (context, value, child) {
            switch (value.poductByCategory.status) {
              case Status.loading:
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              case Status.completed:
                final products = value.poductByCategory.data?.products ?? [];
                if (_selectedSort == SortType.highToLow) {
                  products.sort(
                    (a, b) => b.price.compareTo(a.price),
                  );
                }
                if (_selectedSort == SortType.lowToHigh) {
                  products.sort(
                    (a, b) => a.price.compareTo(b.price),
                  );
                }
                return Expanded(
                    child: RefreshIndicator(
                  onRefresh: () => value.fetchHomeData(widget.id),
                  child: value.poductByCategory.data?.products.isEmpty ?? true
                      ? const Center(
                          child: Text("Products not found"),
                        )
                      : GridView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 12.h),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6,
                                  childAspectRatio: 155 / 273),
                          itemCount:
                              value.poductByCategory.data?.products.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                      title: products[index].name,
                                      id: products[index].id),
                                ));
                              },
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 200.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              products[index].mainImage.url,
                                            ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 7.w),
                                      child: Text(
                                        products[index].name,
                                        style: GoogleFonts.assistant(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xff282C3F)),
                                      ),
                                    ),
                                    // Text(
                                    //   products[index].description,
                                    //   overflow: TextOverflow.ellipsis,
                                    //   maxLines: 1,
                                    //   style: GoogleFonts.assistant(
                                    //       fontSize: 15,
                                    //       fontWeight: FontWeight.w400,
                                    //       color: const Color(0xff535766)),
                                    // ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 7.w),
                                      child: Text(
                                        'Rs. ${products[index].price}',
                                        style: GoogleFonts.assistant(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xff282C3F)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ));
              case Status.error:
                return Center(
                  child: Text(value.poductByCategory.message.toString()),
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
