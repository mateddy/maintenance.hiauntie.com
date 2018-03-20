import argparse
from mastodon import Mastodon
import os

parser = argparse.ArgumentParser()
parser.add_argument('--account', type=str, choices=['announcement','verbose'])
parser.add_argument('--msg', type=str)
parse_args = parser.parse_args()

if not os.path.exists('/home/hiauntie_bot/.hiauntie/config.json'):
    print('UAOWOLXS /home/hiauntie_bot/.hiauntie/config.json not exist')
    sys.exit(1)

CONFIG_DICT_DICT={
    'announcement':{
        'visibility'='public'
    },
    'verbose':{
        'visibility'='unlisted'
    },
}

user_secret_file = '/home/hiauntie_bot/.hiauntie/user_{}.secret'.format(parse_args.account)
config_dict=CONFIG_DICT_DICT[parse_args.account]

mastodon = Mastodon(
    client_id = '/home/hiauntie_bot/.hiauntie/bot_client.secret',
    access_token = user_secret_file,
    api_base_url = 'https://hiauntie.com'
)
mastodon.status_post(status=parse_args.msg, visibility=config_dict['visibility'])
