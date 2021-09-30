import pytest

def testable_function(x):
  return 2 * x

def test_testable_function():
  assert testable_function(2) == 4
