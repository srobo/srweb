
import urlparse

import helpers

def test_data_file():
    data = helpers.ensure_valid_json('resources/2015/teams.json')

    for info in data.values():
        assert 'URL' in info
        assert 'name' in info

        url = info['URL']
        assert len(url) > 0
        scheme, loc, _, _, _, _ = urlparse.urlparse(url)
        assert len(scheme) > 0
        assert len(loc) > 0

        name = info['name']
        assert len(name) > 0
