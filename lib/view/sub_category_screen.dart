import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/provider/category_provider.dart';
import 'package:raj_lines/view/categories_details.dart';

class SubCategorySearch extends StatefulWidget {
  const SubCategorySearch({super.key, required this.type});
  final String type;

  @override
  State<SubCategorySearch> createState() => _SubCategorySearchState();
}

class _SubCategorySearchState extends State<SubCategorySearch> {
  final TextEditingController _controller = TextEditingController();

  String query = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              autofocus: true,
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
                  query = value;
                });
              },
            ),
            Expanded(
              child: Consumer<CategoryProvider>(
                builder: (context, value, child) {
                  final mainCategories = (value.subCategory.data?.subCategories
                          .where((element) => element.name
                              .toLowerCase()
                              .contains(query.toLowerCase())))?.toList() ??
                      [];
                  return GridView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 145 / 237),
                    itemCount: mainCategories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CategoriesDetailsScreen(
                              appbarTitle: mainCategories[index].name,
                              id: mainCategories[index].id,
                              //             type: value
                              //                 .subCategory.data!.subCategories[index].name,,
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
                                        mainCategories[index].imageUrl.url,
                                      ),
                                      fit: BoxFit.fill),
                                ),
                                // child: Image.asset(
                                //   imageList2[index]['imagePath'],
                                //   fit: BoxFit.fitWidth,
                                // ),
                              ),
                              SizedBox(
                                height: 9.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 11.w),
                                child: Text(
                                  mainCategories[index].name,
                                  style: GoogleFonts.assistant(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff282C3F)),
                                ),
                              ),
                              SizedBox(
                                height: 9.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 11.w),
                                child: Text(
                                  "starting from ${mainCategories[index].startingPrice}",
                                  style: GoogleFonts.assistant(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff535766)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  // return GridView.builder(
                  //   padding: EdgeInsets.zero,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   gridDelegate:
                  //       const SliverGridDelegateWithFixedCrossAxisCount(
                  //           crossAxisCount: 2,
                  //           crossAxisSpacing: 10,
                  //           mainAxisSpacing: 10,
                  //           childAspectRatio: 153 / 211),
                  //   itemCount: mainCategories.length,
                  //   itemBuilder: (context, index) {
                  //     return InkWell(
                  //       onTap: () {
                  //         Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (context) => CategoriesScreen(
                  //             id: mainCategories[index].id,
                  //             type: value
                  //                 .subCategory.data!.subCategories[index].name,
                  //           ),
                  //         ));
                  //       },
                  //       child: Container(
                  //         padding: EdgeInsets.only(
                  //             top: 9.h, left: 13.w, right: 13.w),
                  //         decoration: BoxDecoration(
                  //           color: const Color(0xffF4F4F4),
                  //           borderRadius: BorderRadius.circular(17),
                  //         ),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               width: double.infinity,
                  //               height: 141.h,
                  //               decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(12),
                  //                 image: DecorationImage(
                  //                     image: NetworkImage(
                  //                       mainCategories[index].imageUrl.url,
                  //                     ),
                  //                     fit: BoxFit.fill),
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               height: 2.h,
                  //             ),
                  //             Text(
                  //               mainCategories[index].name,
                  //               style: const TextStyle(
                  //                   fontFamily: 'Poppins', fontSize: 10),
                  //             ),
                  //             Text(
                  //               'Starting from ${mainCategories[index].startingPrice} ₹',
                  //               style: const TextStyle(
                  //                   fontFamily: 'Poppins',
                  //                   fontSize: 11,
                  //                   fontWeight: FontWeight.bold),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
