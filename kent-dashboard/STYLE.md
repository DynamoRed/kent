# Introduction

This file describes the various style and design conventions that are used in the Kent dashboard repository.

# TypeScript Coding Conventions

Our TypeScript style is inspired by the [style guidelines](https://github.com/Microsoft/TypeScript/wiki/Coding-guidelines) of the TypeScript implementation itself.

## Naming

1. Use PascalCase for type names.
1. Do not use `I` as a prefix for interface names.
1. Use PascalCase for `enum` values.
1. Use `camelCase` for function names.
1. Use `camelCase` for property names and local variables.
1. Use `_` as a prefix for private properties.
1. Use whole words in names when possible.
1. Give type parameters names prefixed with `T`, for example `Request<TBody>`.

## Syntax and Types

1. Use `undefined`. Do not use `null`.
1. Prefer `for..of` over `.forEach`.
1. Do not introduce new types/values to the global namespace.

## File and Export Structure

1. Keep `main.ts` free from implementation, it should only contain re-exports.
1. If a file has a single or a main export, name the file after the export.

# Documentation Guidelines

We use [API Extractor](https://api-extractor.com/pages/overview/demo_docs/) to generate our documentation, which in turn uses [TSDoc](https://github.com/microsoft/tsdoc) to parse our doc comments.

The doc comments are of the good old `/** ... */` format, with tags of the format `@<tag>` used to mark various things. The [TSDoc website](https://tsdoc.org/) has a good index of all available tags.

There are a few things to pay attention to, in order to make the documentation show up in a nice way on the website...

## Use `@remarks` to split long descriptions

The API reference has an index of exported symbols for each package, which uses a short description, while clicking through to the page for a symbol shows the full description. By default all descriptions are considered "short", and you have to manually add a divider where the description should be cut off using the `@remarks` tag.

```ts
/**
 * This function helps you create a thing.
 *
 * @remarks
 *
 * Here is a much longer and more elaborate description of how the
 * creation of a thing works, which is way too long to fit on the index page.
 */
function createTheThing() {}
```

## Use `@param` to document parameters

When using the `@param` tag to document a parameter it will show up in the **Parameters** section:

![image](https://user-images.githubusercontent.com/4984472/133120977-64004074-0afb-4e8a-9a2a-c846f04eb3d9.png)

Be sure to include a `-` after the parameter name as well as [required by TSDoc](https://tsdoc.org/pages/tags/param/), or you'll get a warning in the API report.

```ts
/**
 * Generates a PluginCacheManager for consumption by plugins.
 *
 * @param pluginId - The plugin that the cache manager should be created for. Plugin names should be unique.
 */
forPlugin(pluginId: string): PluginCacheManager {
  ...
}
```