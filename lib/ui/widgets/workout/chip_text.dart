import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OptionChip extends StatefulWidget {
  final List<String> optionChips;

  final ValueChanged? onChanged;

  OptionChip({Key? key, required this.optionChips, this.onChanged})
      : super(key: key);
  // final Function isCompletedCallback;
  // final Function problemsCallback;
  @override
  _OptionChipState createState() => _OptionChipState();
}

class _OptionChipState extends State<OptionChip> {
  List<bool>? _selectedValues;
  List<String>? chips;
  List<String> replies = [];

  List<int> queryYears = [];

  @override
  void initState() {
    initializeChips();
    super.initState();
  }

  initializeChips() {
    chips = List.from(widget.optionChips, growable: true);
    _selectedValues = List.generate(chips!.length, (index) => false);
    _selectedValues![0] = true;
  }

  onTapped(value) {
    if (value > 0) {
      _selectedValues![0] = false;

      queryYears = [];
      int i = 0;

      _selectedValues!.forEach((year) {
        if (year) {
          queryYears.add(int.parse(chips![i]));
        }
        i++;
      });
      widget.onChanged!(queryYears);
    }

    setState(() {
      print(_selectedValues);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return buildChips(width);
  }

  Widget buildChips(double width) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.07,
        vertical: width * 0.025,
      ),
      child: Wrap(
        children: List.generate(chips!.length, (index) {
          return Container(
            padding: EdgeInsets.only(right: width * 0.02),
            child: ChoiceChip(
              selected: _selectedValues![index],
              onSelected: (value) {
                _selectedValues![index] = value;
                onTapped(index);
              },
              label: FittedBox(
                child: AutoSizeText(
                  chips![index],
                ),
              ),
              labelStyle: TextStyle(
                color: _selectedValues![index]
                    ? const Color(0xFFFFFFFF)
                    : const Color(0xFF000000),
                fontSize: 16,
              ),
              labelPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.035, vertical: width * 0.007),
              selectedColor: const Color(0xCC5785f3),
              backgroundColor: const Color(0xFFFFFFFF),
              shadowColor: Colors.white,
              pressElevation: 0,
              elevation: 15,
              selectedShadowColor: const Color(0xFFF8F8FF),
            ),
          );
        }),
      ),
    );
  }
}
