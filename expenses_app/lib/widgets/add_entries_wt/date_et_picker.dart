import 'package:expenses_app/models/combined_model.dart';
import 'package:flutter/material.dart';

class DateEntriesPicker extends StatefulWidget {
  final CombinedModel cModel;
  const DateEntriesPicker({super.key, required this.cModel});

  @override
  State<DateEntriesPicker> createState() => _DateEntriesPickerState();
}

class _DateEntriesPickerState extends State<DateEntriesPicker> {
  String selectedDay = 'Hoy';

  @override
  void initState() {
    if (widget.cModel.day == 0) {
      widget.cModel.day = DateTime.now().day;
      widget.cModel.month = DateTime.now().month;
      widget.cModel.year = DateTime.now().year;
    } else {
      selectedDay = 'Otro día';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime _date = DateTime.now();
    var _widgets = <Widget>[];

    _widgets.insert(0, const Icon(Icons.date_range_outlined, size: 35.0));
    _widgets.insert(1, const SizedBox(width: 4));

    _calendar() {
      showDatePicker(
              
              context: context,
              locale: const Locale('es', 'ES'),
              initialDate: _date.subtract(const Duration(hours: 24 * 2)),
              firstDate: _date.subtract(const Duration(hours: 24 * 30)),
              lastDate: _date.subtract(const Duration(hours: 24 * 2)))
          .then((value) {
        setState(() {
          if (value != null) {
            widget.cModel.day = value.day;
            widget.cModel.month = value.month;
            widget.cModel.year = value.year;
          } else {
            setState(() {
              selectedDay = 'Hoy';
            });
          }
        });
      });
    }

    Map<String, DateTime> items = {
      'Hoy': _date,
      'Ayer': _date.subtract(const Duration(hours: 24)),
      'Otro día': _date
    };

    items.forEach((name, date) {
      _widgets.add(Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              selectedDay = name;
              widget.cModel.day = date.day;
              widget.cModel.month = date.month;
              widget.cModel.year = date.year;
              if (name == 'Otro día') _calendar();
            });
          },
          child: DateContainWidget(
            cModel: widget.cModel,
            name: name,
            isSelected: name == selectedDay,
          ),
        ),
      ));
    });

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(children: _widgets),
    );
  }
}

class DateContainWidget extends StatelessWidget {
  final CombinedModel cModel;
  final String name;
  final bool isSelected;
  const DateContainWidget(
      {super.key,
      required this.cModel,
      required this.name,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: isSelected
                    ? Colors.green
                    : Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(25.0)),
            child: Center(
              child: Text(name),
            ),
          ),
        ),
        isSelected
            ? FittedBox(
                fit: BoxFit.fitWidth,
                child: Text('${cModel.day}/${cModel.month}/${cModel.year}'),
              )
            : const Text('')
      ],
    );
  }
}
