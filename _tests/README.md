# Test Suite

Integration tests for the MNHSFL website build system.

## Running Tests

```bash
# Run all tests
pytest _tests/test_generate_results.py -v

# Run specific test class
pytest _tests/test_generate_results.py::TestResultsGeneration -v

# Run specific test
pytest _tests/test_generate_results.py::TestResultsGeneration::test_csv_with_frontmatter_and_intro -v

# Run tests matching a pattern
pytest _tests/test_generate_results.py -k "frontmatter" -v

# Run with coverage
pytest _tests/test_generate_results.py --cov=_scripts --cov-report=term-missing
```

## Test Organization

All tests follow the **AAA (Arrange-Act-Assert) pattern**:

```python
def test_example(test_env, generator):
    """Test: Description of what we're testing."""
    # Arrange
    copy_fixture(test_env, "my-fixture", "output-name-2025")
    
    # Act
    generator.run()
    
    # Assert
    output_files = list(test_env['posts_dir'].glob("*.md"))
    assert len(output_files) == 1
```

## Test Structure

```
_tests/
├── test_generate_results.py    # Integration tests for results generator
└── fixtures/                    # Test data (CSV and MD files together)
    ├── basic-tournament.csv
    ├── spring-open.csv
    ├── spring-open.md           # Paired with spring-open.csv
    ├── winter-classic.csv
    ├── winter-classic.md        # Paired with winter-classic.csv
    ├── inconsistent-columns.csv
    ├── empty.csv
    ├── bom-test.csv
    ├── special-chars.csv
    └── special-chars.md         # Paired with special-chars.csv
```

## Fixtures

Test fixtures are real CSV and Markdown files stored together in the `fixtures/` directory.
This mirrors the real-world usage where CSV and MD files sit side-by-side.

The `copy_fixture()` helper automatically copies both CSV and MD files if they exist:

```python
def test_my_scenario(test_env, generator):
    """Test: My new scenario."""
    # Arrange
    copy_fixture(test_env, "my-fixture", "output-name-2025")  # Copies both .csv and .md if present
    
    # Act
    generator.run()
    
    # Assert
    output_files = list(test_env['posts_dir'].glob("*.md"))
    assert len(output_files) == 1
```

### Adding New Test Fixtures

1. Add `my-fixture.csv` to `fixtures/`
2. (Optional) Add `my-fixture.md` to `fixtures/`
3. Use `copy_fixture(test_env, "my-fixture", "output-name-2025")` in your test

## Pytest Features Used

- **Fixtures**: `test_env` and `generator` are pytest fixtures that set up/tear down test directories
- **Parameterization**: `@pytest.mark.parametrize` generates multiple test cases from one test function
- **Classes**: Tests grouped into logical classes for organization
- **Pattern matching**: Run subsets with `-k` flag

## Coverage

The test suite covers:
- ✅ CSV only (no .md file) - uses default frontmatter
- ✅ CSV with frontmatter (no intro content)
- ✅ CSV with frontmatter AND intro content
- ✅ Inconsistent column counts (padding/truncation)
- ✅ Empty CSV files
- ✅ UTF-8 BOM handling
- ✅ Multiple CSV files (parameterized: 1, 3, 5 files)
- ✅ Special characters in frontmatter (colons, quotes)
- ✅ Edge cases (no source dir, no CSV files)

Total: 12 test cases (10 base + 2 parameterized variants)

## CI/CD

Tests run automatically on GitHub Actions:
- On push to `master`
- On PRs that modify generator or tests
- On changes to test fixtures
- Manual trigger available

See `.github/workflows/test-results-generator.yml`
