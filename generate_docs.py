#!/usr/bin/env python
"""
Script to generate documentation for Django project using pdoc.
This script properly configures Django before importing modules.
"""

import os
import django
from pathlib import Path

# Configure Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'app.settings')
django.setup()

# Now run pdoc
from pdoc import pdoc

if __name__ == "__main__":
    modules = [
        'accounts',
        'credit_cards',
        'expenses',
        'loans',
        'members',
        'revenues',
        'transfers'
    ]

    pdoc(
        *modules,
        output_directory=Path('docs/Code')
    )

    print("Documentation generated successfully in docs/Code/")
