import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtm/features/visit_tracker/visits/cubit/get_visits_cubit.dart';

class VisitsPage extends StatefulWidget {
  const VisitsPage({super.key});

  @override
  State<VisitsPage> createState() => _VisitsPageState();
}

class _VisitsPageState extends State<VisitsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetVisitsCubit>().getVisits();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visits'),
      ),
      body: BlocBuilder<GetVisitsCubit, GetVisitsState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const Center(child: CircularProgressIndicator()),
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (visits) => ListView.builder(
              itemCount: visits.length,
              itemBuilder: (context, index) => Text(visits[index].notes ?? ''),
            ),
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
