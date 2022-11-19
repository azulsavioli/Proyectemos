import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../commons/strings.dart';
import '../../../commons/styles.dart';
import '../widgets/drawer_menu.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({Key? key}) : super(key: key);

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  CalendarFormat format = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Image.asset(
            Strings.logo,
            height: 10,
            width: 10,
            scale: 18,
          ),
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(250, 251, 250, 1),
          ),
          automaticallyImplyLeading: true,
          title: const Text('Agenda', style: ThemeText.h3title22White),
        ),
        endDrawer: const DrawerMenuWidget(),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TableCalendar(
                  locale: 'es_ES',
                  firstDay: DateTime.utc(1970, 01, 01),
                  lastDay: DateTime.utc(2030, 31, 12),
                  rangeStartDay: _focusedDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onFormatChanged: (CalendarFormat format) {
                    setState(
                      () {
                        format = format;
                      },
                    );
                  },
                  calendarFormat: format,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(
                      () {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      },
                    );
                  },
                  headerStyle: const HeaderStyle(formatButtonVisible: false),
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    rowDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      shape: BoxShape.rectangle,
                    ),
                    weekendDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    defaultDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      shape: BoxShape.rectangle,
                    ),
                    selectedDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      shape: BoxShape.rectangle,
                      color: ThemeColors.red,
                    ),
                    todayDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      shape: BoxShape.rectangle,
                      color: ThemeColors.yellow,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
