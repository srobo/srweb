
import json
import os

def srweb_root():
    return os.path.abspath(os.path.dirname(os.path.dirname(__file__)))

def ensure_valid_json(root_relative_file):
    root = srweb_root()
    data_file = os.path.join(root, root_relative_file)

    assert os.path.exists(data_file), \
        "JSON file '{}' must exist.".format(data_file)

    with open(data_file) as f:
        the_json = json.load(f)

    assert the_json is not None
    return the_json
