from mastodon import Mastodon
import os.path
from . import common
import sys

common.makedirs('/home/hiauntie_bot/.hiauntie')

if not os.path.exists('/home/hiauntie_bot/.hiauntie/config.json'):
    print('CXTOCNCW /home/hiauntie_bot/.hiauntie/config.json not exist')
    sys.exit(1)

config = common.read_json('/home/hiauntie_bot/.hiauntie/config.json')

if not os.path.exists('/home/hiauntie_bot/.hiauntie/bot_client.secret'):
    Mastodon.create_app(
         'hiauntie_bot',
         api_base_url = 'https://hiauntie.com',
         to_file = '/home/hiauntie_bot/.hiauntie/bot_client.secret'
    )

acc_list = [
    {
        'username':'luzi82+hiauntie@gmail.com',
        'password':config['ANNOUNCEMENT_ACCOUNT_PASSWORD'],
        'user_secret_file':'/home/hiauntie_bot/.hiauntie/user_announcement.secret',
    },
    {
        'username':'luzi82+hiauntie_verbose@gmail.com',
        'password':config['VERBOSE_ACCOUNT_PASSWORD'],
        'user_secret_file':'/home/hiauntie_bot/.hiauntie/user_verbose.secret',
    },
]

for acc in acc_list:
    if not os.path.exists(acc['user_secret_file']):
        mastodon = Mastodon(
            client_id = '/home/hiauntie_bot/.hiauntie/bot_client.secret',
            api_base_url = 'https://hiauntie.com'
        )
        mastodon.log_in(
            acc['username'],
            acc['password'],
            to_file = acc['user_secret_file']
        )

print('JBNJHSBX DONE')
