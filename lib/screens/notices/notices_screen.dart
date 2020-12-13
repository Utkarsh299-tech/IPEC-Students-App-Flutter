import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:ipecstudentsapp/data/base_bloc/base_bloc_builder.dart';
import 'package:ipecstudentsapp/data/base_bloc/base_bloc_listener.dart';
import 'package:ipecstudentsapp/data/base_bloc/base_state.dart';
import 'package:ipecstudentsapp/data/model/Notice.dart';
import 'package:ipecstudentsapp/data/repo/auth.dart';
import 'package:ipecstudentsapp/data/repo/session.dart';
import 'package:ipecstudentsapp/screens/notices/bloc/notice_event.dart';
import 'package:ipecstudentsapp/theme/style.dart';
import 'package:ipecstudentsapp/widgets/simple_appbar.dart';
import 'package:provider/provider.dart';
import 'package:ipecstudentsapp/util/string_cap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bloc/notice_bloc.dart';
import 'bloc/notice_state.dart';

class NoticesScreen extends StatefulWidget {
  static const String ROUTE = "/notices";
  @override
  _NoticesScreenState createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {
  final NoticeBloc _bloc = NoticeBloc();
  Auth _auth;

  @override
  void initState() {
    super.initState();
    _auth = Provider.of<Auth>(context, listen: false);
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Session>(
        builder: (context, session, child) {
          return BaseBlocListener(
            bloc: _bloc,
            listener: (BuildContext context, BaseState state) {
              print("$runtimeType BlocListener - ${state.toString()}");
            },
            child: BaseBlocBuilder(
              bloc: _bloc,
              condition: (BaseState previous, BaseState current) {
                return true;
              },
              builder: (BuildContext context, BaseState state) {
                print("$runtimeType BlocBuilder - ${state.toString()}");
                if (state is NoticeInitial)
                  _bloc.add(NoticeLoadEvent(session, _auth));
                return SafeArea(
                  child: Column(
                    children: [
                      SimpleAppBar(
                        onBack: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        title: "Notices",
                      ),
                      Expanded(
                        child: _getBody(session, context, state),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _getBody(Session session, BuildContext context, BaseState state) {
    print(state.toString() + "asdsadsadsa");
    if (state is NoticeLoadingState)
      return Center(
          child: CircularProgressIndicator(
        strokeWidth: 2,
        backgroundColor: Colors.black,
      ));
    else if (state is NoticeLoadedState)
      return _noticesListView(state.notices);
    else if (state is NoticeErrorState)
      return Center(child: Text(state.msg));
    else if (state is NoticeInitial)
      return Center(child: Text("Intializing"));
    else
      return Center(child: Text("Something Went Wrong! Try Again"));
  }

  Widget _noticesListView(List<Notice> notices) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: notices?.length ?? 0,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: _noticeItem(notices, index),
        );
      },
    );
  }

  Widget _noticeItem(List<Notice> notices, int index) {
    return NeumorphicButton(
      onPressed: () => _launchURL(notices[index].link),
      padding: const EdgeInsets.all(20),
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
          depth: 8,
          lightSource: LightSource.top,
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notices[index].title,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          kLowPadding,
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date",
                      style: TextStyle(color: Colors.black26),
                    ),
                    Text(
                      notices[index].date,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Contributed by",
                      style: TextStyle(color: Colors.black26),
                    ),
                    Text(
                      notices[index].credit.toLowerCase().capitalize(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
