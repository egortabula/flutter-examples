# Flutter Examples

A collection of **practical Flutter examples** used in articles, tutorials, and real-world scenarios.

This repository is organized as a **monorepo** where each folder contains a fully isolated Flutter project demonstrating a specific concept, pattern, or solution.

The goal of this repository is to provide:
- runnable examples instead of abstract explanations
- real-world solutions to common Flutter problems
- clean and minimal setups that are easy to explore and modify

---

## 📁 Structure

All examples are located in the `examples/` directory. Each subdirectory is a standalone Flutter project.

## 🛠️ Managing the Monorepo

This repository uses [Melos](https://melos.invertase.dev/) to manage multiple Flutter packages.

### Setup

1. Install Melos globally:
   ```bash
   dart pub global activate melos
   ```

2. Bootstrap the workspace:
   ```bash
   melos bootstrap
   ```

### Common Commands

- **Get dependencies for all projects:**
  ```bash
  melos run pub:get
  ```

- **Run tests for all projects:**
  ```bash
  melos run test
  ```

- **Analyze all projects:**
  ```bash
  melos run analyze
  ```

- **Clean all projects:**
  ```bash
  melos run clean
  ```

---

## 📚 Examples

### [go_router_mock_testing](examples/go_router_mock_testing)
**Article:** How to Mock go_router in Flutter Widget Tests (Without MaterialApp.router)

Demonstrates how to effectively test Flutter widgets that use go_router for navigation without relying on MaterialApp.router. Includes practical examples of mocking navigation in widget tests.

---

## 🔗 Links

- [Medium Articles](https://medium.com/@egortabula)
- [YouTube Channel](#)
- [TikTok](#)

---

## 📝 License

This repository is for educational purposes. Feel free to use the examples in your own projects.