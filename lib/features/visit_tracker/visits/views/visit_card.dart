import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rtm/features/visit_tracker/visits/data/models/edit_visit_dto.dart';
import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';
import 'package:rtm/utils/_index.dart' show OpacityParsing, RtmRouter;
import 'package:rtm/utils/color_palette.dart';
import 'package:rtm/utils/misc.dart';

class VisitCard extends StatefulWidget {
  const VisitCard({
    required this.visit,
    super.key,
  });

  final CustomerVisit visit;

  @override
  State<VisitCard> createState() => _VisitCardState();
}

class _VisitCardState extends State<VisitCard> {
  @override
  Widget build(BuildContext context) {
    final barColor = Misc.getStatusColor(widget.visit.status);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [
          Text(
            Misc.formatDate(widget.visit.createdAt),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          InkWell(
            onTap: () {
              final editVisitDTO = EditVisitDTO(
                visit: widget.visit,
                isEdit: true,
              );
              GoRouter.of(context).push(
                RtmRouter.addOrUpdateVisit,
                extra: editVisitDTO,
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.kPrimaryColor.addOpacity(.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.kSecondaryGreyColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Column(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Customer Name',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                          PopupMenuButton<int>(
                            iconSize: 12,
                            child: const Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                onTap: () {
                                  final editVisitDTO = EditVisitDTO(
                                    visit: widget.visit,
                                    isEdit: true,
                                  );
                                  GoRouter.of(context).push(
                                    RtmRouter.addOrUpdateVisit,
                                    extra: editVisitDTO,
                                  );
                                },
                                child: const Text('Edit'),
                              ),
                              PopupMenuItem(
                                value: 2,
                                onTap: () {},
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        widget.visit.customerName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Graphik',
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      const Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        widget.visit.location,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Graphik',
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 2,
                    children: [
                      const Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        widget.visit.notes,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Graphik',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Visited : ',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text: Misc.formatDate(widget.visit.visitDate),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Graphik',
                                color: AppTheme.kBlackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: barColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Text(
                            widget.visit.status,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.kBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
