
# EasyBroker API Challenge – Ruby on Rails

## Architecture

This project uses a **feature-first (vertical slice)** architecture, where all logic for a feature lives in its own folder:

```
app/features/properties/
```

Each slice contains:

- **Contracts** – defines the provider abstraction (`Provider` contract)
- **Services** – EasyBroker API client implementation
- **UseCases** – application logic (pagination, iteration, mapping)
- **Data (DTOs)** – typed objects (`Property`) instead of raw hashes

This structure keeps domain logic isolated, testable, and independent of Rails controllers or CLI layers, making it easy to extend the feature or swap API providers without touching unrelated parts of the system.

---

## Setup

Install dependencies:

```bash
bundle install
```

Create a `.env` file (requires `dotenv-rails`):

```
EASYBROKER_API_KEY=your_key_here
EASYBROKER_BASE_URL=https://api.stagingeb.com
```

Start the server:

```bash
bin/rails server
```

---

## CLI Usage

List properties:

```bash
bin/rails easybroker:list_properties
```

---

## API Endpoint

```
GET /api/properties
```

Returns mapped property data (`title`, `public_id`).

---

## Tests

```bash
bundle exec rspec
```

---
