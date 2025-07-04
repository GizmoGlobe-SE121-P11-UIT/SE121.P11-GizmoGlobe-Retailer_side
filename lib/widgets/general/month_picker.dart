import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthPicker extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime) updateSelectedDate;

  const MonthPicker({
    super.key,
    required this.selectedDate,
    required this.updateSelectedDate,
  });

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate;
  }

  void onNext() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
    });
    widget.updateSelectedDate(selectedDate);
  }

  void onPrevious() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
    });
    widget.updateSelectedDate(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0, bottom: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_left,
                size: 30,
              ),
              onPressed: onPrevious,
            ),
            Column(
              children: List<Widget>.generate(1, (index) {
                return TextButton(
                  onPressed: () async {
                    final DateTime? newDate = await _pickMonthYear();
                    if (newDate != null) {
                      setState(() {
                        selectedDate = newDate;
                      });
                      widget.updateSelectedDate(newDate);
                    }
                  },
                  child: Text(
                    DateFormat.yMMM().format(selectedDate),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                );
              }),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_right,
                size: 30,
              ),
              onPressed: onNext,
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _pickMonthYear() async {
    int selectedMonthIndex = selectedDate.month;
    int selectedYearIndex = selectedDate.year - 2000;

    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        DateTime tempPickedDate = selectedDate;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Choose month and year',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  )),
              content: SizedBox(
                height: 150,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ListWheelScrollView(
                        itemExtent: 50,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedMonthIndex = index;
                            tempPickedDate = DateTime(
                              tempPickedDate.year,
                              index + 1,
                            );
                          });
                        },
                        controller: FixedExtentScrollController(
                            initialItem: selectedMonthIndex),
                        children: List<Widget>.generate(12, (index) {
                          bool isBold = index == selectedMonthIndex;
                          return Center(
                            child: Text(
                              DateFormat.MMMM().format(DateTime(0, index + 1)),
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: isBold
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Expanded(
                      child: ListWheelScrollView(
                        itemExtent: 50,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedYearIndex = index;
                            tempPickedDate = DateTime(
                              index + 2000,
                              tempPickedDate.month,
                            );
                          });
                        },
                        controller: FixedExtentScrollController(
                            initialItem: selectedYearIndex),
                        children: List<Widget>.generate(101, (index) {
                          bool isBold = index == selectedYearIndex;
                          return Center(
                            child: Text(
                              '${index + 2000}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: isBold
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(tempPickedDate);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      return picked;
    }
    return null;
  }
}
