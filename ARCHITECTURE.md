# 🏗️ Auth Feature Architecture Documentation

## بنية Clean Architecture + Cubit

```
lib/
├── feature/auth/
│   ├── domain/
│   │   ├── entities/
│   │   │   ├── user_entity.dart
│   │   │   └── auth_response_entity.dart
│   │   ├── repositories/
│   │   │   └── auth_repository.dart (Abstract)
│   │   └── usecases/
│   │       ├── login_usecase.dart
│   │       └── register_usecase.dart
│   │
│   ├── data/
│   │   ├── models/
│   │   │   ├── user_model.dart
│   │   │   └── auth_response_model.dart
│   │   ├── datasources/
│   │   │   └── auth_remote_datasource.dart
│   │   └── repositories/
│   │       └── auth_repository_impl.dart
│   │
│   └── presentation/
│       ├── cubit/
│       │   ├── auth_cubit.dart
│       │   └── auth_state.dart
│       ├── screens/
│       │   ├── login_screen.dart
│       │   └── register_screen.dart
│       └── widgets/
│           ├── login_form.dart
│           └── register_form.dart
│
├── core/
│   ├── errors/
│   │   └── failures.dart
│   └── service_locator/
│       └── service_locator.dart
```

## 🔄 Data Flow

### Login Flow:
```
UI (LoginScreen)
    ↓
AuthCubit.login()
    ↓
LoginUsecase()
    ↓
AuthRepository.login()
    ↓
AuthRemoteDataSource.login()
    ↓
Dio HTTP Request
    ↓
API Response
    ↓
AuthResponseModel (parsed)
    ↓
Either<Failure, AuthResponseEntity>
    ↓
AuthCubit emits AuthSuccess/AuthFailure
    ↓
UI updates (SnackBar, Navigation)
```

## 📦 API Responses

### Register Response:
```json
{
  "success": true,
  "message": "Registration successful!",
  "accessToken": null,
  "expiresAt": "0001-01-01T00:00:00",
  "user": {
    "id": 9,
    "username": "patient1234_ahmed",
    "email": "ahmed1234@test.com",
    "role": "Patient",
    "patientId": 5,
    "doctorId": null,
    "supervisorId": null
  }
}
```

### Login Response:
```json
{
  "success": true,
  "message": "Login successful",
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "expiresAt": "2026-05-04T17:31:42.8192083Z",
  "user": {
    "id": 3,
    "username": "Sara Ahmed",
    "email": "sara@test.com",
    "role": "Supervisor",
    "patientId": null,
    "doctorId": null,
    "supervisorId": 1
  }
}
```

## 🛠️ Usage

### في Screens:

```dart
// إرسال event إلى Cubit
context.read<AuthCubit>().login(
  email: email,
  password: password,
);

// الاستماع إلى التغييرات
BlocListener<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is AuthSuccess) {
      // Navigate or show success
    } else if (state is AuthFailure) {
      // Show error
    }
  },
)

// بناء UI على أساس الحالة
BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) {
    if (state is AuthLoading) {
      return CircularProgressIndicator();
    }
    return YourWidget();
  },
)
```

## 🔐 States التي يصدرها Cubit:

1. **AuthInitial** - الحالة الأولية
2. **AuthLoading** - أثناء المعالجة
3. **AuthSuccess** - تسجيل دخول/تسجيل ناجح
   - يحتوي على `AuthResponseEntity` بـ user وـ accessToken
4. **AuthFailure** - خطأ في المعالجة
   - يحتوي على رسالة الخطأ

## 📋 Next Steps:

### 1. Token Storage (Local)
```dart
// استخدم SharedPreferences لتخزين accessToken
class TokenDataSource {
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }
}
```

### 2. Dio Interceptor
```dart
// أضف token إلى جميع الطلبات
dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) {
      final token = // get from storage
      options.headers['Authorization'] = 'Bearer $token';
      return handler.next(options);
    },
  ),
);
```

### 3. Auto-login مع Splash Screen
```dart
// في Splash Screen، تحقق من وجود token محفوظ
// وسجل الدخول تلقائياً
```

### 4. Logout
```dart
// أضف logout method في AuthCubit
Future<void> logout() async {
  // حذف token
  // emit AuthInitial
}
```
