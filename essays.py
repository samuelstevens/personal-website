

import sqlite3
import datetime
import os

TAGS = ['blog', 'essays', 'essay']

def get_db_string():
    HOME = os.getenv('HOME', '')
    return os.path.join(HOME, 'Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/Application Data/database.sqlite')

# https://github.com/sbusso/Bear-Markdown-Export/blob/master/bear_export_sync.py
def dt_conv(dtnum):
    hour = 3600 # 60 * 60
    year = 365.25 * 24 * hour
    offset = year * 31 + hour * 6
    return dtnum + offset

def valid_p(p):
    hashtags = [ '#' + tag for tag in TAGS ]
    return (not any(tag in p for tag in hashtags)) and p != ''

def make_metadata(title, keywords = [], abstract = ''):
    # ---
    # title: HealthyAgers
    # author:
    #   - Sam Stevens
    # keywords: [fullstack, healthyagers, ohio state university, ruchika prakash, mindfulness]
    # abstract: HealthyAgers is a fullstack application I developed.
    # ---

    return f'''
---
title: {title}
author:
    - Sam Stevens
keywords: {keywords}
abstract: {abstract}
---
'''

def make_post(title, text, creation_date):
    date = datetime.datetime.fromtimestamp(dt_conv(creation_date))
    date_string = date.strftime('%B %Y')

    file_name = '-'.join(title.lower().split(' '))
    file_extension = 'md'

    text = make_metadata(title) + '\n\n'.join([p for p in text.split('\n') if valid_p(p)])

    text = text.replace('->', '→')

    path = os.path.join('essays', f'{file_name}.{file_extension}')

    with open(path, 'w') as f:
        f.write(text)

    return (title, file_name)

def write_index_file(essays):

    def link_to_md(title, link):
        return f'[{title}](/essays/{link})'

    print()

    text = make_metadata('Essays', ['writing', 'blog'], 'A couple essays I\'ve written.') + '# Essays' + '\n\n' + '\n\n'.join([link_to_md(*e) for e in essays])

    path = os.path.join('essays', 'index.md')

    with open(path, 'w') as f:
        f.write(text)

def get_essays():
    con = sqlite3.connect(get_db_string(), detect_types=sqlite3.PARSE_COLNAMES)
    con.row_factory = sqlite3.Row
    c = con.cursor()

    hashtags = ['#' + tag for tag in TAGS]

    essays = []

    for row in c.execute('''
        SELECT
            ztitle as title,
            ztext as text,
            zcreationdate as creation_date
        FROM
            zsfnote
        ORDER BY
            zcreationdate DESC
        '''):
        if any(tag in row['text'] for tag in hashtags) and '#todo' not in row['text'] and '#draft' not in row['text']:
            essays.append(make_post(*row))

    con.close()
    write_index_file(essays)

get_essays()
