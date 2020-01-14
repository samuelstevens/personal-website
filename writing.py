import sqlite3
import datetime
import os

essaytags = ['#essays', '#essay', '#writing']
blogtags = ['#blogs', '#blog']
todotags = ['#todo', '#draft']

tags = essaytags + blogtags + todotags

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
    return (not any(tag in p for tag in tags)) and p != ''

def make_metadata(title='', keywords = [], abstract = '', date=''):
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

def make_post(title, text, creation_date, group):
    date = datetime.datetime.fromtimestamp(dt_conv(creation_date))
    date_string = date.strftime('%m/%d/%Y')

    file_name = '-'.join(title.lower().split(' ')).replace("'", '').replace('"', '')
    file_extension = 'md'

    text = make_metadata(title=title, date=date_string) + '\n\n'.join([p for p in text.split('\n') if valid_p(p)])

    text = text.replace('->', '→')
    text = text.encode('ascii', errors='ignore').decode('ascii', errors='ignore')

    text += '\n\nPlease [email me](mailto:samuel.robert.stevens@gmail.com) if you have any comments or want to discuss further.'

    path = os.path.join(group, f'{file_name}.{file_extension}')

    with open(path, 'w') as f:
        f.write(text)

    return (title, file_name, date_string)

def write_index_file(posts, group):

    link_to_md = lambda t, l, d: f'{d}: [{t}](/{group}/{l})'

    text = make_metadata(title=group.capitalize(), keywords=['writing', 'blog'], abstract='A couple essays I\'ve written.') + f'# {group.capitalize()}' + '\n\n' + '\n\n'.join([link_to_md(*e) for e in posts])

    path = os.path.join(group, 'index.md')

    with open(path, 'w') as f:
        f.write(text)

def get_posts():
    con = sqlite3.connect(get_db_string(), detect_types=sqlite3.PARSE_COLNAMES)
    con.row_factory = sqlite3.Row
    c = con.cursor()

    essays = []
    posts = []

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
        is_essay = any(tag in row['text'] for tag in essaytags)
        is_blog = any(tag in row['text'] for tag in blogtags)
        is_draft = any(tag in row['text'] for tag in todotags)
        
        if is_essay and not is_draft:
            essays.append(make_post(*row, 'writing'))

        if is_blog and not is_draft:
            blogs.append(make_post(*row, 'blog'))

    con.close()
    write_index_file(essays, 'writing')
    write_index_file(posts, 'blog')

get_posts()
