import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:raj_lines/view/categories_screen.dart';
import '../provider/home_provider.dart';

class MainCategorySearch extends StatefulWidget {
  const MainCategorySearch({super.key});

  @override
  State<MainCategorySearch> createState() => _MainCategorySearchState();
}

class _MainCategorySearchState extends State<MainCategorySearch> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String query = "";
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
                  query = value;
                });
              },
            ),
            Expanded(
              child: Consumer<HomeProvider>(
                builder: (context, value, child) {
                  final mainCategories = (value.homeData.data?.mainCategories
                          .where((element) => element.name
                              .toLowerCase()
                              .contains(query.toLowerCase())))?.toList() ??
                      [];

                  return GridView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 153 / 211),
                    itemCount: mainCategories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CategoriesScreen(
                              id: mainCategories[index].id,
                              type: value
                                  .homeData.data!.mainCategories[index].name,
                            ),
                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 9.h, left: 13.w, right: 13.w),
                          decoration: BoxDecoration(
                            color: const Color(0xffF4F4F4),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 141.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        mainCategories[index].imageUrl.url,
                                      ),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                mainCategories[index].name,
                                style: const TextStyle(
                                    fontFamily: 'Poppins', fontSize: 10),
                              ),
                              Text(
                                'Starting from ${mainCategories[index].startingPrice} ₹',
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
