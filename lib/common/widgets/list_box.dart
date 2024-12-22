import 'package:flutter/material.dart';
import 'package:flutter_author_reader_app/common/widgets/list_member_box.dart';
import 'package:flutter_author_reader_app/core/app_colors.dart';
import 'package:flutter_author_reader_app/pages/list.dart';

class ListBox extends StatelessWidget {
  final listName;

  const ListBox({
    Key? key,
    required this.listName,
  })  : super(key: key);

  @override
  Widget build(BuildContext context)  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: [
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 8,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 5,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Container(
                  height: 28,
                  width: 200,
                  child: Text(
                    listName,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: 'holen_vintage',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                  TextButton(
                    onPressed: () {
                      // Handle the tap event here.
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListPage()),
                      );
                      print('"See All" button tapped!');
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontFamily: 'liberation_sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 150, // set it to double.minPositive later.
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 8,
                ),
              ],
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Container(
              child: GridView.count(
                crossAxisCount: 1,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: ScrollPhysics(),
                padding: EdgeInsets.only(top: 5),
                children: [
                  // Add list members here.
                  ListMemberBox(),
                  ListMemberBox(),
                  ListMemberBox(),
                  ListMemberBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}