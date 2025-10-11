import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/data/models/event.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/dashboard/states/event/event_bloc.dart';
import 'package:raho_member_apps/presentation/dashboard/states/notification/notification_bloc.dart';
import 'package:raho_member_apps/presentation/template/backdrop_apps.dart';

class EventDetailWrapper extends StatelessWidget {
  final String eventId;

  const EventDetailWrapper({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<EventBloc>()..add(LoadEventDetail(int.parse(eventId))),
      child: EventDetailPage(eventId: eventId),
    );
  }
}

class EventDetailPage extends StatelessWidget {
  final String eventId;

  const EventDetailPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BackdropApps(
      child: BlocListener<EventBloc, EventState>(
        listener: (context, state) {
          if (state is EventRegistrationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColor.green,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(AppSizes.marginLarge),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                ),
              ),
            );
            // Subscribe to event notifications
            context.read<NotificationBloc>().subscribeToEvent(eventId);
          }
          if (state is EventRegistrationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(AppSizes.marginLarge),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                ),
              ),
            );
          }
        },
        child: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is EventDetailLoading) {
              return _buildLoadingState(context);
            }

            if (state is EventDetailSuccess) {
              return _buildSuccessState(context, state.event, l10n);
            }

            if (state is EventDetailError) {
              return _buildErrorState(context, state, l10n);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () => context.pop(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.1),
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(AppSizes.paddingLarge),
          sliver: SliverList(
            delegate: SliverChildListDelegate([_buildSkeletonContent(context)]),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessState(
    BuildContext context,
    EventDetail event,
    AppLocalizations l10n,
  ) {
    return CustomScrollView(
      slivers: [
        // App Bar with Banner
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
          leading: Container(
            margin: EdgeInsets.all(AppSizes.marginSmall),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.9),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () => context.pop(),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              event.name,
              style: AppTextStyle.subtitle
                  .withColor(Theme.of(context).colorScheme.onSurface)
                  .withWeight(AppFontWeight.bold),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                if (event.banner != null)
                  Image.memory(
                    base64Decode(utf8.decode(base64Decode(event.banner!))),
                    fit: BoxFit.cover,
                    errorBuilder: (context, url, error) => Container(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.event,
                        size: 48,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  )
                else
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                    ),
                  ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                      stops: const [0.6, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Content
        SliverPadding(
          padding: EdgeInsets.all(AppSizes.paddingLarge),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Status Badges
              _buildStatusBadges(context, event, l10n),
              SizedBox(height: AppSizes.spacingLarge),

              // Description
              _buildSectionTitle(context, l10n.description),
              SizedBox(height: AppSizes.spacingSmall),
              Text(
                event.description,
                style: AppTextStyle.body.withColor(
                  Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: AppSizes.spacingXl),

              // Event Details
              _buildSectionTitle(context, l10n.eventDetails),
              SizedBox(height: AppSizes.spacingMedium),
              _buildDetailCards(context, event, l10n),
              SizedBox(height: AppSizes.spacingXl),

              // Participants
              _buildSectionTitle(context, l10n.participants),
              SizedBox(height: AppSizes.spacingMedium),
              _buildParticipantCard(context, event, l10n),
              SizedBox(height: AppSizes.spacingXl),

              // Registration Button
              if (event.canRegister)
                _buildRegistrationButton(context, event, l10n),

              if (!event.registrationAvailable && !event.isFull)
                _buildClosedRegistration(context, l10n),

              if (event.isFull) _buildFullEvent(context, l10n),

              SizedBox(height: AppSizes.spacingXl),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    EventDetailError state,
    AppLocalizations l10n,
  ) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: AppSizes.spacingLarge),
            Text(
              l10n.eventLoadingError,
              style: AppTextStyle.subtitle.withColor(
                Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.spacingSmall),
            Text(
              state.message,
              style: AppTextStyle.body.withColor(
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.spacingXl),
            ElevatedButton.icon(
              onPressed: () {
                context.read<EventBloc>().add(
                  LoadEventDetail(int.parse(eventId)),
                );
              },
              icon: const Icon(Icons.refresh),
              label: Text(l10n.tryAgain),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingXl,
                  vertical: AppSizes.paddingMedium,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                ),
              ),
            ),
            SizedBox(height: AppSizes.spacingMedium),
            TextButton(onPressed: () => context.pop(), child: Text(l10n.back)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadges(
    BuildContext context,
    EventDetail event,
    AppLocalizations l10n,
  ) {
    return Wrap(
      spacing: AppSizes.spacingSmall,
      children: [
        if (event.isActive)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMedium,
              vertical: AppSizes.paddingSmall,
            ),
            decoration: BoxDecoration(
              color: AppColor.green.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              border: Border.all(color: AppColor.green),
            ),
            child: Text(
              l10n.activeEvent,
              style: AppTextStyle.caption
                  .withColor(AppColor.green)
                  .withWeight(AppFontWeight.semiBold),
            ),
          ),
        if (event.isUpcoming)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMedium,
              vertical: AppSizes.paddingSmall,
            ),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              border: Border.all(color: Theme.of(context).colorScheme.primary),
            ),
            child: Text(
              l10n.upcomingEvent,
              style: AppTextStyle.caption
                  .withColor(Theme.of(context).colorScheme.primary)
                  .withWeight(AppFontWeight.semiBold),
            ),
          ),
        if (event.isOngoing)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMedium,
              vertical: AppSizes.paddingSmall,
            ),
            decoration: BoxDecoration(
              color: AppColor.orange.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              border: Border.all(color: AppColor.orange),
            ),
            child: Text(
              l10n.ongoingEvent,
              style: AppTextStyle.caption
                  .withColor(AppColor.orange)
                  .withWeight(AppFontWeight.semiBold),
            ),
          ),
        if (event.isFull)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMedium,
              vertical: AppSizes.paddingSmall,
            ),
            decoration: BoxDecoration(
              color: AppColor.primaryDark.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              border: Border.all(color: AppColor.primaryDark),
            ),
            child: Text(
              l10n.fullEvent,
              style: AppTextStyle.caption
                  .withColor(AppColor.primaryDark)
                  .withWeight(AppFontWeight.semiBold),
            ),
          ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: AppTextStyle.subtitle
          .withColor(Theme.of(context).colorScheme.onSurface)
          .withWeight(AppFontWeight.semiBold),
    );
  }

  Widget _buildDetailCards(
    BuildContext context,
    EventDetail event,
    AppLocalizations l10n,
  ) {
    return Column(
      children: [
        // Date Card
        if (event.startDateTime != null || event.endDateTime != null)
          _buildInfoCard(
            context,
            icon: Icons.calendar_today,
            title: l10n.eventDate,
            content: _buildDateRange(event, l10n),
          ),

        // Location Card
        if (event.location != null) ...[
          SizedBox(height: AppSizes.spacingSmall),
          _buildInfoCard(
            context,
            icon: Icons.location_on,
            title: l10n.location,
            content: event.location!,
          ),
        ],

        // Registration Period Card
        if (event.registrationStartDateTime != null ||
            event.registrationEndDateTime != null) ...[
          SizedBox(height: AppSizes.spacingSmall),
          _buildInfoCard(
            context,
            icon: Icons.how_to_reg,
            title: l10n.registrationPeriod,
            content: _buildRegistrationPeriod(event, l10n),
            isHighlighted: event.isRegistrationOpen,
          ),
        ],
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
    bool isHighlighted = false,
  }) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: isHighlighted
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(
          color: isHighlighted
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
          width: isHighlighted ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isHighlighted
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
            ),
            child: Icon(
              icon,
              size: 20,
              color: isHighlighted
                  ? Colors.white
                  : Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(width: AppSizes.spacingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.caption.withColor(
                    Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                SizedBox(height: AppSizes.spacingTiny),
                Text(
                  content,
                  style: AppTextStyle.body
                      .withColor(Theme.of(context).colorScheme.onSurface)
                      .withWeight(AppFontWeight.medium),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantCard(
    BuildContext context,
    EventDetail event,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.totalParticipants,
                style: AppTextStyle.body.withColor(
                  Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              Text(
                event.participantDisplay,
                style: AppTextStyle.subtitle
                    .withColor(Theme.of(context).colorScheme.primary)
                    .withWeight(AppFontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: AppSizes.spacingMedium),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
            child: LinearProgressIndicator(
              value: event.participantPercentage,
              minHeight: 8,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(
                event.isFull
                    ? AppColor.orange
                    : event.participantPercentage > 0.8
                    ? AppColor.gold
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          SizedBox(height: AppSizes.spacingSmall),
          Text(
            event.isFull
                ? l10n.eventFullMessage
                : l10n.availableSlots(event.availableSlots),
            style: AppTextStyle.caption.withColor(
              event.isFull
                  ? AppColor.orange
                  : Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationButton(
    BuildContext context,
    EventDetail event,
    AppLocalizations l10n,
  ) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        final isRegistering = state is EventRegistering;

        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: isRegistering
                ? null
                : () {
                    context.read<EventBloc>().add(RegisterForEvent(event.id));
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
              elevation: 2,
            ),
            child: isRegistering
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                : Text(
                    l10n.registerNow,
                    style: AppTextStyle.subtitle
                        .withColor(Theme.of(context).colorScheme.onPrimary)
                        .withWeight(AppFontWeight.semiBold),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildClosedRegistration(BuildContext context, AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: AppColor.greyLight.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(color: AppColor.grey, width: 1),
      ),
      child: Column(
        children: [
          Icon(Icons.lock_clock, size: 48, color: AppColor.greyMedium),
          SizedBox(height: AppSizes.spacingSmall),
          Text(
            l10n.registrationClosed,
            style: AppTextStyle.subtitle
                .withColor(AppColor.greyDark)
                .withWeight(AppFontWeight.semiBold),
          ),
        ],
      ),
    );
  }

  Widget _buildFullEvent(BuildContext context, AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      decoration: BoxDecoration(
        color: AppColor.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
        border: Border.all(color: AppColor.orange, width: 1),
      ),
      child: Column(
        children: [
          Icon(Icons.people_alt, size: 48, color: AppColor.orange),
          SizedBox(height: AppSizes.spacingSmall),
          Text(
            l10n.eventFullMessage,
            style: AppTextStyle.subtitle
                .withColor(AppColor.orange)
                .withWeight(AppFontWeight.semiBold),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        5,
        (index) => Container(
          height: 20,
          width: index.isEven
              ? double.infinity
              : MediaQuery.of(context).size.width * 0.7,
          margin: EdgeInsets.only(bottom: AppSizes.marginMedium),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  String _buildDateRange(EventDetail event, AppLocalizations l10n) {
    if (event.startDateTime == null && event.endDateTime == null) {
      return l10n.toBeAnnounced;
    }

    final start = event.startDateTime != null
        ? _formatDateTime(event.startDateTime!)
        : l10n.toBeAnnounced;
    final end = event.endDateTime != null
        ? _formatDateTime(event.endDateTime!)
        : l10n.toBeAnnounced;

    return '$start - $end';
  }

  String _buildRegistrationPeriod(EventDetail event, AppLocalizations l10n) {
    if (event.registrationStartDateTime == null &&
        event.registrationEndDateTime == null) {
      return l10n.toBeAnnounced;
    }

    final start = event.registrationStartDateTime != null
        ? _formatDateTime(event.registrationStartDateTime!)
        : l10n.toBeAnnounced;
    final end = event.registrationEndDateTime != null
        ? _formatDateTime(event.registrationEndDateTime!)
        : l10n.toBeAnnounced;

    return '$start - $end';
  }

  String _formatDateTime(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '${date.day} ${months[date.month - 1]} ${date.year}, $hour:$minute';
  }
}
