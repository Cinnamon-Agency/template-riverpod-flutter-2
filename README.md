# Riverpod Template (TripFinder app)

### Infra
Holds the infrastructure that is usually shared across the features, such as http, local storage, in app purchases, notifications.
This should __not__ contain any UI related code. 
In this example we are using both Services and Repositories + Data Sources, the reason for that is
to show how Repositories help when using Firestore. Services in this case are "enchanced" Data Sources.

### Features 
Contains individual features of the app that are independent of each other or not closely related.
For example Splash is an independed feature in sense that other featured do not depend on it, but splash depends on pretty much everything in infra.

Each Feature should have its own folder with the following structure:
```
feature_name
    - controller
    - models (this is if controller does not already get models from a repository)
    - view
        - widgets        
```
### Helpers
Contains helper classes that are used across the app, such as extensions, utils, etc.
You may group them by directories if you have a lot of them.
 

### Usage


#### Logic
- you can use a repository in another repository, however be careful of circular dependencies
- you can inject multiple data sources into a repository 
  - you don't need to define a provider for each, but if you are using a datasouce in multiple repositories, you should
- don't inject repositories/datasources into services, rather follow the repo + ds pattern
- you can use services and repositories in [Async]Notifiers/FutureProviders/StreamProviders
- do NOT user data sources in [Async]Notifiers/FutureProviders/StreamProviders
- repository should ALWAYS return a model, never an entity even if they are the same (they have same fields)
- sometimes it is easier to call a FutureProvider instead of calling a repository in a [Async]Notifier - ALWAYS document this 
- lean to using AutoDisposeable in [Async]Notifiers/FutureProviders/StreamProviders 
- models MUST be immutable, use copyWith to change a field
- models Must have equatable implemented or use @freezed
- models, if constructed from entity, must have factory constructor fromEntity or static method fromEntity
- entities can optionally have equatable implemented
- never call repository/datasource/service from a widget/view, always call a controller
- do not use StateProvider unless its a "stateless" global provider
- do not initialize Repositories/Services when making a controller, rather make a getter and invoke when needed
```
AuthService get _authService => ref.read(authServiceProvider);
```
- in case you want to rebuild controller simply watch it in build method



### UI
- don't place eg ScrollController in notifier, use hooks instead 
- for forms always use flutter_form_builder and make custom fields if needed, never use TextFormField directly
