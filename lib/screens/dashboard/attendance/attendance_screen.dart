import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ipecstudents/data/base_bloc/base_bloc_builder.dart';
import 'package:ipecstudents/data/base_bloc/base_bloc_listener.dart';
import 'package:ipecstudents/data/base_bloc/base_state.dart';
import 'package:ipecstudents/data/repo/auth.dart';
import 'package:ipecstudents/data/repo/session.dart';
import 'package:ipecstudents/screens/dashboard/attendance/bloc/attendance_bloc.dart';
import 'package:ipecstudents/screens/dashboard/attendance/bloc/attendance_event.dart';
import 'package:ipecstudents/screens/dashboard/attendance/bloc/attendance_state.dart';
import 'package:ipecstudents/screens/dashboard/attendance/graph.dart';
import 'package:ipecstudents/theme/style.dart';
import 'package:ipecstudents/util/SizeConfig.dart';
import 'package:ipecstudents/widgets/simple_appbar.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget {
  static const String ROUTE = "/Attendance";
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final AttendanceBloc _bloc = AttendanceBloc();
  Auth _auth;
  @override
  void initState() {
    super.initState();
    _auth = Provider.of<Auth>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Session>(
      builder: (context, session, child) {
        return Scaffold(
          body: BaseBlocListener(
            bloc: _bloc,
            listener: (BuildContext context, BaseState state) {
              print("$runtimeType BlocListener - ${state.toString()}");
            },
            child: BaseBlocBuilder(
              bloc: _bloc,
              condition: (BaseState previous, BaseState current) {
                return !(BaseBlocBuilder.isBaseState(current));
              },
              builder: (BuildContext context, BaseState state) {
                print("$runtimeType BlocBuilder - ${state.toString()}");
                if (state is AttendanceInitState)
                  _bloc.add(LoadAttendance(_auth, session));
                return _getBody(session, context, state);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _getBody(Session session, BuildContext context, BaseState state) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SimpleAppBar(img: _auth.user.img.toString().split(',')[1]),
        kLowPadding,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            children: [
              Text(
                'Overview',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        kHighPadding,
        Text(
          'Total Attendance',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.black,
              ),
        ),
        kLowPadding,
        Text(
          state is AttendanceLoaded
              ? session.attendance.percent.toString() + "%"
              : '00.00%',
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        kLowPadding,
        AttendanceGraph(),
      ],
    ));
  }
}