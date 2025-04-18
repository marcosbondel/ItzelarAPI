# 🚀 Setup on Windows

To run this application locally, follow these installation and configuration steps.

## 📑 Table of Contents

- [Requirements](#requirements)
  - [Install Ruby](#install-ruby)
  - [Install Postgres](#install-postgres)
- [Install the API](#install-the-api)
  - [Clone the repository](#clone-the-repository)
  - [Install gems](#install-gems)
  - [Configure database credentials](#configure-database-credentials)
  - [Run the server](#run-the-server)

---

## 📋 Requirements
Install the following packages before trying to run the server.

---

### 🔴 Install Ruby

1. Download the Windows installer from the [official website](https://rubyinstaller.org/)
2. Verify the installation:
   ```bash
   ruby -v
   ```
   You should see output similar to:
   ```bash
   ruby 3.2.2p100 (2023-03-30 revision xyz) [x64-mingw-ucrt]
   ```
3. Verify additional components:
   - **RubyGems**:
     ```bash
     gem -v
     ```
   - **Bundler** (should be installed automatically):
     ```bash
     bundler -v
     ```

---

### 🐘 Install PostgreSQL

Follow the installation guide on [Datacamp's tutorial](https://www.datacamp.com/tutorial/installing-postgresql-windows-macosx).

⚠️ **Important!** During installation:
- Configure and save your credentials (username and password)
- Default username is typically `postgres`
- Remember your password as you'll need it for Rails configuration

---

## 💻 Install the API

---

### 📥 Clone the repository

```bash
git clone https://github.com/marcosbondel/API
```

---

### 💎 Install gems

```bash
cd API  # Navigate to project directory
bundle  # Install required gems
```

---

### 🔑 Configure database credentials

You'll need to configure credentials for both development and test environments.

#### Development Environment
```bash
EDITOR="code --wait" rails credentials:edit --environment development
```

Paste this structure (replace with your actual credentials):
```yaml
db:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD

secret_key_base: my$ecretK3y 
```

#### Test Environment
```bash
EDITOR="code --wait" rails credentials:edit --environment test
```

Use the same structure as above with your test credentials.

---

### ▶️ Run the server

After completing all previous steps, execute these commands:

```bash
# Install gems (if not already done)
bundle

# Setup database
RAILS_ENV=development bin/rails db:create  # Create database
bin/rails db:migrate                      # Run migrations
bin/rails db:seed                         # Seed initial data

# Start the server
bin/rails server
```

Your API should now be running at `http://localhost:3000`!