from setuptools import setup

setup(
    name='SRIJAS',
    version='1.0',
    description='Project Phase 1 submission.',
    author='Parth Vijaykumar Patel',
    author_email='pvpatel2#ncsu.edu',
    packages=['src'],
        long_description="""\
            Hands on for the standard github repo files.
            .gitignore
            .travis.yml
            CITATION.md : fill on once you've got your ZENODO DOI going
            CODE-OF-CONDUCT.md
            CONTRIBUTING.md
            LICENSE.md
            README.md
            setup.py
            requirements.txt
            data/
              README.md
            test/
              README.md
            code/
              __init__.py
        """,
        classifiers=[
            "License :: MIT License",
            "Programming Language :: Python",
            "Development Status :: Initial",
            "Intended Audience :: Developers",
            "Topic :: Software Engineering",
        ],
        keywords='python requirements license gitignore',
        license='MIT',
        install_requires=[
            'numpy',
            'pytest',
            'configparser',
        ],
        )
