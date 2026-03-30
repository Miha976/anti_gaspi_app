# 🥦 FridgeFlow (AntiGaspiApp)

> Réduire le gaspillage alimentaire en rendant les pertes visibles, mesurables et comprises par tout le foyer.

![Status](https://img.shields.io/badge/statut-en%20développement-orange)
![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS-lightgrey)

---

## 🧩 Contexte

Dans un foyer partagé, le gaspillage alimentaire reste invisible. On ne sait pas précisément ce qui est dans le frigo, ce qui va périmer, ni combien on jette réellement chaque semaine.

**On ne change pas ce qu'on ne mesure pas.**

FridgeFlow part d'un principe simple : rendre le jet d'un aliment visible et traçable. À partir de cette donnée brute, l'application calcule automatiquement le taux de gaspillage, les catégories les plus concernées, et l'estimation financière des pertes — pour sensibiliser tous les membres du foyer.

---

## ✨ Fonctionnalités

- **Inventaire partagé** — suivi des produits du foyer triés par date de péremption, avec indicateur visuel de criticité
- **Saisie hybride** — scan de code-barre (Open Food Facts) ou saisie manuelle
- **Déclaration de jet** — enregistrer ce qui est jeté et pourquoi (Périmé / Pas aimé / Trop cuisiné / Oublié)
- **Rappel quotidien** — notification chaque soir pour déclarer les pertes de la journée
- **Statistiques** — taux de gaspillage, montant estimé, catégories et raisons les plus fréquentes sur 7, 14 ou 30 jours

---

## 🛠️ Stack technique

| Brique | Solution |
|---|---|
| UI multiplateforme | Flutter |
| Navigation | go_router |
| Base de données locale | Drift (SQLite) |
| Scan de code-barre | mobile_scanner |
| Données produit | Open Food Facts API |
| Notifications locales | flutter_local_notifications |

Aucun backend. Aucun compte utilisateur. Aucun coût d'infrastructure.

---

## 🗂️ Architecture

```
lib/
├── main.dart
├── app.dart
├── database/
│   └── database.dart
├── services/
│   └── notification_service.dart
├── router/
│   └── app_router.dart
└── screens/
    ├── inventory/
    ├── add_product/
    ├── declare_waste/
    └── statistics/
```

---

## 🗺️ Roadmap

### Phase 1 — MVP *(Terminée)*
- Inventaire avec tri par péremption
- Saisie produit (scan + manuel)
- Déclaration de jet avec raison
- Statistiques sur 7 / 14 / 30 jours

### Phase 2 — Enrichissement *(en cours)*
- Quantité jetée (tout / moitié / un peu)
- Amélioration des statistiques et export

### Phase 3 — Multi-utilisateurs
- Comptes individuels liés à un foyer
- Synchronisation cloud via Supabase

### Phase 4 — Anticipation
- Suggestions de recettes à partir de l'inventaire
- Alertes avant péremption personnalisées

---

## 🚀 Lancer le projet

### Prérequis
- Flutter 3.x installé — [flutter.dev](https://flutter.dev/docs/get-started/install)
- Un émulateur Android/iOS ou un appareil physique

### Installation

```bash
git clone https://github.com/Miha976/anti_gaspi_app.git
cd anti_gaspi_app
flutter pub get
flutter run
```

---

## 👤 Auteur

Développé par **Chanlang** dans le cadre d'un projet personnel multiplateforme avec Flutter.
