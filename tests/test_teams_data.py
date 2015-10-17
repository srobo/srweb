
import urlparse

import helpers

def test_data_file():
    data = helpers.ensure_valid_json('resources/2016/teams.json')

    data_previous = helpers.ensure_valid_json('resources/2015/teams.json')

    for tla, info in data.items():
        assert 'URL' in info
        assert 'name' in info
        assert 'rookie' in info

        url = info['URL']
        assert len(url) > 0
        scheme, loc, _, _, _, _ = urlparse.urlparse(url)
        assert len(scheme) > 0
        assert len(loc) > 0

        name = info['name']
        assert len(name) > 0

        rookie = info['rookie']
        assert isinstance(rookie, bool)
        if rookie:
            assert tla not in data_previous
