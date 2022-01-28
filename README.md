# Flutter State Management

## GetX

GetX is an extra-light and powerful solution for Flutter. It combines high-performance state management, intelligent dependency injection, and route management quickly and practically.

### Declaring a reactive variable

You have 3 ways to turn a variable into an "observable".

1 - The first is using Rx{Type}.

```dart
// initial value is recommended, but not mandatory
final name = RxString('');
final isLogged = RxBool(false);
final count = RxInt(0);
final balance = RxDouble(0.0);
final items = RxList<String>([]);
final myMap = RxMap<String, int>({});
```

2 - The second is to use Rx and use Darts Generics, Rx<Type>

``` dart
final name = Rx<String>('');
final isLogged = Rx<Bool>(false);
final count = Rx<Int>(0);
final balance = Rx<Double>(0.0);
final number = Rx<Num>(0)
final items = Rx<List<String>>([]);
final myMap = Rx<Map<String, int>>({});

// Custom classes - it can be any class, literally
final user = Rx<User>();
```

3 - The third, more practical, easier, and preferred approach, just add .obs as a property of your value 


```dart
final name = ''.obs;
final isLogged = false.obs;
final count = 0.obs;
final balance = 0.0.obs;
final number = 0.obs;
final items = <String>[].obs;
final myMap = <String, int>{}.obs;

// Custom classes - it can be any class, literally
final user = User().obs;
```
#### Having a reactive state, is easy.

As we know, Dart is now heading towards null safety. To be prepared, from now on, you should always start your Rx variables with an initial value.

#### Using the values in the view

``` dart
// controller file
final count1 = 0.obs;
final count2 = 0.obs;
int get sum => count1.value + count2.value;
```

``` dart
// view file
GetX<Controller>(
  builder: (controller) {
    print("count 1 rebuild");
    return Text('${controller.count1.value}');
  },
),
GetX<Controller>(
  builder: (controller) {
    print("count 2 rebuild");
    return Text('${controller.count2.value}');
  },
),
GetX<Controller>(
  builder: (controller) {
    print("count 3 rebuild");
    return Text('${controller.sum}');
  },
),
```
``` dart
var isLogged = false.obs;
```

``` dart
@override
onInit(){
  ever(isLogged, fireRoute);
  isLogged.value = await Preferences.hasToken();
}

fireRoute(logged) {
  if (logged) {
   Get.off(Home());
  } else {
   Get.off(Login());
  }
}
```

#### Note about Lists
Lists are completely observable as are the objects within it. That way, if you add a value to a list, it will automatically rebuild the widgets that use it.

``` dart
// On the controller
final String title = 'User Info:'.obs
final list = List<User>().obs;

// on the view
Text(controller.title.value), // String need to have .value in front of it
ListView.builder (
  itemCount: controller.list.length // lists don't need it
)
```
When you are making your own classes observable, there is a different way to update them:

``` dart
// on the model file
// we are going to make the entire class observable instead of each attribute
class User() {
  User({this.name = '', this.age = 0});
  String name;
  int age;
}

// on the controller file
final user = User().obs;
// when you need to update the user variable:
user.update( (user) { // this parameter is the class itself that you want to update
user.name = 'Jonny';
user.age = 18;
});
// an alternative way of update the user variable:
user(User(name: 'João', age: 35));

// on view:
Obx(()=> Text("Name ${user.value.name}: Age: ${user.value.age}"))
// you can also access the model values without the .value:
user().name; // notice that is the user variable, not the class (variable has lowercase u)
```
#### Other ways of using it
You can use Controller instance directly on GetBuilder value
``` dart
GetBuilder<Controller>(
  init: Controller(),
  builder: (value) => Text(
    '${value.counter}', //here
  ),
),
```
You may also need an instance of your controller outside of your GetBuilder, and you can use these approaches to achieve this
``` dart
class Controller extends GetxController {
  static Controller get to => Get.find();
[...]
}
// on you view:
GetBuilder<Controller>(  
  init: Controller(), // use it only first time on each controller
  builder: (_) => Text(
    '${Controller.to.counter}', //here
  )
),
```
or
``` dart
class Controller extends GetxController {
 // static Controller get to => Get.find(); // with no static get
[...]
}
// on stateful/stateless class
GetBuilder<Controller>(  
  init: Controller(), // use it only first time on each controller
  builder: (_) => Text(
    '${Get.find<Controller>().counter}', //here
  ),
),
```
You can use "non-canonical" approaches to do this. If you are using some other dependency manager, like get_it, modular, etc., and just want to deliver the controller instance, you can do this:
``` dart
Controller controller = Controller();
[...]
GetBuilder<Controller>(
  init: controller, //here
  builder: (_) => Text(
    '${controller.counter}', // here
  ),
),

```
## Dependency Management
Get has a simple and powerful dependency manager that allows you to retrieve the same class as your Bloc or Controller with just 1 lines of code, no Provider context, no inheritedWidget

#### Instancing Method
The methods and it's configurable parameters are
#### Get.put()
```dart

//The most common way of inserting a dependency. Good for the controllers of your views for example.
Get.put<SomeClass>(SomeClass());
Get.put<LoginController>(LoginController(), permanent: true);
Get.put<ListItemController>(ListItemController, tag: "some unique string");

//This is all options you can set when using put
Get.put<S>(
  // mandatory: the class that you want to get to save, like a controller or anything
  // note: "S" means that it can be a class of any type
  S dependency

  // optional: this is for when you want multiple classess that are of the same type
  // since you normally get a class by using Get.find<Controller>(),
  // you need to use tag to tell which instance you need
  // must be unique string
  String tag,

  // optional: by default, get will dispose instances after they are not used anymore (example,
  // the controller of a view that is closed), but you might need that the instance
  // to be kept there throughout the entire app, like an instance of sharedPreferences or something
  // so you use this
  // defaults to false
  bool permanent = false,

  // optional: allows you after using an abstract class in a test, replace it with another one and follow the test.
  // defaults to false
  bool overrideAbstract = false,

  // optional: allows you to create the dependency using function instead of the dependency itself.
  // this one is not commonly used
  InstanceBuilderCallback<S> builder,
)

```
#### Get.lazyPut
It is possible to lazyLoad a dependency so that it will be instantiated only when is used. Very useful for computational expensive classes or if you want to instantiate several classes in just one place (like in a Bindings class) and you know you will not gonna use that class at that time.

```dart

/// ApiMock will only be called when someone uses Get.find<ApiMock> for the first time
Get.lazyPut<ApiMock>(() => ApiMock());

Get.lazyPut<FirebaseAuth>(
  () {
    // ... some logic if needed
    return FirebaseAuth();
  },
  tag: Math.random().toString(),
  fenix: true
)

Get.lazyPut<Controller>( () => Controller() )

```
This is all options you can set when using lazyPut:
```dart

Get.lazyPut<S>(
  // mandatory: a method that will be executed when your class is called for the first time
  InstanceBuilderCallback builder,
  
  // optional: same as Get.put(), it is used for when you want multiple different instance of a same class
  // must be unique
  String tag,

  // optional: It is similar to "permanent", the difference is that the instance is discarded when
  // is not being used, but when it's use is needed again, Get will recreate the instance
  // just the same as "SmartManagement.keepFactory" in the bindings api
  // defaults to false
  bool fenix = false
  
)

```
#### Get.putAsync
If you want to register an asynchronous instance, you can use Get.putAsync
```dart

Get.putAsync<SharedPreferences>(() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('counter', 12345);
  return prefs;
});

Get.putAsync<YourAsyncClass>( () async => await YourAsyncClass() )

```
This is all options you can set when using putAsync

```dart

Get.putAsync<S>(

  // mandatory: an async method that will be executed to instantiate your class
  AsyncInstanceBuilderCallback<S> builder,

  // optional: same as Get.put(), it is used for when you want multiple different instance of a same class
  // must be unique
  String tag,

  // optional: same as in Get.put(), used when you need to maintain that instance alive in the entire app
  // defaults to false
  bool permanent = false
)

```

#### Get.create
```dart

Get.Create<SomeClass>(() => SomeClass());
Get.Create<LoginController>(() => LoginController());

```

This is all options you can set when using create

```dart

Get.create<S>(
  // required: a function that returns a class that will be "fabricated" every
  // time `Get.find()` is called
  // Example: Get.create<YourClass>(() => YourClass())
  FcBuilderFunc<S> builder,

  // optional: just like Get.put(), but it is used when you need multiple instances
  // of a of a same class
  // Useful in case you have a list that each item need it's own controller
  // needs to be a unique string. Just change from tag to name
  String name,

  // optional: just like int`Get.put()`, it is for when you need to keep the
  // instance alive thoughout the entire app. The difference is in Get.create
  // permanent is true by default
  bool permanent = true

```

### Instantiated Method/Class
Imagine that you have navigated through numerous routes, and you need a data that was left behind in your controller, you would need a state manager combined with the Provider or Get_it, correct? Not with Get. You just need to ask Get to "find" for your controller, you don't need any additional dependencies

``` dart

final controller = Get.find<Controller>();
// OR
Controller controller = Get.find();

// Yes, it looks like Magic, Get will find your controller, and will deliver it to you.
// You can have 1 million controllers instantiated, Get will always give you the right controller.

``` 

And then you will be able to recover your controller data that was obtained back there:

``` dart

Text(controller.textFromApi);

``` 

Since the returned value is a normal class, you can do anything you want:

``` dart

int count = Get.find<SharedPreferences>().getInt('counter');
print(count); // out: 12345

``` 

To remove an instance of Get:

``` dart

Get.delete<Controller>(); //usually you don't need to do this because GetX already delete unused controllers

``` 

## Route Management
This is the complete explanation of all there is to Getx when the matter is route management.

If you are going to use routes/snackbars/dialogs/bottomsheets without context, or use the high-level Get APIs, you need to simply add "Get" before your MaterialApp, turning it into GetMaterialApp and enjoy!

``` dart
GetMaterialApp( // Before: MaterialApp(
  home: MyHome(),
)
```
### Navigation without named routes

``` dart

//To navigate to a new screen
Get.to(NextScreen());
//To close snackbars, dialogs, bottomsheets, or anything you would normally close with Navigator.pop(context);
Get.back();
//To go to the next screen and no option to go back to the previous screen (for use in SplashScreens, login screens and etc.)
Get.off(NextScreen());
//To go to the next screen and cancel all previous routes (useful in shopping carts, polls, and tests)
Get.offAll(NextScreen());
//To navigate to the next route, and receive or update data as soon as you return from it
var data = await Get.to(Payment());
//on other screen, send a data for previous route
Get.back(result: 'success');

```
All the functions of the standard navigation
```dart

// Default Flutter navigator
Navigator.of(context).push(
  context,
  MaterialPageRoute(
    builder: (BuildContext context) {
      return HomePage();
    },
  ),
);

// Get using Flutter syntax without needing context
navigator.push(
  MaterialPageRoute(
    builder: (_) {
      return HomePage();
    },
  ),
);

// Get syntax (It is much better, but you have the right to disagree)
Get.to(HomePage());

```
#### Navigation with named routes
```dart

//To navigate to nextScreen
Get.toNamed("/NextScreen");

//To navigate and remove the previous screen from the tree.
Get.offNamed("/NextScreen");

//To navigate and remove all previous screens from the tree.
Get.offAllNamed("/NextScreen");

//To define routes, use GetMaterialApp
void main() {
  runApp(
    GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MyHomePage()),
        GetPage(name: '/second', page: () => Second()),
        GetPage(
          name: '/third',
          page: () => Third(),
          transition: Transition.zoom  
        ),
      ],
    )
  );
}

//To handle navigation to non-defined routes (404 error), you can define an unknown route page in GetMaterialApp.

void main() {
  runApp(
    GetMaterialApp(
      unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoutePage()),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MyHomePage()),
        GetPage(name: '/second', page: () => Second()),
      ],
    )
  );
}

```

#### Send data to named Routes

```dart

//Just send what you want for arguments. Get accepts anything here, whether it is a String, a Map, a List, or even a class instance
Get.toNamed("/NextScreen", arguments: 'Get is the best');

//on your class or controller
print(Get.arguments);
//print out: Get is the best

```
### SnackBars
To have a simple SnackBar with Flutter, you must get the context of Scaffold, or you must use a GlobalKey attached to your Scaffold
```dart

final snackBar = SnackBar(
  content: Text('Hi!'),
  action: SnackBarAction(
    label: 'I am a old and ugly snackbar :(',
    onPressed: (){}
  ),
);
// Find the Scaffold in the widget tree and use
// it to show a SnackBar.
Scaffold.of(context).showSnackBar(snackBar);

```

With Get:

```dart

Get.snackbar('Hi', 'i am a modern snackbar');

Get.snackbar(
  "Hey i'm a Get SnackBar!", // title
  "It's unbelievable! I'm using SnackBar without context, without boilerplate, without Scaffold, it is something truly amazing!", // message
  icon: Icon(Icons.alarm),
  shouldIconPulse: true,
  onTap:(){},
  barBlur: 20,
  isDismissible: true,
  duration: Duration(seconds: 3),
);


  ////////// ALL FEATURES //////////
  //     Color colorText,
  //     Duration duration,
  //     SnackPosition snackPosition,
  //     Widget titleText,
  //     Widget messageText,
  //     bool instantInit,
  //     Widget icon,
  //     bool shouldIconPulse,
  //     double maxWidth,
  //     EdgeInsets margin,
  //     EdgeInsets padding,
  //     double borderRadius,
  //     Color borderColor,
  //     double borderWidth,
  //     Color backgroundColor,
  //     Color leftBarIndicatorColor,
  //     List<BoxShadow> boxShadows,
  //     Gradient backgroundGradient,
  //     FlatButton mainButton,
  //     OnTap onTap,
  //     bool isDismissible,
  //     bool showProgressIndicator,
  //     AnimationController progressIndicatorController,
  //     Color progressIndicatorBackgroundColor,
  //     Animation<Color> progressIndicatorValueColor,
  //     SnackStyle snackStyle,
  //     Curve forwardAnimationCurve,
  //     Curve reverseAnimationCurve,
  //     Duration animationDuration,
  //     double barBlur,
  //     double overlayBlur,
  //     Color overlayColor,
  //     Form userInputForm
  ///////////////////////////////////

```

### Dialogs

```dart

//To open dialog
Get.dialog(YourDialogWidget());
//To open default dialog
Get.defaultDialog(
  onConfirm: () => print("Ok"),
  middleText: "Dialog made in 3 lines of code"
);

```

### BottomSheets
Get.bottomSheet is like showModalBottomSheet, but don't need of context.

```dart

Get.bottomSheet(
  Container(
    child: Wrap(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.music_note),
          title: Text('Music'),
          onTap: () {}
        ),
        ListTile(
          leading: Icon(Icons.videocam),
          title: Text('Video'),
          onTap: () {},
        ),
      ],
    ),
  )
);

```

### Nested Navigation
Get made Flutter's nested navigation even easier. You don't need the context, and you will find your navigation stack by Id.

```dart

Navigator(
  key: Get.nestedKey(1), // create a key by index
  initialRoute: '/',
  onGenerateRoute: (settings) {
    if (settings.name == '/') {
      return GetPageRoute(
        page: () => Scaffold(
          appBar: AppBar(
            title: Text("Main"),
          ),
          body: Center(
            child: FlatButton(
              color: Colors.blue,
              onPressed: () {
                Get.toNamed('/second', id:1); // navigate by your nested route by index
              },
              child: Text("Go to second"),
            ),
          ),
        ),
      );
    } else if (settings.name == '/second') {
      return GetPageRoute(
        page: () => Center(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Main"),
            ),
            body: Center(
              child:  Text("second")
            ),
          ),
        ),
      );
    }
  }
),
 


