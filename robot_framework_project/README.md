# Robot Framework SauceDemo Automation Project

A comprehensive Robot Framework automation project for testing the SauceDemo application using the Browser library with strict Page Object Model (POM) and configuration separation patterns.

## Project Structure

```
robot_framework_project/
├── config/
│   ├── config.yml          # Global environment settings
│   └── test_data.yml       # User credentials and test data
├── resources/
│   ├── init.resource       # Initialization and library imports
│   ├── common.resource     # App-agnostic reusable keywords
│   ├── sd_common.resource  # SauceDemo-specific shared logic
│   ├── sd_login_page.resource      # Login page POM
│   ├── sd_inventory_page.resource  # Inventory/Products page POM
│   ├── sd_cart_page.resource       # Shopping cart page POM
│   └── sd_checkout_page.resource   # Checkout page POM
└── test/
    ├── test_login.robot     # Login feature tests
    ├── test_inventory.robot # Product inventory tests
    ├── test_cart.robot      # Shopping cart tests
    ├── test_checkout.robot  # Checkout process tests
    └── test_e2e.robot       # End-to-end workflow tests
```

## Architecture

### Resources Layer
- **init.resource**: Central initialization point that imports all libraries and resources
- **common.resource**: Generic keywords for browser setup, context management, page interactions, and cleanup
  - `Create Web Driver`: Initializes browser (once per suite)
  - `Create Browser Context`: Creates isolated browser context (before each test)
  - `Open Web`: Opens base URL in new page
  - `Close Context`: Closes context after test
  - `Close Web Driver`: Closes browser (after suite completes)
- **sd_common.resource**: SauceDemo-specific shared logic (login variations, logout, cart management)
- **sd_*_page.resource**: Page Object Model files with locators and page-specific keywords

### Configuration Layer
- **config.yml**: Browser settings, base URL, timeouts, viewport dimensions
- **test_data.yml**: User credentials and static test messages

### Test Layer
- Organized by feature (Login, Inventory, Cart, Checkout, E2E)
- Each test imports init.resource for centralized dependency management
- Clear test naming and documentation

## Installation
- Organized by feature (Login, Inventory, Cart, Checkout, E2E)
- Each test imports init.resource for centralized dependency management
- Clear test naming and documentation

### Prerequisites
- Python 3.7+
- pip

### Setup Steps

1. Install Robot Framework and dependencies:
```bash
pip install -r requirements.txt
```

2. Install Browser library browsers:
```bash
rfbrowser init
```

## Configuration

### config.yml
Modify environment settings:
```yaml
browser: chromium        # chromium, firefox, webkit
headless: false          # Set to true for CI/CD
base_url: https://www.saucedemo.com/
global_timeout: 30s
```

### test_data.yml
Update test credentials and messages as needed:
```yaml
users:
  standard:
    username: standard_user
    password: secret_sauce
```

## Running Tests

### Run all tests
```bash
robot test/
```

### Run specific test suite
```bash
robot test/test_login.robot
```

### Run specific test case
```bash
robot -t "Login With Valid Credentials" test/test_login.robot
```

### Run with options
```bash
robot --variable headless:true -d results/ test/
```

## Test Suites

### test_login.robot
- Login with valid credentials
- Login with locked out user
- Login with invalid credentials
- Empty field validation
- Logout functionality

### test_inventory.robot
- View products on inventory page
- Add single and multiple products to cart
- Remove products from cart
- Navigate to cart from products page

### test_cart.robot
- View cart with items
- View empty cart
- Continue shopping from cart
- Remove items from cart page
- View cart totals

### test_checkout.robot
- Complete purchase successfully
- Missing field validation
- Checkout cancellation

### test_e2e.robot
- Complete shopping workflow (login → add items → checkout → confirmation)
- Add/remove items workflow
- Logout workflow

## Coding Standards

### Locators
- Use `UPPER_SNAKE_CASE` for variable names
- Use specific selectors: `data-test`, `id`, `css`, `xpath`
- Example: `${LOGIN_USERNAME_INPUT}`

### Best Practices
- Each test runs in isolation with a clean browser context
- Browser instance persists across tests (reused for efficiency)
- Use `Open Web` at the start of each test to open base URL
- Centralize locators in respective page object files
- Keep tests independent and repeatable
- Proper resource cleanup ensures no test data bleed-throughcumentation]`
- Use descriptive argument names

### Best Practices
- Centralize locators in respective page object files
- Keep tests independent and repeatable

## Extending the Project

### Adding New Page Objects
1. Create `sd_<page_name>.resource` in `resources/`
### Adding New Tests
1. Create `test_<feature>.robot` in `test/`
2. Import `init.resource`
3. Define Suite Setup/Teardown (Create Web Driver / Close Web Driver)
4. Define Test Setup/Teardown (Create Browser Context / Close Context)
5. Write test cases with clear documentation
6. Start each test with `Open Web` keyword
1. Create `test_<feature>.robot` in `test/`
2. Import `init.resource`
3. Define Suite Setup/Teardown
4. Write test cases with clear documentation

## Troubleshooting

### Browser not launching
- Ensure Browser library is properly installed: `rfbrowser init`
- Check browser version compatibility

### Element not found
- Verify element locator is correct using browser dev tools
- Check if element is visible before interaction
- Increase timeout if element loads slowly

### Configuration not loading
- Ensure YAML files are in `config/` directory
- Check YAML syntax (spaces not tabs)
- Verify paths use ${CURDIR} correctly
