import 'package:flutter/material.dart';
import 'package:ipecstudentsapp/data/repo/auth.dart';
import 'package:ipecstudentsapp/data/repo/pings.dart';
import 'package:provider/provider.dart';

import '../../../theme/colors.dart';
import '../../../theme/style.dart';

class BottomStrip extends StatefulWidget {
  final String currentUserId;
  final String postId;
  final String authorId;

  const BottomStrip({
    Key key,
    @required this.currentUserId,
    @required this.authorId,
    @required this.postId,
  }) : super(key: key);

  @override
  _BottomStripState createState() => _BottomStripState();
}

class _BottomStripState extends State<BottomStrip> {
  bool isSamosa = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authProvider, child) {
        isSamosa = authProvider.hUser.likes.contains(widget.postId);
        print(isSamosa);
        return Consumer<Pings>(
          builder: (context, pingProvider, child) {
            final item = pingProvider.postItemsList
                .firstWhere((element) => element.id == widget.postId);

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (isSamosa) {
                        pingProvider.removeLike(widget.postId);
                        authProvider.removeLikeID(widget.postId);
                      } else {
                        pingProvider.addLike(widget.postId);
                        authProvider.addLikeID(widget.postId);
                      }
                    });
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Ink(
                    padding: const EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        isSamosa
                            ? Image.asset(
                                'assets/icons/sam2.png',
                                width: 22,
                              )
                            : ImageIcon(
                                AssetImage('assets/icons/sam1.png'),
                                color: kLightGrey,
                              ),
                        kLowWidthPadding,
                        Text(
                          item.likes == 0 ? 'Samosa' : item.likes.toString(),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: kLightGrey,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Ink(
                    padding: const EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.comment_outlined,
                          color: kLightGrey,
                        ),
                        kLowWidthPadding,
                        Text(
                          item.comments == 0
                              ? 'Chatter'
                              : item.comments.toString(),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: kLightGrey,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    if (widget.authorId == widget.currentUserId) {
                      pingProvider.removeItem('${widget.postId}');
                    }
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Ink(
                    padding: const EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        Icon(
                          widget.authorId == widget.currentUserId
                              ? Icons.delete_forever
                              : Icons.report,
                          color: kLightGrey,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
