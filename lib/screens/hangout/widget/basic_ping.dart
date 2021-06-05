import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sweetsheet/sweetsheet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/model/hangout/PollModel.dart';
import '../../../data/model/hangout/post.dart';
import '../../../theme/style.dart';
import 'bottomStrip.dart';
import 'pollsWidget.dart';
import 'userStrip.dart';

class PingBasicWidget extends StatelessWidget {
  final Post item;
  final String userId;
  const PingBasicWidget({
    Key key,
    @required this.userId,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kLowPadding,
        UserStripWidget(
            name: item.author.name,
            section: item.author.section,
            yr: item.author.yr,
            id: item.author.id),
        kLowPadding,
        buildMainBody(context),
        BottomStrip(
          postId: item.id,
          currentUserId: userId,
          authorId: item.author.id,
        ),
        Divider()
      ],
    );
  }

  Column buildMainBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.text,
          textAlign: TextAlign.start,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.normal),
        ),
        if (item.isPoll && item.pollData != null)
          PollView(
            poll: PollModel(
                creator: item.author.id,
                numberOfVotes: item.pollData.numberOfVotes,
                optionLabel: item.pollData.optionLabel,
                userWhoVoted: item.pollData.userWhoVoted),
            user: item.author.id,
            postId: item.id,
          ),
        if (item.isLinkAttached && item.link != null) LinkWidget(item.link),
        if (item.isImage && item.imageUrl != null)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kLowCircleRadius),
              child: Image.network(
                item.imageUrl,
                height: 180,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
        if (item.isGif && item.gifUrl != null)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kLowCircleRadius),
              child: Image.network(
                item.gifUrl,
                height: 180,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
      ],
    );
  }
}

class LinkWidget extends StatelessWidget {
  final String url;

  LinkWidget(
    this.url, {
    Key key,
  }) : super(key: key);

  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final SweetSheet _sweetSheet = SweetSheet();

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          _sweetSheet.show(
            context: context,
            title: Text("Warning!"),
            description: Text('Do you really want open link ? '),
            color: SweetSheetColor.NICE,
            icon: Icons.link,
            positive: SweetSheetAction(
              onPressed: () {
                _launchURL(url);
                Navigator.of(context).pop();
              },
              title: 'OPEN IN BROWSER',
              icon: Icons.open_in_browser,
            ),
            negative: SweetSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              title: 'CANCEL',
            ),
          );
        },
        child: Ink(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: isDark ? Colors.black45 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Icon(Icons.link),
              kMedWidthPadding,
              Expanded(
                  child: Text(
                url,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
