import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raho_member_apps/core/constants/app_routes.dart';
import 'package:raho_member_apps/core/constants/app_sizes.dart';
import 'package:raho_member_apps/core/di/service_locator.dart';
import 'package:raho_member_apps/core/styles/app_color.dart';
import 'package:raho_member_apps/core/styles/app_text_style.dart';
import 'package:raho_member_apps/data/models/event.dart';
import 'package:raho_member_apps/l10n/app_localizations.dart';
import 'package:raho_member_apps/presentation/dashboard/states/event/event_bloc.dart';
import 'package:raho_member_apps/presentation/template/backdrop_apps.dart';

class EventListWrapper extends StatelessWidget {
  const EventListWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EventBloc>()..add(const LoadEvents()),
      child: const EventListPage(),
    );
  }
}

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !context.read<EventBloc>().hasReachedMax) {
      context.read<EventBloc>().add(const LoadMoreEvents());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BackdropApps(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () => context.pop(),
          ),
          title: Text(
            l10n.eventsTitle,
            style: AppTextStyle.subtitle
                .withColor(Theme.of(context).colorScheme.onSurface)
                .withWeight(AppFontWeight.semiBold),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<EventBloc, EventState>(
          builder: (context, state) {
            if (state is EventListLoading) {
              return _buildLoadingState(context);
            }

            final events = context.read<EventBloc>().events;

            if (events.isEmpty && state is! EventListLoadingMore) {
              return _buildEmptyState(context, l10n);
            }

            if (state is EventListError && events.isEmpty) {
              return _buildErrorState(context, state, l10n);
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<EventBloc>().add(const RefreshEvents());
              },
              child: ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(AppSizes.paddingLarge),
                itemCount: state is EventListLoadingMore
                    ? events.length + 1
                    : events.length,
                itemBuilder: (context, index) {
                  if (index >= events.length) {
                    return _buildLoadMoreIndicator(context);
                  }

                  final event = events[index];
                  return _buildEventListItem(context, event, l10n);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      itemCount: 5,
      itemBuilder: (context, index) => _buildSkeletonEventItem(context),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy,
              size: 80,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            SizedBox(height: AppSizes.spacingLarge),
            Text(
              l10n.noEventsAvailable,
              style: AppTextStyle.subtitle.withColor(
                Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.spacingSmall),
            Text(
              l10n.noEventsDescription,
              style: AppTextStyle.body.withColor(
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSizes.spacingXl),
            ElevatedButton.icon(
              onPressed: () {
                context.read<EventBloc>().add(const RefreshEvents());
              },
              icon: const Icon(Icons.refresh),
              label: Text(l10n.refresh),
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
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    EventListError state,
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
                context.read<EventBloc>().add(const LoadEvents());
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
          ],
        ),
      ),
    );
  }

  Widget _buildEventListItem(
    BuildContext context,
    Event event,
    AppLocalizations l10n,
  ) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AppRoutes.eventDetail.name,
          pathParameters: {'id': event.id.toString()},
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: AppSizes.marginMedium),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.shadow.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Banner
            if (event.banner != null)
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppSizes.radiusMedium),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.memory(
                    base64Decode(utf8.decode(base64Decode(event.banner!))),
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded || frame != null) {
                            return child;
                          }
                          return Container(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          );
                        },
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
                  ),
                ),
              )
            else
              Container(
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.8),
                      Theme.of(
                        context,
                      ).colorScheme.secondary.withValues(alpha: 0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppSizes.radiusMedium),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.event,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ),

            // Event Content
            Padding(
              padding: EdgeInsets.all(AppSizes.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          event.name,
                          style: AppTextStyle.subtitle
                              .withColor(
                                Theme.of(context).colorScheme.onSurface,
                              )
                              .withWeight(AppFontWeight.semiBold),
                        ),
                      ),
                      if (event.isFull)
                        Container(
                          margin: EdgeInsets.only(left: AppSizes.marginSmall),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingSmall,
                            vertical: AppSizes.paddingTiny,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.orange,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusTiny,
                            ),
                          ),
                          child: Text(
                            'FULL',
                            style: AppTextStyle.supportText
                                .withColor(Colors.white)
                                .withWeight(AppFontWeight.bold),
                          ),
                        )
                      else if (event.isRegistrationOpen)
                        Container(
                          margin: EdgeInsets.only(left: AppSizes.marginSmall),
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.paddingSmall,
                            vertical: AppSizes.paddingTiny,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.green,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusTiny,
                            ),
                          ),
                          child: Text(
                            'OPEN',
                            style: AppTextStyle.supportText
                                .withColor(Colors.white)
                                .withWeight(AppFontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: AppSizes.spacingSmall),
                  Text(
                    event.description,
                    style: AppTextStyle.body.withColor(
                      Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AppSizes.spacingMedium),
                  Row(
                    children: [
                      // Date
                      if (event.startDateTime != null) ...[
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(width: AppSizes.paddingTiny),
                        Text(
                          _formatDate(event.startDateTime!),
                          style: AppTextStyle.caption.withColor(
                            Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(width: AppSizes.spacingMedium),
                      ],
                      if (event.location != null) ...[
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(width: AppSizes.paddingTiny),
                        Expanded(
                          child: Text(
                            event.location!,
                            style: AppTextStyle.caption.withColor(
                              Theme.of(context).colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: AppSizes.spacingSmall),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.participants,
                            style: AppTextStyle.caption.withColor(
                              Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                          Text(
                            event.participantDisplay,
                            style: AppTextStyle.caption
                                .withColor(
                                  Theme.of(context).colorScheme.primary,
                                )
                                .withWeight(AppFontWeight.semiBold),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.spacingTiny),
                      LinearProgressIndicator(
                        value: event.participantPercentage,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          event.isFull
                              ? AppColor.orange
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonEventItem(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.marginMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.1),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppSizes.radiusMedium),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSizes.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: AppSizes.spacingSmall),
                Container(
                  height: 14,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: AppSizes.spacingMedium),
                Row(
                  children: [
                    Container(
                      height: 14,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(width: AppSizes.spacingMedium),
                    Container(
                      height: 14,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadMoreIndicator(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.paddingLarge),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  String _formatDate(DateTime date) {
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
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
