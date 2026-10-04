import warnings

from django.test import TestCase


class DeprecationTest(TestCase):
    def test_deprecation(self):
        warnings.warn(
            "Este código está deprecado!",
            DeprecationWarning
        )