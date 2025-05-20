import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtm/features/visit_tracker/cubit/_index.dart';
import 'package:rtm/features/visit_tracker/visits/cubit/get_visits_cubit.dart';
import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';
import 'package:rtm/features/visit_tracker/visits/views/_index.dart';
import 'package:rtm/shared/views/_index.dart';
import 'package:rtm/utils/color_palette.dart';
import 'package:rtm/utils/misc.dart';
import 'package:rtm/utils/rtm_router.dart';

class VisitsPage extends StatefulWidget {
  const VisitsPage({super.key});

  @override
  State<VisitsPage> createState() => _VisitsPageState();
}

class _VisitsPageState extends State<VisitsPage> {
  final _searchController = TextEditingController();
  final visitsNotifier = ValueNotifier<List<CustomerVisit>>([]);
  final searchNotifier = ValueNotifier<List<CustomerVisit>>([]);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();

      _searchController.addListener(searchForm);
    });
  }

  void fetchData() {
    context.read<GetActivitiesCubit>().getActivities();
    context.read<GetCustomersCubit>().getCustomers();
    context.read<GetVisitsCubit>().getVisits();
  }

  void searchForm() {
    searchNotifier.value = List.of(
      visitsNotifier.value.where(
        (element) => element.customerName
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackgroundColor,
      appBar: SingleTitleAppBar(
        title: 'Visits',
        isHome: true,
        actions: [
          TextButton(
            onPressed: () =>
                GoRouter.of(context).push(RtmRouter.addOrUpdateVisit),
            child: const Row(
              children: [
                Icon(
                  CupertinoIcons.add,
                  color: AppTheme.kPrimaryColor,
                ),
                Text(
                  'Add',
                  style: TextStyle(
                    fontFamily: 'Graphik',
                    color: AppTheme.kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
      body: BlocBuilder<GetCustomersCubit, GetCustomersState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const LoadingWidget(message: 'Loading...'),
            error: (error) => FetchErrorWidget(
              error: error,
              onRetry: fetchData,
            ),
            initial: () => const SizedBox.shrink(),
            loading: () => const LoadingWidget(message: 'Loading...'),
            loaded: (customers) {
              return BlocBuilder<GetActivitiesCubit, GetActivitiesState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    error: (error) => FetchErrorWidget(
                      error: error,
                      onRetry: fetchData,
                    ),
                    orElse: () =>
                        const LoadingWidget(message: 'Halfway through...'),
                    initial: () => const SizedBox.shrink(),
                    loading: () =>
                        const LoadingWidget(message: 'Halfway through...'),
                    loaded: (activities) {
                      return BlocBuilder<GetVisitsCubit, GetVisitsState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            error: (error) => FetchErrorWidget(
                              error: error,
                              onRetry: fetchData,
                            ),
                            orElse: () => const LoadingWidget(
                              message: 'Almost done...',
                            ),
                            initial: () => const SizedBox.shrink(),
                            loading: () => const LoadingWidget(
                              message: 'Almost done...',
                            ),
                            loaded: (visits) {
                              final mappedVisits = Misc.mapVisists(
                                visits: visits,
                                customers: customers,
                                activities: activities,
                              );
                              final completedPercent = Misc.getStatusPercent(
                                mappedVisits,
                                'completed',
                              );

                              final pendingPercent = Misc.getStatusPercent(
                                mappedVisits,
                                'pending',
                              );

                              final cancelledPercent = Misc.getStatusPercent(
                                mappedVisits,
                                'cancelled',
                              );
                              visitsNotifier.value =
                                  mappedVisits.reversed.toList();

                              searchForm();

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    child: VisitStatWidget(
                                      completedPercent: completedPercent,
                                      pendingPercent: pendingPercent,
                                      cancelledPercent: cancelledPercent,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 12),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: SizedBox(
                                            height: 40,
                                            child: SearchFormField(
                                              hintText: 'Search by name',
                                              controller: _searchController,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        Expanded(
                                          child: ValueListenableBuilder<
                                              List<CustomerVisit>>(
                                            valueListenable: searchNotifier,
                                            builder: (context, displayList, _) {
                                              return ListView.builder(
                                                itemCount: displayList.length,
                                                itemBuilder: (context, index) {
                                                  final visit =
                                                      displayList[index];
                                                  return VisitCard(
                                                    visit: visit,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
