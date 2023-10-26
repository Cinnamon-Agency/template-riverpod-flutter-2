# Riverpod Template (TripFinder app)


### Git Policy
https://docs.google.com/document/d/1e80YkBdLMYWkLbbg_Yjy6tlRpJs5ooP89FR6nvbZMco/edit#heading=h.7hj7y5ukatf6
In addition to Cinnamon's Git Policy, follow the Git Flow principle.

Make use of "fixes #issue_num" in commit messages to automatically close issues on merge.



### Documentation
https://pub.dev/packages/dcdg


### Infra
Holds the infrastructure that is usually shared across the features, such as http, local storage, in app purchases, notifications.
This should __not__ contain any UI related code. 
In this example we are using both Services and Repositories + Data Sources, the reason for that is
to show how Repositories help when using Firestore. Services in this case are "enchanced" Data Sources.

### Features 
Contains individual features of the app that are independent of each other or not closely related.
Sometimes you may have a situation where you need to access an user from home page, even though
user controller is in eg Profile feature, that is unavoidable - but do strive to make features independent.
For example Splash is an independent feature in sense that other features do not depend on it, but splash depends on pretty much everything in infra.

Each Feature should have its own folder with the following structure:
```
feature_name
    - controllers
        - feature_name_controller.dart
        - feature_name_state.dart
    - view
        - feature_name_page.dart
        - widgets        
```
### Helpers
Contains helper classes that are used across the app, such as extensions, utils, etc.
You may group them by directories if you have a lot of them.


#### Logic
- you can use a repository in another repository, however be careful of circular dependencies
- you can inject multiple data sources into a repository 
- data sources should be stateless, repoistories can be stateful but be careful of when constructing them if there is a .watch in scope, it may cause memory leaks
  - you don't need to define a provider for each, but if you are using a datasouce in multiple repositories, you should
- don't inject repositories/datasources into services, rather follow the repo + ds pattern
- you can use services and repositories in [Async]Notifiers/FutureProviders/StreamProviders
- do NOT user data sources in [Async]Notifiers/FutureProviders/StreamProviders
- repository should ALWAYS return a model, **NEVER** an entity even if they are the same (they have same fields)
  - you may use ```typedef Model = Entity``` , or better ```class Model extends Entity```
- sometimes it is easier to call a FutureProvider instead of calling a repository in a [Async]Notifier - ALWAYS document this 
- lean to using AutoDisposeable in [Async]Notifiers/FutureProviders/StreamProviders 
- models and states **MUST** be immutable, use copyWith to change a field, and MUST have equatable implemented or use @freezed
- models, if constructed from entity, **MUST** have factory constructor fromEntity or static method fromEntity
- entities can optionally have equatable implemented
- **NEVER** call repository/datasource/service from a widget/view, always call a controller
- do not use StateProvider rather make a Notifier 
- do not declare Repositories/Services as final in controller, rather make a getter and invoke when needed
  - although services and repositories are mostly stateless and have pure functions, using getters allows us to ensure we are using the latest instance 
```
AuthService get _authService => ref.read(authServiceProvider);
```
- in case you want to rebuild controller when a service/repo updates simply watch it in build method
- make use of exceptions - dont return true/false, or Type/null - throw an exception instead
  - take TravelerException as inspiration
- when using streams from repository, wrap them with a provider so that they are properly disposed on rebuilds

### UI
- don't place eg ScrollController in notifier, use hooks instead 
- for forms always use flutter_form_builder and make custom fields if needed, **NEVER** use TextFormField directly
- don't place text/scroll/etc controllers in Notifiers or their states, use hooks or consumerstateful widgets
  - if you place them in Notifier, you will have to dispose them manually on ref.dispose


### Testing
- if you can make tests for repositories and services




### Explaining Architectual Decisions


- Why not use code generation for Riverpod?
  - Not using it because onboarding will be hard, and builds will take long

- Why use code generation for assets?
  - Makes using assets compile time safe

- Why isn't freezed used?
  - In my opinion freezed is most useful when you need advanced copy with, but other features are
unecceary because Dart added sealed classes. Please use dart data class plugin to generate copy with method
  


