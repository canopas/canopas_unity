import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectunity/data/configs/theme.dart';
import 'package:projectunity/data/core/extensions/context_extension.dart';
import 'package:projectunity/data/core/extensions/date_formatter.dart';
import 'package:projectunity/data/core/extensions/widget_extension.dart';
import 'package:projectunity/data/core/utils/date_formatter.dart';
import 'package:projectunity/ui/shared/events/bloc/celebrations_bloc.dart';
import 'package:projectunity/ui/shared/events/bloc/celebrations_event.dart';
import 'package:projectunity/ui/shared/events/bloc/celebrations_state.dart';
import 'package:projectunity/ui/widget/circular_progress_indicator.dart';
import 'package:projectunity/ui/widget/error_snack_bar.dart';
import 'package:projectunity/ui/widget/user_profile_image.dart';

import '../../../data/core/utils/bloc_status.dart';
import '../../../style/app_text_style.dart';
import 'model/event.dart';

class EventCard extends StatefulWidget {
  const EventCard({super.key});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: context.colorScheme.outlineColor),
        BlocConsumer<CelebrationsBloc, CelebrationsState>(
            builder: (context, state) {
              return Column(
                children: [
                  EventsList(
                    header: "🎂 ${context.l10n.birthdays_tag} 🎂 ",
                    events: state.birthdays,
                    expanded: state.showAllBdays,
                    status: state.status,
                    isAnniversary: false,
                  ),
                  EventsList(
                    header: "🎊 ${context.l10n.work_anniversaries_tag} 🎊 ",
                    events: state.anniversaries,
                    expanded: state.showAllAnniversaries,
                    status: state.status,
                    isAnniversary: true,
                  )
                ],
              );
            },
            listenWhen: (previous, current) => current.error != null,
            listener: (context, state) {
              if (state.error != null) {
                showSnackBar(context: context, error: state.error);
              }
            }),
        Divider(color: context.colorScheme.outlineColor),
      ],
    );
  }
}

class EventsList extends StatelessWidget {
  final List<Event> events;
  final String header;
  final bool isAnniversary;
  final bool expanded;
  final Status status;

  const EventsList(
      {super.key,
      required this.events,
      required this.header,
      required this.expanded,
      required this.isAnniversary,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  header,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.style20.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: context.colorScheme.outlineColor)),
                child: Row(
                  children: [
                    Text(context.l10n.view_all_tag,
                        style: AppTextStyle.style16.copyWith(
                            color: expanded
                                ? context.colorScheme.textPrimary
                                : context.colorScheme.primary)),
                    Icon(
                      expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: expanded
                          ? context.colorScheme.textPrimary
                          : context.colorScheme.primary,
                    )
                  ],
                ),
              ).onTapGesture(() {
                isAnniversary
                    ? context
                        .read<CelebrationsBloc>()
                        .add(ShowAnniversariesEvent())
                    : context
                        .read<CelebrationsBloc>()
                        .add(ShowBirthdaysEvent());
              })
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          switch (status) {
            Status.initial => const SizedBox(),
            Status.loading => const ThreeBounceLoading(),
            Status.success => events.isEmpty
                ? const EmptyCelebrationCard()
                : Column(
                    children: events.map((event) {
                      return expanded
                          ? AllEventCard(
                              imageUrl: event.imageUrl,
                              name: event.name,
                              date: event.upcomingDate)
                          : CurrentWeekEventCard(
                              event: event, isAnniversary: isAnniversary);
                    }).toList(),
                  ),
            Status.error => const EmptyCelebrationCard()
          },
        ],
      ),
    );
  }
}

class CurrentWeekEventCard extends StatelessWidget {
  final Event event;
  final bool isAnniversary;

  const CurrentWeekEventCard(
      {super.key, required this.event, required this.isAnniversary});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            color: context.colorScheme.containerLow,
            borderRadius: AppTheme.commonBorderRadius),
        child: Row(
          children: [
            ImageProfile(
              radius: 20,
              imageUrl: event.imageUrl,
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Text(isAnniversary
                    ? DateFormatter(context.l10n).showAnniversaries(
                        dateOfJoining: event.dateTime,
                        upcomingDate: event.upcomingDate,
                        name: event.name)
                    : DateFormatter(context.l10n).showBirthdays(
                        dateTime: event.dateTime, name: event.name))),
          ],
        ));
  }
}

class AllEventCard extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final DateTime date;

  const AllEventCard(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: context.colorScheme.containerLow,
            borderRadius: AppTheme.commonBorderRadius),
        child: Row(
          children: [
            ImageProfile(radius: 20, imageUrl: imageUrl),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date.toDateWithoutYear(context),
                  style: AppTextStyle.style16.copyWith(
                      color: context.colorScheme.textPrimary, height: 1.5),
                ),
                Text(
                  name,
                  style: AppTextStyle.style14
                      .copyWith(color: context.colorScheme.textSecondary),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class EmptyCelebrationCard extends StatelessWidget {
  const EmptyCelebrationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.no_event_text,
      style: AppTextStyle.style16
          .copyWith(color: context.colorScheme.textSecondary),
    );
  }
}
