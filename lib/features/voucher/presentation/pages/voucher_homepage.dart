import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou_games/core/widgets/display/loading_widget.dart';
import 'package:vou_games/core/widgets/display/snack_bar.dart';
import 'package:vou_games/features/voucher/domain/entities/voucher_entity.dart';
import 'package:vou_games/features/voucher/presentation/bloc/voucher_bloc.dart';
import 'package:vou_games/features/voucher/presentation/bloc/voucher_state.dart';

import '../widgets/voucher_item.dart';

class VoucherHomepage extends StatefulWidget {
  const VoucherHomepage({super.key});

  @override
  State<VoucherHomepage> createState() => _VoucherHomepageState();
}

class _VoucherHomepageState extends State<VoucherHomepage> {
  final TextEditingController _searchController = TextEditingController();
  List<VoucherEntity> _filteredVouchers = [];
  String _selectedStatus = 'active';
  bool _showExpired = false;

  @override
  void initState() {
    super.initState();
    context.read<VoucherBloc>().add(FetchUserVouchersEvent());
    _searchController.addListener(_filterVouchers);
  }

  void _filterVouchers() {
    final query = _searchController.text.toLowerCase();
    final state = context.read<VoucherBloc>().state;
    if (state is UserVouchersLoadedState) {
      setState(() {
        _filteredVouchers = state.vouchers.where((voucher) {
          final matchesDescription = voucher.description.toLowerCase().contains(query);
          final matchesStatus = voucher.status == _selectedStatus;
          final matchesExpiry = _showExpired || DateTime.parse(voucher.expiryDate).isAfter(DateTime.now());
          return matchesDescription && matchesStatus && matchesExpiry;
        }).toList();
      });
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Vouchers'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: _selectedStatus,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedStatus = newValue!;
                  });
                },
                items: <String>['active', 'inactive', 'expired']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              CheckboxListTile(
                title: const Text('Show Expired'),
                value: _showExpired,
                onChanged: (bool? value) {
                  setState(() {
                    _showExpired = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _filterVouchers();
                Navigator.of(context).pop();
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Vouchers'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _showFilterDialog,
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search Vouchers',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            BlocConsumer<VoucherBloc, VoucherState>(
              builder: (context, state) {
                if (state is LoadingUserVouchersState) {
                  return const LoadingWidget();
                } else if (state is UserVouchersLoadedState) {
                  _filteredVouchers = state.vouchers;
                  return Expanded(
                    child: Column(
                      children: [
                        Text('Total Vouchers: ${_filteredVouchers.length}'),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _filteredVouchers.length,
                            itemBuilder: (context, index) {
                              return VoucherItem(voucher: _filteredVouchers[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const Text('There\'s nothing here');
              },
              listener: (context, state) {
                if (state is UserVouchersErrorState) {
                  showSnackBar(context, state.error, type: SnackBarType.error);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}