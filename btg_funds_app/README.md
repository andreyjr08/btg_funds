# BTG Funds App

Aplicación Flutter para la gestión de fondos de inversión, desarrollada como prueba técnica, enfocada en buenas prácticas de arquitectura, manejo de estado y experiencia de usuario.

---

## Características

* Visualización de fondos disponibles
* Suscripción a fondos validando saldo y monto mínimo
* Cancelación de suscripciones activas
* Historial de transacciones
* Gestión de saldo (wallet)
* Manejo de errores tipado

---

### Arquitectura

Se implementó **Clean Architecture** con separación clara de responsabilidades:

* **Presentation**

  * UI + estado con Riverpod
  * ViewModels desacoplados de la UI
* **Domain**

  * Entidades puras
  * Casos de uso con lógica de negocio
* **Data**

  * Repositorios
  * DataSources (mock)

---

### Manejo de Estado

Se utilizó **Riverpod**

### Navegación

Se utilizó **GoRouter**, basado en Navigator 2.0:

* Navegación declarativa
* Manejo de rutas centralizado
* Preparado para deep linking

---

### Manejo de Errores

Se implementó un sistema de errores basado en `Failure`:

* Evita uso de strings
* Permite tipado fuerte
* Facilita control desde UI

---

### Casos de Uso

La lógica principal está encapsulada en casos de uso:

* `SubscribeToFund`
* `UnsubscribeFromFund`

---

## Estructura del Proyecto

```
lib/
├── core/          # errores, utils
├── data/          # modelos, repositorios, datasources
├── domain/        # entidades y casos de uso
├── presentation/  # UI, providers, viewmodels
```

---

## Instalación

1. SDK flutter (>= 3.38.6)
2. Clonar el repositorio
3. Ejecutar:

```bash
flutter pub get
flutter run
```

---

## Calidad de Código

```bash
flutter analyze
flutter format .
```

---

## 👨‍💻 Autor

Prueba desarrollada por **Jeiner Andrey Grijalba**
Ingeniería de Sistemas
