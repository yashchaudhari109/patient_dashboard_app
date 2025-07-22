import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:patient_dashboard/src/features/dashboard/presentation/bloc/patient_bloc.dart';
import 'package:patient_dashboard/src/features/dashboard/presentation/bloc/patient_state.dart';

IconData getShipmentIcon(String status) {
  switch (status.toLowerCase()) {
    case 'delivered':
      return Icons.check_circle;
    case 'in transit':
      return Icons.directions_car;
    case 'pending':
      return Icons.hourglass_top;
    case 'cancelled':
      return Icons.cancel;
    default:
      return Icons.local_shipping;
  }
}

Color getShipmentColor(String status) {
  switch (status.toLowerCase()) {
    case 'delivered':
      return Colors.green;
    case 'in transit':
      return Colors.orange;
    case 'pending':
      return Colors.amber;
    case 'cancelled':
      return Colors.red;
    default:
      return Colors.blueGrey;
  }
}

class ShipmentHistoryScreen extends StatelessWidget {
  const ShipmentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Shipment History')),
      body: BlocBuilder<PatientBloc, PatientState>(
        builder: (context, state) {
          if (state is PatientLoading || state is PatientInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PatientError) {
            return Center(child: Text(state.message));
          }
          if (state is PatientLoaded) {
            final shipments = state.shipments;
            if (shipments.isEmpty) {
              return const Center(child: Text("No shipments found yet."));
            }
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Medication Shipments",
                        style: theme.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "All shipment activity appears below.\nDelivered, in transit, and pending – stay informed!",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer
                              .withOpacity(0.8),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 16, bottom: 18),
                    itemCount: shipments.length,
                    itemBuilder: (context, index) {
                      final shipment = shipments[index];
                      final isLast = index == shipments.length - 1;
                      final statusColor = getShipmentColor(shipment.status);
                      final icon = getShipmentIcon(shipment.status);

                      return _AnimatedListItem(
                        index: index,
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 30, right: 16, bottom: 16),
                              child: Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(24, 16, 24, 16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Status icon
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: statusColor.withOpacity(0.09),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Icon(
                                          icon,
                                          color: statusColor,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(width: 18),
                                      // Shipment info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Shipped on ${DateFormat.yMMMEd().format(shipment.date)}",
                                              style: theme.textTheme.bodyLarge,
                                            ),
                                            const SizedBox(height: 3),
                                            Row(
                                              children: [
                                                Text(
                                                  shipment.status,
                                                  style: TextStyle(
                                                    color: statusColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                if (shipment.status
                                                        .toLowerCase() ==
                                                    'delivered')
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 6),
                                                    child: Icon(Icons.check,
                                                        size: 16,
                                                        color: Colors.green),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              "Quantity: ${shipment.quantity}",
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Timeline indicator
                            Positioned(
                              left: 16,
                              top: 0,
                              bottom: isLast ? 32 : 0,
                              child: Column(
                                children: [
                                  Container(
                                    width: 4,
                                    height: 28,
                                    color: index == 0
                                        ? Colors.transparent
                                        : Colors.deepPurple.shade100,
                                  ),
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: statusColor,
                                      border: Border.all(
                                          color: Colors.white, width: 3),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 4,
                                      color: isLast
                                          ? Colors.transparent
                                          : Colors.deepPurple.shade100,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('No shipments found.'));
        },
      ),
    );
  }
}

// ------ Animation Item Reused ------
class _AnimatedListItem extends StatefulWidget {
  final int index;
  final Widget child;

  const _AnimatedListItem({required this.index, required this.child});

  @override
  State<_AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<_AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    final delay = Duration(milliseconds: widget.index * 100);
    Future.delayed(delay, () {
      if (mounted) {
        _controller.forward();
      }
    });

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
