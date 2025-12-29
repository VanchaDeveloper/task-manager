# frontend

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

The project follows a Feature-First (Feature-Based) Clean Architecture approach, commonly used in Flutter with BLoC/Cubit.

Breakdown of the pattern

1. Feature-First Structure

Code is organized by features (auth, home) instead of by layers globally.

Each feature is self-contained and scalable.

2. Clean Architecture Influence
   Inside each feature:

pages → Presentation layer (UI / Screens)

cubit → State management (BLoC/Cubit = Presentation logic)

repository → Data access abstraction

widgets → Feature-specific reusable UI components

3. Core Layer

core/

Shared utilities, constants, services

Used across all features

4. Repository Pattern

repository separates data sources (API, DB) from business logic.

Makes testing and refactoring easier.

5. State Management

Uses Cubit (from flutter_bloc) for predictable, unidirectional data flow.

In short

This is:

Feature-First Clean Architecture + Repository Pattern + Cubit (BLoC)

This structure is:

✅ Scalable

✅ Testable

✅ Team-friendly

✅ Common in production Flutter apps

Great. Here’s a **clear mapping + suggested improvements** based on your current structure, keeping it **interview-ready and production-grade**.

---

## 1️⃣ Clean Architecture Mapping (Your Project)

### **Presentation Layer**

Handles UI + state

```
features/
 └─ home/
     ├─ pages/        → Screens (Widgets)
     ├─ cubit/        → State management (UI logic)
     ├─ widgets/      → Reusable UI components
```

```
features/
 └─ auth/
     ├─ pages/
     ├─ cubit/
```

**Responsibilities**

- Build UI
- Listen to Cubit states
- Trigger actions (login, load tasks, etc.)
- No business logic here

---

### **Domain Layer**

Business rules & contracts

```
features/
 └─ home/
     ├─ repository/   → Abstract repositories (interfaces)
```

```
models/
 ├─ user_model.dart
 ├─ task_model.dart
```

**Responsibilities**

- Define **what** the app does
- Independent of Flutter, API, DB
- Easy to unit test

💡 _Improvement:_ Move `models` into feature/domain folders (explained below).

---

### **Data Layer**

Implementation details

```
core/
 ├─ services/        → API, DB, Network, Storage
 ├─ constants/
```

```
features/
 └─ home/
     ├─ repository/
         ├─ home_repository_impl.dart
```

**Responsibilities**

- API calls
- Local DB
- JSON parsing
- Caching

---

## 2️⃣ Recommended Enterprise-Level Improvement

### 🔴 Current Issue

- `models/` is global
- Domain & data layers are slightly mixed

### ✅ Ideal Feature Structure

```
features/
 └─ home/
     ├─ data/
     │   ├─ models/
     │   ├─ datasources/
     │   └─ repositories/
     │
     ├─ domain/
     │   ├─ entities/
     │   ├─ repositories/
     │   └─ usecases/
     │
     ├─ presentation/
     │   ├─ cubit/
     │   ├─ pages/
     │   └─ widgets/
```

This gives you:

- Strong separation of concerns
- Easier testing
- Plug-and-play data sources
- Clean dependency flow

---

## 3️⃣ Dependency Flow (Important for Interviews)

```
UI → Cubit → UseCase → Repository (abstract)
                        ↑
                 Repository Impl
                        ↑
                  API / DB
```

Rules:

- Presentation depends on Domain
- Domain depends on nothing
- Data depends on Domain

🚫 UI never talks to API directly

---

## 4️⃣ What You Can Say in Interviews

> “The app follows Feature-First Clean Architecture using Cubit for state management.
> Each feature encapsulates its presentation, domain, and data layers.
> Business logic is isolated via use cases and repositories, making the app scalable and testable.”

---

## 5️⃣ When Your Current Structure Is Enough

Your existing structure is **perfect for**:

- Mid-scale apps
- Startups
- Interview assignments
- 1–3 dev teams

You only need the full clean split when:

- App grows large
- Multiple APIs / data sources
- Large engineering team

Perfect — I’ll cover **ALL** of it in a **clear, practical, interview-ready way**, based on **your current project**, and then show the **ideal refactor**.

---

# 1️⃣ Final Architecture You’ll Have

**Feature-First Clean Architecture + Cubit + Repository + UseCases + DI**

This is **industry-standard for senior Flutter roles**.

---

# 2️⃣ Refactored Folder Structure (Exact & Clean)

```
lib/
 ├─ core/
 │   ├─ constants/
 │   ├─ services/
 │   │   ├─ api_service.dart
 │   │   └─ local_storage_service.dart
 │   └─ di/
 │       └─ injection.dart
 │
 ├─ features/
 │   ├─ auth/
 │   │   ├─ data/
 │   │   │   ├─ models/
 │   │   │   ├─ datasources/
 │   │   │   └─ repositories/
 │   │   │
 │   │   ├─ domain/
 │   │   │   ├─ entities/
 │   │   │   ├─ repositories/
 │   │   │   └─ usecases/
 │   │   │
 │   │   └─ presentation/
 │   │       ├─ cubit/
 │   │       └─ pages/
 │   │
 │   └─ home/
 │       ├─ data/
 │       ├─ domain/
 │       └─ presentation/
 │
 └─ main.dart
```

---

# 3️⃣ Layer Responsibilities (Very Important)

## 🔵 Presentation Layer

**(Flutter + Cubit only)**

```
presentation/
 ├─ pages/     → Screens
 ├─ widgets/   → UI components
 └─ cubit/     → UI state & events
```

✅ What it does:

- Calls **UseCases**
- Emits states
- No API / JSON / DB code

---

## 🟢 Domain Layer (Pure Dart)

**Business rules**

```
domain/
 ├─ entities/
 ├─ repositories/   → abstract classes
 └─ usecases/
```

✅ What it does:

- App logic
- Validation
- Rules
- No Flutter imports

---

## 🟠 Data Layer

**Implementation details**

```
data/
 ├─ models/         → JSON ↔ Dart
 ├─ datasources/    → API / DB
 └─ repositories/  → Implements domain repos
```

✅ What it does:

- REST calls
- Caching
- Mapping data → domain

---

# 4️⃣ Example: Home Feature (REAL CODE FLOW)

---

## 🟢 Domain Entity

```dart
class Task {
  final String id;
  final String title;

  Task({required this.id, required this.title});
}
```

---

## 🟢 Repository Contract

```dart
abstract class HomeRepository {
  Future<List<Task>> getTasks();
}
```

---

## 🟢 Use Case

```dart
class GetTasksUseCase {
  final HomeRepository repository;

  GetTasksUseCase(this.repository);

  Future<List<Task>> call() {
    return repository.getTasks();
  }
}
```

👉 **Cubit ONLY talks to use cases**

---

## 🟠 Repository Implementation

```dart
class HomeRepositoryImpl implements HomeRepository {
  final ApiService api;

  HomeRepositoryImpl(this.api);

  @override
  Future<List<Task>> getTasks() async {
    final response = await api.get('/tasks');
    return response.map<Task>((e) => TaskModel.fromJson(e)).toList();
  }
}
```

---

## 🔵 Cubit

```dart
class HomeCubit extends Cubit<HomeState> {
  final GetTasksUseCase getTasks;

  HomeCubit(this.getTasks) : super(HomeInitial());

  void loadTasks() async {
    emit(HomeLoading());
    try {
      final tasks = await getTasks();
      emit(HomeLoaded(tasks));
    } catch (e) {
      emit(HomeError());
    }
  }
}
```

---

# 5️⃣ Dependency Injection (get_it)

### core/di/injection.dart

```dart
final sl = GetIt.instance;

void setupDI() {
  // Services
  sl.registerLazySingleton(() => ApiService());

  // Repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetTasksUseCase(sl()));

  // Cubits
  sl.registerFactory(() => HomeCubit(sl()));
}
```

### main.dart

```dart
void main() {
  setupDI();
  runApp(MyApp());
}
```

---

# 6️⃣ Dependency Rule (Interview Gold)

```
UI → Cubit → UseCase → Repository (abstract)
                        ↑
                  Repository Impl
                        ↑
                     API / DB
```

🚫 No reverse dependency
🚫 No UI → API calls
🚫 No Cubit → Repository directly (in clean version)

---

# 7️⃣ Why This Architecture Is Used

✅ Scalable
✅ Testable
✅ Team-friendly
✅ Easy refactor
✅ Industry standard

---

# 8️⃣ What to Say in Interviews (Memorize This)

> “I use Feature-First Clean Architecture with Cubit.
> Each feature is isolated into presentation, domain, and data layers.
> Business logic lives in use cases, repositories abstract data sources, and Cubits only manage UI state.
> This keeps the app scalable, testable, and maintainable.”

---

# 9️⃣ When to STOP Adding Complexity

You **don’t need full clean architecture** if:

- Small app
- Single API
- Short-term project

Your **current structure + use cases** is already **strong for interviews**.

---

Got it 👍
I’ll proceed with **refactoring your exact current project** step-by-step into **Clean Architecture**, without over-engineering, and in a way you can **explain confidently in interviews**.

---

# 1️⃣ Your CURRENT Structure (Simplified)

```
lib/
 ├─ core/
 ├─ features/
 │   ├─ auth/
 │   │   ├─ cubit/
 │   │   ├─ pages/
 │   │   └─ repository/
 │   │
 │   └─ home/
 │       ├─ cubit/
 │       ├─ pages/
 │       ├─ repository/
 │       └─ widgets/
 │
 ├─ models/
 │   ├─ user_model.dart
 │   └─ task_model.dart
 │
 └─ main.dart
```

### Problems (Interviewers notice these):

- `models` are global (feature leakage)
- `repository` mixes interface + implementation
- Cubit directly depends on repository
- No clear domain layer

---

# 2️⃣ TARGET Structure (Minimal Clean Architecture)

We **refactor, not rewrite**.

```
lib/
 ├─ core/
 │   ├─ constants/
 │   ├─ services/
 │   └─ di/
 │
 ├─ features/
 │   └─ home/
 │       ├─ data/
 │       │   ├─ models/
 │       │   │   └─ task_model.dart
 │       │   ├─ datasources/
 │       │   │   └─ home_remote_ds.dart
 │       │   └─ repositories/
 │       │       └─ home_repo_impl.dart
 │       │
 │       ├─ domain/
 │       │   ├─ entities/
 │       │   │   └─ task.dart
 │       │   ├─ repositories/
 │       │   │   └─ home_repository.dart
 │       │   └─ usecases/
 │       │       └─ get_tasks.dart
 │       │
 │       └─ presentation/
 │           ├─ cubit/
 │           ├─ pages/
 │           └─ widgets/
 │
 └─ main.dart
```

---

# 3️⃣ Step-by-Step Refactor (REALISTIC)

## ✅ Step 1: Move Models into Feature

**Before**

```
lib/models/task_model.dart
```

**After**

```
features/home/data/models/task_model.dart
```

---

## ✅ Step 2: Create Domain Entity (PURE Dart)

```dart
// domain/entities/task.dart
class Task {
  final String id;
  final String title;

  Task({required this.id, required this.title});
}
```

🔑 Entity ≠ Model

- Entity → business object
- Model → API/JSON mapping

---

## ✅ Step 3: Repository Contract (Domain)

```dart
// domain/repositories/home_repository.dart
abstract class HomeRepository {
  Future<List<Task>> getTasks();
}
```

🟢 No API
🟢 No Flutter
🟢 Testable

---

## ✅ Step 4: Use Case (Business Logic)

```dart
// domain/usecases/get_tasks.dart
class GetTasks {
  final HomeRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() {
    return repository.getTasks();
  }
}
```

📌 Cubit will call **ONLY this**

---

## ✅ Step 5: Data Source

```dart
// data/datasources/home_remote_ds.dart
class HomeRemoteDataSource {
  final ApiService api;

  HomeRemoteDataSource(this.api);

  Future<List<Map<String, dynamic>>> getTasks() {
    return api.get('/tasks');
  }
}
```

---

## ✅ Step 6: Repository Implementation

```dart
// data/repositories/home_repo_impl.dart
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remote;

  HomeRepositoryImpl(this.remote);

  @override
  Future<List<Task>> getTasks() async {
    final data = await remote.getTasks();
    return data.map((e) => TaskModel.fromJson(e).toEntity()).toList();
  }
}
```

---

## ✅ Step 7: Model → Entity Mapping

```dart
// data/models/task_model.dart
class TaskModel {
  final String id;
  final String title;

  TaskModel({required this.id, required this.title});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
    );
  }

  Task toEntity() {
    return Task(id: id, title: title);
  }
}
```

---

## ✅ Step 8: Update Cubit (Clean)

```dart
class HomeCubit extends Cubit<HomeState> {
  final GetTasks getTasks;

  HomeCubit(this.getTasks) : super(HomeInitial());

  void fetchTasks() async {
    emit(HomeLoading());
    try {
      final tasks = await getTasks();
      emit(HomeLoaded(tasks));
    } catch (_) {
      emit(HomeError());
    }
  }
}
```

🚫 No API
🚫 No JSON
🚫 No repository directly

---

# 4️⃣ Dependency Injection (get_it)

```dart
final sl = GetIt.instance;

void setupDI() {
  // Core
  sl.registerLazySingleton(() => ApiService());

  // Data
  sl.registerLazySingleton(() => HomeRemoteDataSource(sl()));
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl()),
  );

  // Domain
  sl.registerLazySingleton(() => GetTasks(sl()));

  // Presentation
  sl.registerFactory(() => HomeCubit(sl()));
}
```

---

# 5️⃣ FINAL Dependency Rule (Say This Confidently)

> UI depends on Cubit
> Cubit depends on UseCases
> UseCases depend on abstract Repositories
> Data layer implements those repositories

---

# 6️⃣ Interview-Ready One-Line Explanation

> “I refactored the app into feature-based Clean Architecture where Cubits manage UI state, use cases handle business logic, repositories abstract data sources, and the data layer manages API and models.”

---

## What Next?

I can now:
1️⃣ Add **unit tests per layer**
2️⃣ Do same refactor for **auth feature**
3️⃣ Explain **why this beats MVC/MVVM in Flutter**
4️⃣ Give **senior-level architecture interview Q&A**

Just reply with the number 👌

---

# Setup & Run 🚀

## Prerequisites ✅

- Flutter SDK (https://flutter.dev)
- An Android/iOS simulator or a real device
- (Optional) Android Studio / Xcode for emulators

## Quick start (development)

1. Make sure the backend is running and the base URL is correct. The default value is in `lib/core/constants/constants.dart`:

   - Android emulator: `http://10.0.2.2:8000`
   - iOS simulator / web: `http://localhost:8000`

2. Install dependencies:

```bash
cd frontend
flutter pub get
```

3. Generate code (auto_route / json_serializable / freezed / injectable):

```bash
flutter pub run build_runner build --delete-conflicting-outputs
# or for watch mode
flutter pub run build_runner watch --delete-conflicting-outputs
```

4. Run the app:

```bash
flutter run
```

## Build (release)

```bash
# Android
flutter build apk
# Web
flutter build web
```

## Troubleshooting ⚠️

- On Android emulators use `10.0.2.2` to reach services running on the host machine.
- If code generation fails, try cleaning (`rm -rf .dart_tool build`) and re-run build_runner.

---

npm run dev
docker-compose up -d --build
