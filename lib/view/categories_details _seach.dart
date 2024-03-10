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

class CategoriesDetailsSearchScreen extends StatefulWidget {
  const CategoriesDetailsSearchScreen(
      {super.key, required this.appbarTitle, required this.id});
  final String appbarTitle;
  final String id;

  @override
  State<CategoriesDetailsSearchScreen> createState() =>
      _CategoriesDetailsSearchScreenState();
}

class _CategoriesDetailsSearchScreenState
    extends State<CategoriesDetailsSearchScreen> {
  SortType? _selectedSort;
  String _query = "";
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'What are you looking for ?',
                hintStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: Color(0xff12c1b1),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                    height: 20,
                    width: 20,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(55),
                  borderSide: const BorderSide(
                    width: 1,
                    style: BorderStyle.none,
                    color: Color(0xff12c1b1),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(55),
                  borderSide: const BorderSide(
                    width: 1,
                    style: BorderStyle.none,
                    color: Color(0xff12c1b1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(55),
                  borderSide: const BorderSide(
                    width: 1,
                    style: BorderStyle.none,
                    color: Color(0xff12c1b1),
                  ),
                ),
                filled: true,
                contentPadding: const EdgeInsets.all(16),
                fillColor: const Color(0xfff2fffe),
              ),
              onChanged: (value) {
                setState(() {
                  _query = value;
                });
              },
            ),
            Consumer<ProductByCategoryProvider>(
                builder: (context, value, child) {
              switch (value.poductByCategory.status) {
                case Status.loading:
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                case Status.completed:
                  final products = value.poductByCategory.data?.products
                          .where((element) =>
                              element.name
                                  .toLowerCase()
                                  .contains(_query.toLowerCase()) ||
                              element.description
                                  .toLowerCase()
                                  .contains(_query.toLowerCase()) ||
                              element.material
                                  .toLowerCase()
                                  .contains(_query.toLowerCase()))
                          .toList() ??
                      [];
                  if (products.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.all(12.0.h),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Products not')),
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
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 6,
                              childAspectRatio: 155 / 273),
                      itemCount: products.length,
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
            }),
          ],
        ),
      ),
    );
  }
}
