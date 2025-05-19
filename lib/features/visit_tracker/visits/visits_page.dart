import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtm/features/visit_tracker/visits/cubit/get_visits_cubit.dart';
import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';
import 'package:rtm/features/visit_tracker/visits/views/_index.dart';
import 'package:rtm/shared/views/search_form_field.dart';
import 'package:rtm/shared/views/single_title_app_bar.dart';
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

  static final Map<int, bool> _expandedStates = {};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetVisitsCubit>().getVisits();

      _searchController.addListener(searchForm);
    });
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
      body: BlocBuilder<GetVisitsCubit, GetVisitsState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const Center(child: CircularProgressIndicator()),
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(
                color: AppTheme.kPrimaryColor,
              ),
            ),
            loaded: (customerVisits) {
              final completedPercent =
                  Misc.getStatusPercent(customerVisits, 'completed');

              final pendingPercent =
                  Misc.getStatusPercent(customerVisits, 'pending');

              final cancelledPercent =
                  Misc.getStatusPercent(customerVisits, 'cancelled');
              visitsNotifier.value = customerVisits.reversed.toList();

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
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: SizedBox(
                            height: 40,
                            child: SearchFormField(
                              hintText: 'Search by name',
                              controller: _searchController,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ValueListenableBuilder<List<CustomerVisit>>(
                            valueListenable: searchNotifier,
                            builder: (context, displayList, _) {
                              return ListView.builder(
                                itemCount: displayList.length,
                                itemBuilder: (context, index) {
                                  final visit = displayList[index];
                                  return VisitCard(
                                    visit: visit,
                                    isExpanded:
                                        _expandedStates[visit.id] ?? true,
                                    onToggle: (expanded) {
                                      setState(() {
                                        _expandedStates[visit.id] = expanded;
                                      });
                                    },
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
            error: (error) => Text(
              error,
              style: const TextStyle(color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
