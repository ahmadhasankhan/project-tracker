# 📁 Project Tracker

A Ruby on Rails application to manage projects, track status changes, and allow user conversations via comments.

---

## 🚀 Features

- Projects with statuses: `pending`, `in_progress`, and `completed`
- Users can leave comments on projects
- Status changes are logged
- Full conversation history combining comments and status logs

---

## 🛠️ Tech Stack

- Rails 8 and Ruby 3.2.2
- RSpec + FactoryBot (for testing)

---

## ⚙️ Setup

```bash
git clone git@github.com:ahmadhasankhan/project-tracker.git
cd project-tracker

bundle install
rails db:setup

# Start server
bin/dev
```

##  Project Status Tracking

Each project has a status:

```ruby
enum status: { pending: 0, in_progress: 1, completed: 2 }
```

## 🧪 Running Tests

We use RSpec for testing.

```bash
bundle exec rspec
```
