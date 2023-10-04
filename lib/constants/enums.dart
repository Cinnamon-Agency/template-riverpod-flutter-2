/// Contains [Hero] widget tags for animating widgets between pages.
///
/// To connect widgets, create a new enum value and assign it to the [Hero]'s tag parameter
enum HeroAnimationTags {
  splashLogo,
}

/// The result of a user authentication action.
enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  weakPassword,
  userNotFound,
  invalidEmail,
  invalidLoginCredentials,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}
