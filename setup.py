from setuptools import setup

setup(
    name='SRIJAS',
    version='v4.0.0',
    description='Project Phase 2 submission.',
    author='Hardik Udeshi',
    author_email='hvudeshi@ncsu.edu',
    packages=[],
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
            'selenium',
            'pytest',
            'pymysql',
            'mysql-connector-python',
            'webdriver_manager'
        ],
        )
