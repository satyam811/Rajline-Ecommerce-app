import 'package:flutter/material.dart';
import 'package:raj_lines/utils/enums.dart';

Future<SortType?> sortDialog(
    BuildContext context, SortType? selectedSort) async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      // height: ScreenUtil().screenHeight * 0.3,
      content: StatefulBuilder(
        builder: (context, setState) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Sort By:'),
            RadioListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Price Highest To Lowest'),
              value: SortType.highToLow,
              groupValue: selectedSort,
              onChanged: (value) {
                selectedSort = value;
                setState(() {});
              },
            ),
            RadioListTile(
                title: const Text('Price Lowest To Highest'),
                contentPadding: EdgeInsets.zero,
                value: SortType.lowToHigh,
                groupValue: selectedSort,
                onChanged: (value) {
                  selectedSort = value;
                  setState(() {});
                }),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, selectedSort);
            },
            child: const Text('Ok'))
      ],
    ),
  );
}
