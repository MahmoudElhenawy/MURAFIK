# ⚡ Quick Start Guide - Auth Feature

## 🚀 شغّل التطبيق الآن

```bash
cd e:\projects\murafik
flutter pub get
flutter run
```

---

## 🔐 اختبر الـ Auth Flows

### Flow 1: Register
```
1. اذهب إلى /choose-role
2. اختر دور (Patient, Doctor, Supervisor)
3. ملء النموذج:
   - Username: test_user
   - Email: test@example.com
   - Password: password123
   - Role: Patient
4. اضغط Register
```

### Flow 2: Login
```
1. اذهب إلى /login
2. ملء النموذج:
   - Email: ahmed1234@test.com
   - Password: (from backend)
3. اضغط Sign In
4. يجب أن ترى: ✅ Success message
```

---

## 📝 الملفات المهمة

### للفهم السريع:
```
📖 README_AUTH_FEATURE.md      ← اقرأ هنا أولاً
📖 ARCHITECTURE.md              ← المعمارية بالتفصيل
📖 AUTH_IMPLEMENTATION_GUIDE.md ← شرح الاستخدام
```

### للكود:
```
🔧 lib/feature/auth/            ← كل شيء عن Auth
🔧 lib/main.dart                 ← Entry point
🔧 lib/core/service_locator/     ← DI setup
```

---

## 🛠️ إذا واجهت مشكلة

### مشكلة: "Auth data sources is not registered"
```dart
// الحل: تأكد من استدعاء setupServiceLocator() في main.dart
void main() {
  setupServiceLocator();  // ← هذا مهم!
  runApp(const MURAFIK());
}
```

### مشكلة: API Connection Error
```dart
// تحقق من:
// 1. اتصال الـ network ✓
// 2. API الـ Base URL: http://murafik.runasp.net/api/auth
// 3. الـ Backend running وشغّال
```

### مشكلة: Token Not Saving
```dart
// الحل: أضف SharedPreferences (الخطوة التالية)
// حالياً الـ token يُعرض فقط في AuthSuccess state
```

---

## ✨ الخطوات الفورية القادمة

### Phase 1 - إضافة Token Storage (1-2 ساعة)

```dart
// 1. أضف shared_preferences
// pubspec.yaml:
shared_preferences: ^2.2.2

// 2. أنشئ TokenService
class TokenService {
  static const _tokenKey = 'access_token';
  
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }
  
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
  
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}

// 3. في AuthSuccess listener:
if (state is AuthSuccess) {
  await tokenService.saveToken(state.authResponse.accessToken ?? '');
  context.go('/PatientHome');  // أو الصفحة المناسبة
}
```

### Phase 2 - Dio Interceptor (30-45 دقيقة)

```dart
// في service_locator.dart:
getIt.registerSingleton<Dio>(
  Dio(BaseOptions(...))
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await tokenService.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    ),
);
```

### Phase 3 - Auto-login (45 دقيقة)

```dart
// في Splash Screen:
if (savedToken != null) {
  // User logged in before - navigate to home
  context.go('/PatientHome');
} else {
  // No token - go to login
  context.go('/login');
}
```

---

## 🎓 أفكار للتعلم

### 1. فهم Clean Architecture
- اقرأ: [Resocoder's Clean Architecture Guide](https://resocoder.com/flutter-clean-architecture)
- اختبر: جرب نفس Pattern على Feature أخرى

### 2. فهم BLoC Pattern
- اقرأ: [BLoC Library Docs](https://bloclibrary.dev/)
- اختبر: أضف feature جديدة باستخدام نفس Pattern

### 3. Error Handling مع Either
- اقرأ: [Dartz Documentation](https://pub.dev/packages/dartz)
- اختبر: تعامل مع حالات الأخطاء المختلفة

---

## 🎯 معالم التطوير

### تم ✅
- [x] Clean Architecture 3 Layers
- [x] Cubit State Management
- [x] API Integration
- [x] Error Handling
- [x] UI Components
- [x] Dependency Injection

### قادم 🔜
- [ ] Token Storage
- [ ] Auto-login
- [ ] Logout
- [ ] Doctor Feature
- [ ] Patient Feature
- [ ] Supervisor Feature

---

## 💡 Pro Tips

### 1. إضافة Feature جديدة بنفس Pattern
```
lib/feature/[feature_name]/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/
│   ├── models/
│   ├── datasources/
│   └── repositories/
└── presentation/
    ├── cubit/
    ├── screens/
    └── widgets/
```

### 2. Testing الـ API
```dart
// استخدم Postman:
POST http://murafik.runasp.net/api/auth/login
Headers: Content-Type: application/json
Body: {
  "email": "sara@test.com",
  "password": "..."
}
```

### 3. Debugging
```dart
// في main.dart:
void main() {
  // أضف logging
  Dio().interceptors.add(LoggingInterceptor());
  setupServiceLocator();
  runApp(const MURAFIK());
}
```

---

## 📊 Code Structure Overview

```
MURAFIK
├── Domain (Pure Business Logic)
│   ├── Entities: UserEntity, AuthResponseEntity
│   ├── Repositories: AuthRepository (abstract)
│   └── Usecases: LoginUsecase, RegisterUsecase
│
├── Data (Implementation Details)
│   ├── Models: UserModel, AuthResponseModel
│   ├── Datasources: AuthRemoteDataSource
│   └── Repositories: AuthRepositoryImpl
│
└── Presentation (UI & State)
    ├── Cubit: AuthCubit (state management)
    ├── States: AuthInitial, AuthLoading, AuthSuccess, AuthFailure
    ├── Screens: LoginScreen, RegisterScreen
    └── Widgets: LoginForm, RegisterForm
```

---

## 🚀 خطوات التشغيل الأولى

### 1. تحقق من التثبيت
```bash
flutter doctor
# يجب أن ترى ✓ بـ connected device
```

### 2. شغّل التطبيق
```bash
flutter run
# أو F5 في VS Code
```

### 3. اختبر الـ Auth
```
1. اضغط على "Login"
2. ملء البيانات
3. يجب أن ترى loading indicator
4. ثم success أو error message
```

### 4. تحقق من الـ Console
```
✓ لا توجد errors
✓ شاهد أسماء الـ classes في stack trace
✓ استخدم print() للـ debugging
```

---

## ❓ الأسئلة الشائعة

### س: ماذا أفعل بـ API response؟
**ج**: استخرج الـ token والـ user info من `AuthSuccess.authResponse`

### س: كيف أحفظ الـ token؟
**ج**: استخدم SharedPreferences (راجع Phase 1)

### س: كيف أضيف feature جديدة؟
**ج**: اتبع نفس Pattern (Domain → Data → Presentation)

### س: هل أحتاج إلى database؟
**ج**: حالياً التطبيق يعتمد على API فقط. يمكنك إضافة local DB لاحقاً.

---

## 📞 الدعم

إذا واجهت مشكلة:
1. اقرأ الـ error message بعناية
2. تحقق من `ARCHITECTURE.md`
3. جرب مثال من `AUTH_IMPLEMENTATION_GUIDE.md`
4. استخدم flutter doctor للتحقق من البيئة

---

**الآن أنت جاهز للبدء! 🚀**

اختبر الـ Auth feature وأرني النتائج!
