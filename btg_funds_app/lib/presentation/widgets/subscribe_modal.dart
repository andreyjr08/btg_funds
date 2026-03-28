import 'package:btg_funds_app/presentation/providers/funds_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/domain/entities/fund_entity.dart';

class SubscribeModal extends ConsumerStatefulWidget {
  final FundEntity fund;

  const SubscribeModal({super.key, required this.fund});

  @override
  ConsumerState<SubscribeModal> createState() => _SubscribeModalState();
}

class _SubscribeModalState extends ConsumerState<SubscribeModal> {
  final _controller = TextEditingController();

  String notificationMethod = "email";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.fund.name, style: const TextStyle(fontSize: 18)),

          const SizedBox(height: 16),

          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Monto",
              hintText: "Mínimo: ${widget.fund.minAmount}",
            ),
          ),

          const SizedBox(height: 16),

          DropdownButton<String>(
            value: notificationMethod,
            items: const [
              DropdownMenuItem(value: "email", child: Text("Email")),
              DropdownMenuItem(value: "sms", child: Text("SMS")),
            ],
            onChanged: (value) {
              setState(() {
                notificationMethod = value!;
              });
            },
          ),

          const SizedBox(height: 16),

          ElevatedButton(onPressed: _subscribe, child: const Text("Confirmar")),
        ],
      ),
    );
  }

  void _subscribe() {
    final amount = double.tryParse(_controller.text);

    if (amount == null) {
      _showError("Ingresa un monto válido");
      return;
    }

    final error = ref
        .read(fundsViewModelProvider.notifier)
        .subscribe(widget.fund, amount);

    if (error != null) {
      _showError(error);
    } else {
      Navigator.pop(context);
      _showSuccess("Suscripción exitosa ($notificationMethod)");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
