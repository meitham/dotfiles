#!/home/meitham/.pyenv/versions/tools/bin/python

import argparse
import sys

import toml
import yaml


def parse_arguments():
    description = 'YAML to TOML converter'
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('yaml', metavar='FILE',
                        type=argparse.FileType('r'),
                        default='-',
                        help='YAML file to convert (default: -)')
    parser.add_argument('--toml', metavar='FILE',
                        required=False,
                        type=argparse.FileType('w'),
                        default=sys.stdout,
                        help='YAML file to convert (default: -)')
    ns = parser.parse_args()
    return ns


def main():
    ns = parse_arguments()
    data = yaml.load(ns.yaml, Loader=yaml.FullLoader)
    ns.toml.write(toml.dumps(data))


if __name__ == '__main__':
    main()