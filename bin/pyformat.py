#!/home/meitham/.pyenv/versions/3.7.3/envs/pylinters/bin/python
import os
import sys

import autoflake
import autopep8
import isort

autopep8_options = {
    'max_line_length': 79,
    # 'aggressive': 1,
    # 'select': ['E501'],
}

isort_config = isort.Config(
    settings_file=os.path.expanduser('~/.config/isort.cfg'))


def clean_path(path):
    with open(path) as f:
        content = f.read()
    cleaned = clean_string(content)
    with open(path, 'w') as f:
        f.write(cleaned)


def clean_string(content):
    content = autopep8.fix_code(content, options=autopep8_options)
    content = autoflake.fix_code(content,
                                 expand_star_imports=True,
                                 remove_duplicate_keys=True,
                                 remove_unused_variables=True,
                                 remove_all_unused_imports=True)
    content = isort.code(content, config=isort_config)
    content = content.replace('\r\n', '\n')
    return content.strip()


def allmodules(path):
    with os.scandir(path) as it:
        for entry in it:
            if entry.name.endswith('.py') and entry.is_file():
                yield entry.path
            elif entry.is_dir():
                yield from allmodules(entry)


def main():
    modules = allmodules('.')
    for m in modules:
        clean_path(m)


if __name__ == '__main__':
    if '-' in sys.argv:
        print(clean_string(sys.stdin.read()))
    else:
        main()