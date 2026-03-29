import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/domain/entities/fund_entity.dart';
import 'package:btg_funds_app/core/utils/currency_formatter.dart';
import 'package:btg_funds_app/presentation/providers/funds_view_model.dart';
import 'package:btg_funds_app/presentation/providers/wallet_provider.dart';

/// Widget modal para la suscripción a fondos de inversión.
/// Proporciona validación de formulario en tiempo real y feedback de errores.
class SubscribeModal extends ConsumerStatefulWidget {
  final FundEntity fund;

  const SubscribeModal({super.key, required this.fund});

  @override
  ConsumerState<SubscribeModal> createState() => _SubscribeModalState();
}

class _SubscribeModalState extends ConsumerState<SubscribeModal> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  late FocusNode _amountFocusNode;

  String notificationMethod = "email";
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _amountFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.fund.name,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildAmountField(),
              const SizedBox(height: 16),
              _buildNotificationSelector(),
              const SizedBox(height: 24),
              _buildConfirmButton(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Campo de entrada para el monto con validación en tiempo real.
  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      focusNode: _amountFocusNode,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      enabled: !isSubmitting,
      decoration: InputDecoration(
        labelText: 'Monto a invertir',
        hintText: 'Mínimo: ${CurrencyFormatter.format(widget.fund.minAmount)}',
        prefixIcon: const Icon(Icons.attach_money),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        errorMaxLines: 3,
      ),
      validator: _validateAmount,
      onChanged: (_) {
        _formKey.currentState?.validate();
      },
    );
  }

  /// Valida el monto ingresado según reglas de negocio.
  String? _validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'El monto es requerido';
    }

    final amount = double.tryParse(value);
    if (amount == null) {
      return 'Ingresa un monto válido (números y punto decimal)';
    }

    if (amount < widget.fund.minAmount) {
      return 'El monto debe ser mínimo ${CurrencyFormatter.format(widget.fund.minAmount)}';
    }

    // Validar balance del wallet
    final wallet = ref.read(walletProvider);
    if (amount > wallet) {
      return 'Saldo insuficiente. Disponible: ${CurrencyFormatter.format(wallet)}';
    }

    return null;
  }

  /// Selector de método de notificación con layout responsivo.
  Widget _buildNotificationSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Método de notificación',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: notificationMethod,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          items: const [
            DropdownMenuItem(value: "email", child: Text("Email")),
            DropdownMenuItem(value: "sms", child: Text("SMS")),
          ],
          onChanged: isSubmitting
              ? null
              : (value) {
                  setState(() {
                    notificationMethod = value ?? "email";
                  });
                },
        ),
      ],
    );
  }

  /// Botón de confirmación con estado de carga.
  Widget _buildConfirmButton(BuildContext context) {
    return ElevatedButton(
      onPressed: isSubmitting ? null : _handleSubmit,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: isSubmitting
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Text('Confirmar suscripción'),
    );
  }

  /// Maneja el envío del formulario con validación completa.
  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => isSubmitting = true);

    try {
      final amount = double.parse(_amountController.text);

      final failure = ref
          .read(fundsViewModelProvider.notifier)
          .subscribe(widget.fund, amount);

      if (mounted) {
        if (failure != null) {
          _showErrorSnackBar(failure.message);
        } else {
          _showSuccessSnackBar(
            'Suscripción exitosa a ${widget.fund.name} por ${CurrencyFormatter.format(amount)}',
          );
          // Espera breve para que el usuario vea el snackbar y evita timers pendentes en tests
          await Future.delayed(const Duration(milliseconds: 300));
          if (mounted) {
            Navigator.pop(context);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Error inesperado: $e');
      }
    } finally {
      if (mounted) {
        setState(() => isSubmitting = false);
      }
    }
  }

  /// Muestra snackbar de error.
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  /// Muestra snackbar de éxito.
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
